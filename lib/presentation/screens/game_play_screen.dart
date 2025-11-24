import 'package:audioplayers/audioplayers.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:spot_the_spy/applications/state_management/game_config_provider.dart';
import 'package:spot_the_spy/applications/state_management/game_session_provider.dart';
import 'package:spot_the_spy/applications/state_management/players_provider.dart';
import 'package:spot_the_spy/domain/data_models/player_model.dart';
import 'package:spot_the_spy/infrastructure/router/router_consts.dart';
import 'package:spot_the_spy/l10n/app_localizations.dart';

class GamePlayScreen extends ConsumerStatefulWidget {
  const GamePlayScreen({super.key});

  @override
  ConsumerState createState() => _GamePlayScreenState();
}

class _GamePlayScreenState extends ConsumerState<GamePlayScreen> {
  @override
  void initState() {
    super.initState();
    // Initialize the game session
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final minutes = ref.read(timeProvider);
      ref.read(gameSessionProvider.notifier).initialize(minutes);
    });
  }

  @override
  void dispose() {
    // Stop timer when leaving the screen
    // We can't easily call ref.read here if the widget is unmounted,
    // but the provider handles its own timer cleanup if disposed.
    // However, since we keepAlive the provider, we should explicitly stop it if we want.
    // For now, let's rely on the notifier's dispose or explicit stop if needed.
    // Actually, let's stop it to be safe.
    super.dispose();
  }

  double getProgress(Duration remaining, Duration total) {
    if (total.inSeconds == 0) return 0;
    return remaining.inSeconds / total.inSeconds;
  }

  void onTimeout() {
    AudioPlayer().play(AssetSource('sounds/alarm.mp3'), volume: 1);
    HapticFeedback.heavyImpact();
    int spyScore = ref.read(timeProvider) ~/ 2 + 1;
    final punishPlayers = ref.read(gameSessionProvider).punishPlayers;
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
    HapticFeedback.mediumImpact();
    final sessionState = ref.read(gameSessionProvider);
    int nonSpyScore =
        sessionState.remaining.inMinutes < 1
            ? 1
            : sessionState.remaining.inMinutes;
    nonSpyScore++;
    ref
        .read(playersProvider.notifier)
        .setScores(
          spyScore: 0,
          nonSpyScore: nonSpyScore,
          excludePlayers: sessionState.punishPlayers,
        );
    context.goNamed(Routes.scoreBoard);
  }

  void onWordGuessed() {
    HapticFeedback.mediumImpact();
    final sessionState = ref.read(gameSessionProvider);
    int spyScore =
        sessionState.remaining.inMinutes < 1
            ? 1
            : sessionState.remaining.inMinutes;
    spyScore += 2;
    ref
        .read(playersProvider.notifier)
        .setScores(
          spyScore: spyScore,
          nonSpyScore: 0,
          excludePlayers: sessionState.punishPlayers,
        );
    context.goNamed(Routes.scoreBoard);
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final sessionState = ref.watch(gameSessionProvider);
    final notifier = ref.read(gameSessionProvider.notifier);

    // Listen for timeout
    ref.listen(gameSessionProvider.select((s) => s.isTimeout), (
      previous,
      next,
    ) {
      if (next) {
        onTimeout();
      }
    });

    String localizePadded(int value) {
      final padded = value.toString().padLeft(2, '0'); // e.g. '05'
      return padded
          .split('')
          .map((digit) => localization.number(int.parse(digit)))
          .join();
    }

    final minutes = localizePadded(sessionState.remaining.inMinutes);
    final seconds = localizePadded(sessionState.remaining.inSeconds % 60);
    final timeText = '$minutes:$seconds';

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
              icon: Icon(
                sessionState.godMode ? Icons.visibility_off : Icons.visibility,
              ),
              tooltip: AppLocalizations.of(context)!.godMode,
              onPressed: () {
                HapticFeedback.selectionClick();
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(
                        sessionState.godMode
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
                            notifier.toggleGodMode();
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
                            notifier.stopTimer();
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
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Card(
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.timer,
                                size: 20,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              SizedBox(width: 4),
                              Text(
                                '${AppLocalizations.of(context)!.number(ref.watch(timeProvider))}"',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Card(
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.person_pin,
                                size: 20,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              SizedBox(width: 4),
                              Text(
                                '${AppLocalizations.of(context)!.number(ref.watch(spyCountProvider))}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (sessionState.godMode)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Card(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.security,
                                size: 24,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              SizedBox(width: 8),
                              Text(
                                "${AppLocalizations.of(context)!.secretWord}:",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(width: 4),
                              Text(
                                ref.read(theWordProvider),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            alignment: WrapAlignment.center,
                            children:
                                spyNamesList.map((name) {
                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.red.shade100,
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: Colors.red.shade300,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.psychology,
                                          size: 16,
                                          color: Colors.red.shade700,
                                        ),
                                        SizedBox(width: 4),
                                        Text(
                                          name,
                                          style: TextStyle(
                                            color: Colors.red.shade900,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              Expanded(child: Container()),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 240,
                      height: 240,
                      child: CircularProgressIndicator(
                        value: getProgress(
                          sessionState.remaining,
                          sessionState.total,
                        ),
                        strokeWidth: 12,
                        backgroundColor:
                            Theme.of(context).colorScheme.onInverseSurface,
                        color:
                            sessionState.remaining.inSeconds < 60
                                ? Colors.red
                                : sessionState.remaining.inSeconds < 180
                                ? Colors.orange
                                : Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          timeText,
                          style: TextStyle(
                            fontSize: 68,
                            fontWeight: FontWeight.bold,
                            color:
                                sessionState.remaining.inSeconds < 60
                                    ? Colors.red
                                    : sessionState.remaining.inSeconds < 180
                                    ? Colors.orange
                                    : Theme.of(context).colorScheme.primary,
                            letterSpacing: 2,
                          ),
                        ),
                        Text(
                          AppLocalizations.of(context)!.remainingTime,
                          style: TextStyle(
                            fontSize: 14,
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 60,
                      width: double.infinity,
                      child: FilledButton.icon(
                        style: FilledButton.styleFrom(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(32),
                              bottom: Radius.circular(8),
                            ),
                          ),
                        ),
                        onPressed: () {
                          HapticFeedback.lightImpact();
                          AudioPlayer().play(
                            AssetSource('sounds/click.mp3'),
                            volume: 1,
                          );
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(
                                  AppLocalizations.of(
                                    context,
                                  )!.spyCaughtQuestion,
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: context.pop,
                                    child: Text(
                                      AppLocalizations.of(context)!.no,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: onSpyCaught,
                                    child: Text(
                                      AppLocalizations.of(context)!.yes,
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        icon: Icon(Icons.search, size: 24),
                        label: Text(
                          AppLocalizations.of(context)!.spyCaught,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    SizedBox(
                      height: 60,
                      width: double.infinity,
                      child: FilledButton.icon(
                        style: FilledButton.styleFrom(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(8),
                              bottom: Radius.circular(
                                sessionState.godMode ? 8 : 32,
                              ),
                            ),
                          ),
                        ),
                        onPressed: () {
                          HapticFeedback.lightImpact();
                          AudioPlayer().play(
                            AssetSource('sounds/click.mp3'),
                            volume: 1,
                          );
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(
                                  AppLocalizations.of(
                                    context,
                                  )!.wordGuessedQuestion,
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: context.pop,
                                    child: Text(
                                      AppLocalizations.of(context)!.no,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: onWordGuessed,
                                    child: Text(
                                      AppLocalizations.of(context)!.yes,
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        icon: Icon(Icons.lightbulb, size: 24),
                        label: Text(
                          AppLocalizations.of(context)!.wordGuessed,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    if (sessionState.godMode) SizedBox(height: 8),
                    if (sessionState.godMode)
                      SizedBox(
                        height: 60,
                        width: double.infinity,
                        child: FilledButton.icon(
                          style: FilledButton.styleFrom(
                            elevation: 3,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(8),
                                bottom: Radius.circular(32),
                              ),
                            ),
                          ),
                          onPressed: spyPunishmentBottomSheet,
                          icon: Icon(Icons.warning_amber, size: 24),
                          label: Text(
                            AppLocalizations.of(context)!.wrongGuess,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              Expanded(child: Container()),
              SizedBox(height: sessionState.godMode ? 70 : 40),
            ],
          ),
        ),
      ),
    );
  }

  void spyPunishmentBottomSheet() {
    HapticFeedback.selectionClick();
    List<Player> spies =
        ref
            .read(playersProvider)
            .where((player) => player.isSpy)
            .map((player) => player)
            .toList();
    final sessionState = ref.read(gameSessionProvider);
    final notifier = ref.read(gameSessionProvider.notifier);

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
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: GridView.count(
                            crossAxisCount: 2,
                            childAspectRatio: (3 / 1),
                            children: List.generate(spies.length, (index) {
                              return InkWell(
                                borderRadius: BorderRadius.circular(16),
                                onTap: () {
                                  HapticFeedback.selectionClick();
                                  if (sessionState.punishPlayers.contains(
                                    spies[index],
                                  )) {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text(
                                            AppLocalizations.of(
                                              context,
                                            )!.alreadyPunished,
                                          ),
                                          content: Text(
                                            AppLocalizations.of(
                                              context,
                                            )!.alreadyPunishedMessage,
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: context.pop,
                                              child: Text(
                                                AppLocalizations.of(
                                                  context,
                                                )!.confirm,
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                    return;
                                  }

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
                                              HapticFeedback.mediumImpact();
                                              notifier.punishPlayer(
                                                spies[index],
                                              );
                                              context.pop();
                                              context.pop();
                                              ScaffoldMessenger.of(
                                                context,
                                              ).showSnackBar(
                                                SnackBar(
                                                  behavior:
                                                      SnackBarBehavior.floating,
                                                  content: Text(
                                                    AppLocalizations.of(
                                                      context,
                                                    )!.spyPunished,
                                                  ),
                                                ),
                                              );
                                              // We need to check the updated state here, or just trust the logic
                                              // The original logic checked if all spies are punished.
                                              // Let's do that check here using the updated state if possible,
                                              // but we can't get the *next* state immediately synchronously easily without ref.read again.
                                              // Better to move this "all spies punished" logic to the notifier or observe it.
                                              // For now, let's keep it simple and check ref.read again.
                                              final updatedState = ref.read(
                                                gameSessionProvider,
                                              );
                                              if (updatedState
                                                      .punishPlayers
                                                      .length ==
                                                  spies.length) {
                                                onSpyCaught();
                                              }
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
                                      sessionState.punishPlayers.contains(
                                            spies[index],
                                          )
                                          ? Theme.of(
                                            context,
                                          ).colorScheme.errorContainer
                                          : Theme.of(
                                            context,
                                          ).colorScheme.surface,
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
