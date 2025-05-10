import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:spot_the_spy/applications/state_management/game_config_provider.dart';
import 'package:spot_the_spy/applications/state_management/players_provider.dart';
import 'package:spot_the_spy/domain/data_models/player_model.dart';
import 'package:spot_the_spy/infrastructure/data/words_en.dart';
import 'package:spot_the_spy/infrastructure/router/router_consts.dart';
import 'package:spot_the_spy/l10n/app_localizations.dart';

class GamePlayScreen extends ConsumerStatefulWidget {
  const GamePlayScreen({super.key});

  @override
  ConsumerState createState() => _GamePlayScreenState();
}

class _GamePlayScreenState extends ConsumerState<GamePlayScreen> {
  late Duration remaining;
  Timer? timer;
  bool godMode = false;
  List<Player> punishPlayers = [];

  @override
  void initState() {
    super.initState();
    // Fetch duration from Riverpod provider
    remaining = Duration(minutes: ref.read(timeProvider));

    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (remaining.inSeconds == 0) {
        timer?.cancel();
        onTimeout();
      } else {
        setState(() {
          remaining -= const Duration(seconds: 1);
        });
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void onTimeout() {
    AudioPlayer().play(AssetSource('sounds/alarm.mp3'), volume: 1);
    int spyScore = ref.read(timeProvider) ~/ 2 + 1;
    ref
        .read(playersProvider.notifier)
        .setScores(
          spyScore: spyScore,
          nonSpyScore: 0,
          excludePlayers: punishPlayers,
        );
    context.goNamed(Routes.scoreBoard);
  }

  void onSpyCaught() {
    int nonSpyScore = remaining.inMinutes < 1 ? 1 : remaining.inMinutes;
    nonSpyScore++;
    ref
        .read(playersProvider.notifier)
        .setScores(
          spyScore: 0,
          nonSpyScore: nonSpyScore,
          excludePlayers: punishPlayers,
        );
    context.goNamed(Routes.scoreBoard);
  }

  void onWordGuessed() {
    int spyScore = remaining.inMinutes < 1 ? 1 : remaining.inMinutes;
    spyScore += 2;
    ref
        .read(playersProvider.notifier)
        .setScores(
          spyScore: spyScore,
          nonSpyScore: 0,
          excludePlayers: punishPlayers,
        );
    context.goNamed(Routes.scoreBoard);
  }

  @override
  Widget build(BuildContext context) {
    final timeText =
        '${remaining.inMinutes.toString().padLeft(2, '0')}:${(remaining.inSeconds % 60).toString().padLeft(2, '0')}';

    List<String> spyNamesList =
        ref
            .read(playersProvider)
            .where((player) => player.isSpy)
            .map((player) => player.name)
            .toList();

    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "${AppLocalizations.of(context)!.round} ${AppLocalizations.of(context)!.number(ref.read(currentRoundProvider))}",
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(godMode ? Icons.visibility : Icons.visibility_off),
              tooltip: AppLocalizations.of(context)!.godMode,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(
                        godMode
                            ? AppLocalizations.of(context)!.deactivateGodMode
                            : AppLocalizations.of(context)!.activateGodMode,
                      ),
                      content: Text(
                        AppLocalizations.of(context)!.godModeDescription,
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: context.pop,
                          child: Text(AppLocalizations.of(context)!.no),
                        ),
                        TextButton(
                          child: Text(AppLocalizations.of(context)!.yes),
                          onPressed: () {
                            setState(() {
                              godMode = !godMode;
                            });
                            context.pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
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
              Wrap(
                spacing: 8,
                children: [
                  Chip(
                    avatar: Icon(Icons.timer, size: 20),
                    label: Text(
                      '${AppLocalizations.of(context)!.time}: ${AppLocalizations.of(context)!.number(ref.watch(timeProvider))}"',
                    ),
                  ),
                  if (godMode)
                    Chip(
                      avatar: Icon(Icons.security, size: 20),
                      label: Text(
                        "${AppLocalizations.of(context)!.secretWord}: ${ref.read(theWordProvider)}",
                      ),
                    ),
                  Chip(
                    avatar: Icon(Icons.person_pin, size: 20),
                    label: Text(
                      '${AppLocalizations.of(context)!.spyCount}: ${AppLocalizations.of(context)!.number(ref.watch(spyCountProvider))}',
                    ),
                  ),
                  if (godMode)
                    ...spyNamesList.map((name) {
                      return Chip(
                        // backgroundColor:
                        // punishPlayers.contains(name)
                        //     ? Theme.of(
                        //   context,
                        // ).colorScheme.errorContainer
                        //     : null,
                        avatar: Icon(Icons.person, size: 20),
                        label: Text(name),
                      );
                    }),
                ],
              ),
              Expanded(child: Container()),
              Text(
                AppLocalizations.of(context)!.remainingTime,
                style: TextStyle(fontSize: 20),
              ),
              Text(
                timeText,
                style: TextStyle(
                  fontSize: 62,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                height: 54,
                width: MediaQuery.of(context).size.width / 1.4,
                child: FilledButton.tonal(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(
                            AppLocalizations.of(context)!.spyCaughtQuestion,
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: context.pop,
                              child: Text(AppLocalizations.of(context)!.no),
                            ),
                            TextButton(
                              onPressed: onSpyCaught,
                              child: Text(AppLocalizations.of(context)!.yes),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text(
                    AppLocalizations.of(context)!.spyCaught,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              SizedBox(height: 12),
              SizedBox(
                height: 54,
                width: MediaQuery.of(context).size.width / 1.4,
                child: FilledButton.tonal(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(
                            AppLocalizations.of(context)!.wordGuessedQuestion,
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: context.pop,
                              child: Text(AppLocalizations.of(context)!.no),
                            ),
                            TextButton(
                              onPressed: onWordGuessed,
                              child: Text(AppLocalizations.of(context)!.yes),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text(
                    AppLocalizations.of(context)!.wordGuessed,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              if (godMode) SizedBox(height: 12),
              if (godMode)
                SizedBox(
                  height: 54,
                  width: MediaQuery.of(context).size.width / 1.4,
                  child: FilledButton.tonal(
                    onPressed: spyPunishmentBottomSheet,
                    child: Text(
                      AppLocalizations.of(context)!.wrongGuess,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),

              Expanded(child: Container()),
              SizedBox(height: godMode ? 80 : 40),
            ],
          ),
        ),
      ),
    );
  }

  void spyPunishmentBottomSheet() {
    List<Player> spies =
        ref
            .read(playersProvider)
            .where((player) => player.isSpy)
            .map((player) => player)
            .toList();
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder:
          (builder) => SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        subtitle: Text(
                          AppLocalizations.of(context)!.spyWrongGuessPenalty,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Expanded(
                        child: GridView.count(
                          crossAxisCount: 2,
                          childAspectRatio: (3 / 1),
                          children: List.generate(spies.length, (index) {
                            return InkWell(
                              borderRadius: BorderRadius.circular(16),
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text(
                                        AppLocalizations.of(
                                          context,
                                        )!.punishSpyQuestion,
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: context.pop,
                                          child: Text(
                                            AppLocalizations.of(context)!.no,
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            if (!punishPlayers.contains(
                                              spies[index],
                                            )) {
                                              punishPlayers.add(spies[index]);
                                            }
                                            context.pop();
                                            context.pop();
                                          },
                                          child: Text(
                                            AppLocalizations.of(context)!.yes,
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Card(
                                color:
                                    punishPlayers.contains(spies[index])
                                        ? Theme.of(
                                          context,
                                        ).colorScheme.errorContainer
                                        : null,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                  ),
                                  child: Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.person,
                                        color:
                                            Theme.of(
                                              context,
                                            ).colorScheme.primary,
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        spies[index].name,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
    );
  }
}
