import 'package:action_slider/action_slider.dart';
import 'package:audioplayers/audioplayers.dart';
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
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.roleReveal),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.fiber_new),
              onPressed: () {
                HapticFeedback.selectionClick();
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(
                        AppLocalizations.of(context)!.newGameQuestion,
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: context.pop,
                          child: Text(AppLocalizations.of(context)!.cancel),
                        ),
                        TextButton(
                          child: Text(AppLocalizations.of(context)!.newGame),
                          onPressed: () {
                            context.pop();
                            ref.invalidate(currentRoundProvider);
                            context.goNamed(Routes.home);
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
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
                        HapticFeedback.heavyImpact();
                        AudioPlayer().play(
                          AssetSource('sounds/click.mp3'),
                          volume: 1,
                        );
                        controller.success();
                        await Future.delayed(const Duration(seconds: 1));
                        if (!context.mounted) return;
                        context.goNamed(Routes.gamePlay);
                      },
                      child: Text(AppLocalizations.of(context)!.slideToPlay),
                    ),
                  ),
                )
                : Padding(
                  padding: const EdgeInsets.all(12),
                  child: GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: (3 / 1),
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    children: List.generate(players.length, (index) {
                      return InkWell(
                        borderRadius: BorderRadius.circular(20),
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
                              elevation: 3,
                              shadowColor: Theme.of(
                                context,
                              ).colorScheme.primary.withValues(alpha: 0.3),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color:
                                            Theme.of(
                                              context,
                                            ).colorScheme.primaryContainer,
                                      ),
                                      child: Icon(
                                        Icons.person,
                                        color:
                                            Theme.of(
                                              context,
                                            ).colorScheme.primary,
                                        size: 24,
                                      ),
                                    ),
                                    SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        players[index].name,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        onTap: () {
                          HapticFeedback.mediumImpact();
                          AudioPlayer().play(
                            AssetSource('sounds/click.mp3'),
                            volume: 1,
                          );
                          showModalBottomSheet(
                            context: context,
                            showDragHandle: true,
                            isScrollControlled: true,
                            builder:
                                (builder) => SafeArea(
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Container(
                                          width: 80,
                                          height: 80,
                                          margin: const EdgeInsets.only(
                                            bottom: 16,
                                          ),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            gradient: LinearGradient(
                                              colors:
                                                  players[index].isSpy
                                                      ? [
                                                        Colors.red.shade400,
                                                        Colors.red.shade700,
                                                      ]
                                                      : [
                                                        Theme.of(
                                                          context,
                                                        ).colorScheme.primary,
                                                        Theme.of(
                                                          context,
                                                        ).colorScheme.tertiary,
                                                      ],
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                            ),
                                          ),
                                          child: Icon(
                                            players[index].isSpy
                                                ? Icons.psychology
                                                : Icons.verified_user,
                                            color: Colors.white,
                                            size: 40,
                                          ),
                                        ),
                                        Text(
                                          players[index].name,
                                          style: TextStyle(
                                            fontSize: 28,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(height: 24),
                                        Container(
                                          padding: const EdgeInsets.all(20),
                                          decoration: BoxDecoration(
                                            color:
                                                players[index].isSpy
                                                    ? Colors.red.shade50
                                                    : Theme.of(context)
                                                        .colorScheme
                                                        .primaryContainer,
                                            borderRadius: BorderRadius.circular(
                                              16,
                                            ),
                                            border: Border.all(
                                              color:
                                                  players[index].isSpy
                                                      ? Colors.red.shade200
                                                      : Theme.of(context)
                                                          .colorScheme
                                                          .primary
                                                          .withValues(alpha: 0.3),
                                              width: 2,
                                            ),
                                          ),
                                          child: Text(
                                            players[index].isSpy
                                                ? AppLocalizations.of(
                                                  context,
                                                )!.isSpy
                                                : AppLocalizations.of(
                                                      context,
                                                    )!.theSecretWordIs +
                                                    ref.read(theWordProvider),
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                              color:
                                                  players[index].isSpy
                                                      ? Colors.red.shade900
                                                      : Theme.of(context)
                                                          .colorScheme
                                                          .onPrimaryContainer,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        const SizedBox(height: 24),
                                        SizedBox(
                                          height: 55,
                                          child: FilledButton(
                                            onPressed: () {
                                              HapticFeedback.lightImpact();
                                              context.pop();
                                            },
                                            style: FilledButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                              ),
                                            ),
                                            child: Text(
                                              AppLocalizations.of(
                                                context,
                                              )!.gotIt,
                                              style: TextStyle(fontSize: 20),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                      ],
                                    ),
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
      ),
    );
  }
}
