import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spot_the_spy/applications/state_management/shared_prefs_provider.dart';

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