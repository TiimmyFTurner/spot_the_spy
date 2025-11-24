import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spot_the_spy/applications/state_management/game_config_provider.dart';
import 'package:spot_the_spy/applications/state_management/players_provider.dart';
import 'package:spot_the_spy/applications/state_management/shared_prefs_provider.dart';

void main() {
  late ProviderContainer container;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    container = ProviderContainer(
      overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
    );
  });

  tearDown(() {
    container.dispose();
  });

  test('PlayersNotifier sets roles correctly', () {
    // Setup dependencies
    container.read(playerNamesProvider.notifier).addPlayer('P1');
    container.read(playerNamesProvider.notifier).addPlayer('P2');
    container.read(playerNamesProvider.notifier).addPlayer('P3');
    container.read(wordsListProvider.notifier).set(['Word1', 'Word2']);
    container.read(spyCountProvider.notifier).set(1);

    // Initialize players
    container.read(playersProvider.notifier).set();

    // Set roles
    container.read(playersProvider.notifier).setRoles();

    final players = container.read(playersProvider);
    expect(players.length, 3);
    expect(players.where((p) => p.isSpy).length, 1);
    expect(container.read(theWordProvider), isNotEmpty);
  });

  test('PlayersNotifier calculates scores correctly', () {
    // Setup players manually for testing score logic

    // We need to hack the state a bit or use set() then modify
    // Since we can't easily set state directly from outside without a setter in the notifier (which we don't have exposed for testing easily),
    // we will use the normal flow.

    container.read(playerNamesProvider.notifier).addPlayer('Spy');
    container.read(playerNamesProvider.notifier).addPlayer('Civilian');
    container.read(wordsListProvider.notifier).set(['Word1']);
    container.read(spyCountProvider.notifier).set(1);

    container.read(playersProvider.notifier).set();
    // Force roles for deterministic test?
    // setRoles shuffles, so we can't guarantee who is spy.
    // However, we can check if scores increase correctly regardless of who is who.

    container.read(playersProvider.notifier).setRoles();
    final playersBefore = container.read(playersProvider);
    final spy = playersBefore.firstWhere((p) => p.isSpy);
    final civilian = playersBefore.firstWhere((p) => !p.isSpy);

    // Spy wins
    container
        .read(playersProvider.notifier)
        .setScores(spyScore: 2, nonSpyScore: 0);

    final playersAfter = container.read(playersProvider);
    final spyAfter = playersAfter.firstWhere((p) => p.name == spy.name);
    final civilianAfter = playersAfter.firstWhere(
      (p) => p.name == civilian.name,
    );

    expect(spyAfter.score, 2);
    expect(civilianAfter.score, 0);
  });
}
