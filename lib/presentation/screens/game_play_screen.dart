import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:spot_the_spy/applications/state_management/game_config_provider.dart';
import 'package:spot_the_spy/applications/state_management/players_provider.dart';
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

  @override
  void initState() {
    super.initState();
    // Fetch duration from Riverpod provider
    remaining = Duration(minutes: ref.read(timeProvider));

    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (remaining.inSeconds == 0) {
        timer?.cancel();
        onTimeout(); // ✅ Call your timeout logic
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
    ref.read(playersProvider.notifier).setScores(spyScore: 3, nonSpyScore: 0);
    context.goNamed(Routes.scoreBoard);
  }

  void onSpyCaught() {
    int nonSpyScore = remaining.inMinutes < 1 ? 1 : remaining.inMinutes;
    nonSpyScore++;
    ref
        .read(playersProvider.notifier)
        .setScores(spyScore: 0, nonSpyScore: nonSpyScore);
    context.goNamed(Routes.scoreBoard);
  }

  void onWordGuessed() {
    int spyScore = remaining.inMinutes < 1 ? 1 : remaining.inMinutes;
    spyScore++;
    ref
        .read(playersProvider.notifier)
        .setScores(spyScore: spyScore, nonSpyScore: 0);
    context.goNamed(Routes.scoreBoard);
  }

  @override
  Widget build(BuildContext context) {
    final timeText =
        '${remaining.inMinutes.toString().padLeft(2, '0')}:${(remaining.inSeconds % 60).toString().padLeft(2, '0')}';

    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.round),
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
                    avatar: Icon(Icons.person_pin, size: 20),
                    label: Text(
                      '${AppLocalizations.of(context)!.spyCount}: ${AppLocalizations.of(context)!.number(ref.watch(spyCountProvider))}',
                    ),
                  ),
                  SizedBox(width: 8),
                  Chip(
                    avatar: Icon(Icons.timer, size: 20),
                    label: Text(
                      '${AppLocalizations.of(context)!.time}: ${AppLocalizations.of(context)!.number(ref.watch(timeProvider))}"',
                    ),
                  ),
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
                  color: Theme.of(context).primaryColor,
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                height: 54,
                width: MediaQuery.of(context).size.width / 1.4,
                child: FilledButton.tonal(
                  onPressed: onWordGuessed,
                  child: Text(
                    AppLocalizations.of(context)!.wordGuessed,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              SizedBox(height: 12),
              SizedBox(
                height: 54,
                width: MediaQuery.of(context).size.width / 1.4,
                child: FilledButton.tonal(
                  onPressed: onSpyCaught,
                  child: Text(
                    AppLocalizations.of(context)!.spyCaught,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              Expanded(child: Container()),
            ],
          ),
        ),
      ),
    );
  }
}
