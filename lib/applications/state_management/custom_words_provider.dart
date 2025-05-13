import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spot_the_spy/applications/state_management/shared_prefs_provider.dart';

part 'custom_words_provider.g.dart';

@Riverpod(keepAlive: true)
class CustomWordsActive extends _$CustomWordsActive {
  @override
  bool build() => false;

  void toggle() => state = !state;
}

@Riverpod(keepAlive: true)
class CustomWords extends _$CustomWords {
  late SharedPreferences _prefs;

  @override
  List<String> build() {
    _prefs = ref.watch(sharedPreferencesProvider);
    List<String> words = _prefs.getStringList('customWords') ?? [];
    return words;
  }
  void addWord(String word) {
    state = [...state, word];
    _prefs.setStringList('customWords', state);
  }

  void removeWord(String removeWord) {
    state = [
      for (final word in state)
        if (word != removeWord) word,
    ];
    _prefs.setStringList('customWords', state);
  }

}