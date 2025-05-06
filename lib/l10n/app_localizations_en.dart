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
}
