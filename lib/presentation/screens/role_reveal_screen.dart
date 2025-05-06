import 'package:action_slider/action_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:spot_the_spy/applications/state_management/game_config_provider.dart';
import 'package:spot_the_spy/applications/state_management/players_provider.dart';
import 'package:spot_the_spy/domain/data_models/player_model.dart';
import 'package:spot_the_spy/infrastructure/router/router_consts.dart';
import 'package:spot_the_spy/l10n/app_localizations.dart';

class RoleRevealScreen extends ConsumerStatefulWidget {
  const RoleRevealScreen({super.key});

  @override
  ConsumerState createState() => _RoleRevealScreenState();
}

class _RoleRevealScreenState extends ConsumerState<RoleRevealScreen> {
  bool _lock = false;
  late List<Player> players;

  @override
  void initState() {
    players = [...ref.read(playersProvider)];
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((Duration d) {
      setState(() {
        _lock = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.roleReveal),
        centerTitle: true,
      ),
      body:
          players.isEmpty
              ? Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: ActionSlider.standard(
                    sliderBehavior: SliderBehavior.stretch,
                    backgroundColor: Theme.of(context).colorScheme.onPrimary,
                    action: (controller) async {
                      HapticFeedback.lightImpact();
                      controller.success();
                      await Future.delayed(const Duration(seconds: 1));
                      if (!context.mounted) return;
                      context.goNamed(Routes.gamePlay,);

                    },
                    child: Text(AppLocalizations.of(context)!.slideToPlay),
                  ),
                ),
              )
              : Padding(
                padding: const EdgeInsets.all(10),
                child: GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: (3 / 1),
                  children: List.generate(players.length, (index) {
                    return InkWell(
                      borderRadius: BorderRadius.circular(16),
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 400),
                        opacity: _lock ? 1 : 0,
                        curve: Curves.easeInOutQuart,
                        child: AnimatedPadding(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.ease,
                          padding:
                              _lock
                                  ? EdgeInsets.zero
                                  : EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height,
                                  ),
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Icon(
                                    Icons.person,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      players[index].name,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      onTap: () {
                        HapticFeedback.lightImpact();
                        showModalBottomSheet(
                          context: context,
                          showDragHandle: true,
                          builder:
                              (builder) => SafeArea(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Expanded(
                                      child: SingleChildScrollView(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: <Widget>[
                                            Text(
                                              players[index].name,
                                              style: const TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                            const SizedBox(height: 12),
                                            Padding(
                                              padding: const EdgeInsets.all(
                                                8.0,
                                              ),
                                              child: Center(
                                                child: Text(
                                                  players[index].isSpy
                                                      ? AppLocalizations.of(
                                                        context,
                                                      )!.isSpy
                                                      : AppLocalizations.of(
                                                            context,
                                                          )!.theSecretWordIs +
                                                          ref.read(
                                                            theWordProvider,
                                                          ),
                                                  style: const TextStyle(
                                                    fontSize: 18,
                                                  ),
                                                  textAlign: TextAlign.justify,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 10,
                                      ),
                                      child: SizedBox(
                                        height: 55,
                                        child: FilledButton.tonal(
                                          onPressed: () {
                                            context.pop();
                                          },
                                          child: Text(
                                            AppLocalizations.of(context)!.gotIt,
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                        ).then(
                          (value) => setState(() {
                            players.remove(players[index]);
                          }),
                        );
                      },
                    );
                  }),
                ),
              ),
    );
  }
}
