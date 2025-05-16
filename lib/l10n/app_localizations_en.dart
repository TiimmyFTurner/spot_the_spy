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
  String get categoryCountError => 'You need at least one category to start the game.';

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

  @override
  String get duplicatePlayerNameError => 'This player already exists.';

  @override
  String get spyWrongGuessPenalty => 'If a spy guesses the word and gets it wrong, they lose 2 points and are excluded from the spy team\'s reward.';

  @override
  String get wrongGuess => 'Wrong Guess';

  @override
  String get punishSpyQuestion => 'Punish this spy?';

  @override
  String get alreadyPunishedMessage => 'This spy has already been punished.';

  @override
  String get alreadyPunished => 'Already punished';

  @override
  String get spyPunished => 'Spy was punished.';

  @override
  String get customWords => 'Custom Words';

  @override
  String get switchToCategories => 'Switch to categories';

  @override
  String get switchToCustomWords => 'Switch to custom words';

  @override
  String get addWord => 'Add Word';

  @override
  String get enterWord => 'Enter word';

  @override
  String get add => 'Add';

  @override
  String get emptyCustomWordsError => 'You need at least one word to start the game.';

  @override
  String get emptyCustomWordsHint => 'Add at least one word to begin.\nMore words help prevent duplicates in future rounds.';

  @override
  String get duplicateWordError => 'This word has already been added.';

  @override
  String get howToPlay_title => 'Game Rules';

  @override
  String get rolesAssigned_title => 'Roles Are Assigned';

  @override
  String get rolesAssigned_desc => 'At the start of each game, some players are randomly chosen as the Spy. All other players receive the same secret word (e.g., \'Airport\', \'Restaurant\').';

  @override
  String get askQuestions_title => 'Ask Each Other Questions';

  @override
  String get askQuestions_desc => 'Players take turns asking subtle questions (e.g., \'Is it usually crowded there?\'). The goal is to show you know the word without making it too obvious.';

  @override
  String get beCareful_title => 'Be Careful!';

  @override
  String get beCareful_desc => 'If you\'re not the spy: spot who doesn\'t know the word without revealing it.\nIf you\'re the spy: blend in and try to guess the word before you\'re caught.';

  @override
  String get accuseOrGuess_title => 'Accuse or Guess';

  @override
  String get accuseOrGuess_desc => 'Any player can accuse someone of being the spy. If everyone agrees, the accused reveals their role.\n\n• If the spy is caught: other players win.\n• If the spy guesses the word correctly: the spy wins.';

  @override
  String get timerEnds_title => 'Timer Ends the Round';

  @override
  String get timerEnds_desc => 'When the timer runs out, everyone must vote who they think the spy is. After that, the spy has one chance to guess the word.';

  @override
  String get scoringSystem_title => 'Scoring System';

  @override
  String get timeout_title => 'Timeout';

  @override
  String get timeout_desc => 'The spy earns +1 point plus half of the round time limit if time runs out without being discovered.';

  @override
  String get spyGuesses_title => 'Spy guesses the word';

  @override
  String get spyGuesses_desc => 'The spy gets +2 points plus 1 bonus point per full minute remaining.';

  @override
  String get spyCaught_title => 'Spy is caught';

  @override
  String get spyCaught_desc => 'All other players get +1 point plus 1 bonus point per full minute left.';

  @override
  String get wrongGuess_title => 'Wrong guess';

  @override
  String get wrongGuess_desc => 'Spies who guess the secret word incorrectly will lose 2 points and won\'t receive any winning reward.';

  @override
  String get tips_title => 'Tips';

  @override
  String get tips_bullet_1 => '• Don’t ask questions that are too obvious.';

  @override
  String get tips_bullet_2 => '• The spy wins by either guessing the word or surviving the round.';

  @override
  String get tips_bullet_3 => '• Pay attention to vague or strange answers.';
}
