import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spot_the_spy/applications/state_management/game_config_provider.dart';
import 'package:spot_the_spy/applications/state_management/shared_prefs_provider.dart';
import 'package:spot_the_spy/domain/data_models/player_model.dart';

part 'players_provider.g.dart';

// --- PlayerNames ---
@Riverpod(keepAlive: true)
class PlayerNames extends _$PlayerNames {
  late SharedPreferences _prefs;

  @override
  List<String> build() {
    _prefs = ref.watch(sharedPreferencesProvider);
    List<String> players = _prefs.getStringList('lastPlayers') ?? [];
    return players;
  }

  void addPlayer(String name) {
    state = [...state, name];
    _prefs.setStringList('lastPlayers', state);
  }

  void removePlayer(String name) {
    state = [
      for (final player in state)
        if (player != name) player,
    ];
    _prefs.setStringList('lastPlayers', state);
  }
}

// --- PlayerNames ---
@Riverpod(keepAlive: true)
class Players extends _$Players {
  @override
  List<Player> build() => [];

  void set() {
    List<String> playerNames = ref.read(playerNamesProvider);
    List<Player> players = [];
    for (var i = 0; i < playerNames.length; i++) {
      players.add(Player(name: playerNames[i], isSpy: false, score: 0));
    }
    state = players;
  }

  void setRoles(wordList) {
    wordList.shuffle();
    int spyCount = ref.read(spyCountProvider);
    String theWord = wordList[0];
    ref.read(theWordProvider.notifier).set(theWord);
    List<Player> players = state;
    players.shuffle();
    for (var i = 0; i < players.length; i++) {
      if (i < spyCount) {
        players[i] = players[i].copyWith(isSpy: true);
      } else {
        players[i] = players[i].copyWith(isSpy: false);
      }
    }
    players.shuffle();
    state = players;
  }

  void setScores({
    required int spyScore,
    required int nonSpyScore,
    List<Player> excludePlayers = const [],
  }) {
    List<Player> players = state;
    for (var i = 0; i < players.length; i++) {
      if (players[i].isSpy) {
        players[i] =
            excludePlayers.contains(players[i])
                ? players[i].copyWith(score: players[i].score - 2)
                : players[i].copyWith(score: players[i].score + spyScore);
      } else {
        players[i] = players[i].copyWith(score: players[i].score + nonSpyScore);
      }
    }
    state = players;
  }
}
