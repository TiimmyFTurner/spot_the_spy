import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:spot_the_spy/applications/state_management/game_session_provider.dart';
import 'package:spot_the_spy/domain/data_models/player_model.dart';

void main() {
  late ProviderContainer container;

  setUp(() {
    container = ProviderContainer();
  });

  tearDown(() {
    container.dispose();
  });

  test('GameSessionNotifier initializes correctly', () {
    final notifier = container.read(gameSessionProvider.notifier);
    notifier.initialize(5);

    final state = container.read(gameSessionProvider);
    expect(state.remaining.inMinutes, 5);
    expect(state.total.inMinutes, 5);
    expect(state.isTimerRunning, true);
    expect(state.godMode, false);
    expect(state.punishPlayers, isEmpty);
  });

  test('GameSessionNotifier toggles god mode', () {
    final notifier = container.read(gameSessionProvider.notifier);
    notifier.initialize(5);

    expect(container.read(gameSessionProvider).godMode, false);
    notifier.toggleGodMode();
    expect(container.read(gameSessionProvider).godMode, true);
    notifier.toggleGodMode();
    expect(container.read(gameSessionProvider).godMode, false);
  });

  test('GameSessionNotifier punishes player', () {
    final notifier = container.read(gameSessionProvider.notifier);
    notifier.initialize(5);

    final player = Player(name: 'Test', isSpy: true, score: 0);
    notifier.punishPlayer(player);

    expect(container.read(gameSessionProvider).punishPlayers, contains(player));
  });

  test('GameSessionNotifier stops timer', () {
    final notifier = container.read(gameSessionProvider.notifier);
    notifier.initialize(5);

    expect(container.read(gameSessionProvider).isTimerRunning, true);
    notifier.stopTimer();
    expect(container.read(gameSessionProvider).isTimerRunning, false);
  });

  test('GameSessionNotifier timer ticks down', () async {
    // We can't easily test async timer with real time in unit test without fake async
    // But we can check if state changes after a delay
    final notifier = container.read(gameSessionProvider.notifier);
    notifier.initialize(1); // 1 minute

    final initialRemaining = container.read(gameSessionProvider).remaining;

    // Wait for 2 seconds
    await Future.delayed(const Duration(seconds: 2));

    final currentRemaining = container.read(gameSessionProvider).remaining;
    expect(currentRemaining < initialRemaining, true);
  });
}
