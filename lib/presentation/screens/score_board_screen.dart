import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:spot_the_spy/applications/state_management/game_config_provider.dart';
import 'package:spot_the_spy/applications/state_management/players_provider.dart';
import 'package:spot_the_spy/domain/data_models/player_model.dart';
import 'package:spot_the_spy/infrastructure/data/categories_en.dart';
import 'package:spot_the_spy/infrastructure/data/categories_fa.dart';
import 'package:spot_the_spy/infrastructure/router/router_consts.dart';
import 'package:spot_the_spy/l10n/app_localizations.dart';
import 'package:spot_the_spy/l10n/l10n.dart';

class ScoreBoardScreen extends ConsumerStatefulWidget {
  const ScoreBoardScreen({super.key});

  @override
  ConsumerState createState() => _ScoreBoardScreenState();
}

class _ScoreBoardScreenState extends ConsumerState<ScoreBoardScreen> {

  @override
  Widget build(BuildContext context) {
    Locale locale = Localizations.localeOf(context);
    bool lastRound =
        ref.read(currentRoundProvider) == ref.read(roundCountProvider);
    List<Player> players = ref.watch(playersProvider);
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.scoreboard),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.fiber_new),
              onPressed: () {
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
        body: SafeArea(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Chip(
                    avatar: Icon(Icons.autorenew_rounded, size: 20),
                    label: Text(
                      '${AppLocalizations.of(context)!.round}: ${AppLocalizations.of(context)!.number(ref.read(currentRoundProvider))}/${AppLocalizations.of(context)!.number(ref.read(roundCountProvider))}',
                    ),
                  ),
                  SizedBox(width: 8),
                  Chip(
                    avatar: Icon(Icons.security, size: 20),
                    label: Text(
                      "${AppLocalizations.of(context)!.secretWord}: ${ref.read(theWordProvider)}",
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Card(
                  color: Theme.of(context).colorScheme.surfaceContainer,
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      children: [
                        SizedBox(width: 40),
                        Text(
                          AppLocalizations.of(context)!.player,
                          style: TextStyle(fontSize: 16),
                        ),
                        Expanded(flex: 4, child: Container()),
                        Text(
                          AppLocalizations.of(context)!.score,
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  shrinkWrap: true,
                  itemCount: players.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    return index < players.length
                        ? listItemPlayer(players[index])
                        : const SizedBox(height: 8);
                  },
                ),
              ),
              SizedBox(
                height: 70,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                  child: FilledButton(
                    child: Text(
                      lastRound
                          ? AppLocalizations.of(context)!.newGame
                          : AppLocalizations.of(context)!.startNextRound,
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      HapticFeedback.lightImpact();
                      if (lastRound) {
                        ref.invalidate(currentRoundProvider);
                        context.goNamed(Routes.home);
                      } else {
                        List<String> selectedCategories = ref.watch(
                          categoryProvider,
                        );
                        List<String> wordsList = [];
                        for (var i = 0; i < selectedCategories.length; i++) {
                          wordsList.addAll(
                            (locale == L10n.en
                                    ? categoriesEN[selectedCategories[i]]
                                        ?.toList()
                                    : categoriesFA[selectedCategories[i]]
                                        ?.toList()) ??
                                [],
                          );
                        }
                        ref.read(playersProvider.notifier).setRoles(wordsList);
                        ref.read(currentRoundProvider.notifier).next();
                        context.goNamed(Routes.roleReveal);
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget listItemPlayer(player) {
    return Card(
      color: Theme.of(context).colorScheme.surfaceContainer,
      elevation: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(15),
            child: Icon(
              Icons.person,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              player.name,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 16),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              player.isSpy ? AppLocalizations.of(context)!.spy : '',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 16),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                player.score.toString(),
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
