// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get newGame => 'New Game';

  @override
  String get howToPlay => 'How To Play';

  @override
  String get settings => 'Settings';

  @override
  String addPlayers(int value) {
    final intl.NumberFormat valueNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String valueString = valueNumberFormat.format(value);

    return 'Add Players ($valueString)';
  }

  @override
  String number(int value) {
    final intl.NumberFormat valueNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String valueString = valueNumberFormat.format(value);

    return '$valueString';
  }

  @override
  String get help => 'Help';

  @override
  String get addPlayersHelpMessage => 'On this page, you can add as many players as you like.';

  @override
  String get back => 'Back';

  @override
  String get playerName => 'Player Name';

  @override
  String get playerCountError => 'You need at least 3 players to start the game.';

  @override
  String get goToGameSetup => 'Next: Set Game Rules';

  @override
  String themeMode(String theme_mode) {
    String _temp0 = intl.Intl.selectLogic(
      theme_mode,
      {
        'dark': 'Dark',
        'light': 'Light',
        'system': 'System Default',
        'other': 'Theme Mode',
      },
    );
    return '$_temp0';
  }

  @override
  String get chooseTheme => 'Choose Theme';

  @override
  String get confirm => 'Confirm';

  @override
  String languageMode(String language) {
    String _temp0 = intl.Intl.selectLogic(
      language,
      {
        'en': 'English',
        'fa': 'فارسی',
        'system': 'System Default',
        'other': 'Language',
      },
    );
    return '$_temp0';
  }

  @override
  String get cancel => 'Cancel';

  @override
  String get language => 'Language';

  @override
  String get goToRoleReveal => 'Next: Reveal Roles';

  @override
  String get roleReveal => 'Reveal Roles';

  @override
  String get gameSetup => 'Game Setup';

  @override
  String get category => 'Category';

  @override
  String get time => 'Round Time';

  @override
  String get roundCount => 'Number of Rounds';

  @override
  String get spyCount => 'Number of Spies';

  @override
  String get minute => 'Minute';

  @override
  String get isSpy => 'You\'re a Spy';

  @override
  String get gotIt => 'Got It';

  @override
  String get theSecretWordIs => 'The secret word is: ';

  @override
  String get slideToPlay => 'Slide to Play';

  @override
  String get round => 'Round';

  @override
  String get wordGuessed => 'Word Guessed';

  @override
  String get spyCaught => 'Spy Caught';

  @override
  String get remainingTime => 'Remaining Time';

  @override
  String get scoreboard => 'Scoreboard';

  @override
  String get spy => 'Spy';

  @override
  String get player => 'Player';

  @override
  String get score => 'Score';

  @override
  String get startNextRound => 'Start Next Round';

  @override
  String get newGameQuestion => 'New Game?';

  @override
  String get wordGuessedQuestion => 'Spy Guessed the Word?';

  @override
  String get spyCaughtQuestion => 'Spy Got Caught?';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get categoryCountError => 'You need at least 1 category to play the game.';

  @override
  String get selectAll => 'Select All';

  @override
  String get secretWord => 'Secret Word';

  @override
  String get spies => 'Spies';

  @override
  String get godMode => 'God Mode';

  @override
  String get activateGodMode => 'Activate God Mode?';

  @override
  String get deactivateGodMode => 'Deactivate God Mode?';

  @override
  String get godModeDescription => 'God Mode lets you view secret words and spy identities. Useful for moderators.';
}
