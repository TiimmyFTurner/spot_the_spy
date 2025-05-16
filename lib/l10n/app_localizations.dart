import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fa.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fa')
  ];

  /// No description provided for @newGame.
  ///
  /// In en, this message translates to:
  /// **'New Game'**
  String get newGame;

  /// No description provided for @howToPlay.
  ///
  /// In en, this message translates to:
  /// **'How To Play'**
  String get howToPlay;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @addPlayers.
  ///
  /// In en, this message translates to:
  /// **'Add Players ({value})'**
  String addPlayers(int value);

  /// No description provided for @number.
  ///
  /// In en, this message translates to:
  /// **'{value}'**
  String number(int value);

  /// No description provided for @help.
  ///
  /// In en, this message translates to:
  /// **'Help'**
  String get help;

  /// No description provided for @addPlayersHelpMessage.
  ///
  /// In en, this message translates to:
  /// **'On this page, you can add as many players as you like.'**
  String get addPlayersHelpMessage;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @playerName.
  ///
  /// In en, this message translates to:
  /// **'Player Name'**
  String get playerName;

  /// No description provided for @playerCountError.
  ///
  /// In en, this message translates to:
  /// **'You need at least 3 players to start the game.'**
  String get playerCountError;

  /// No description provided for @goToGameSetup.
  ///
  /// In en, this message translates to:
  /// **'Next: Set Game Rules'**
  String get goToGameSetup;

  /// No description provided for @themeMode.
  ///
  /// In en, this message translates to:
  /// **'{theme_mode, select, dark{Dark} light{Light} system{System Default}  other{Theme Mode}}'**
  String themeMode(String theme_mode);

  /// No description provided for @chooseTheme.
  ///
  /// In en, this message translates to:
  /// **'Choose Theme'**
  String get chooseTheme;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @languageMode.
  ///
  /// In en, this message translates to:
  /// **'{language, select, en{English} fa{فارسی} system{System Default}  other{Language}}'**
  String languageMode(String language);

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @goToRoleReveal.
  ///
  /// In en, this message translates to:
  /// **'Next: Reveal Roles'**
  String get goToRoleReveal;

  /// No description provided for @roleReveal.
  ///
  /// In en, this message translates to:
  /// **'Reveal Roles'**
  String get roleReveal;

  /// No description provided for @gameSetup.
  ///
  /// In en, this message translates to:
  /// **'Game Setup'**
  String get gameSetup;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @time.
  ///
  /// In en, this message translates to:
  /// **'Round Time'**
  String get time;

  /// No description provided for @roundCount.
  ///
  /// In en, this message translates to:
  /// **'Number of Rounds'**
  String get roundCount;

  /// No description provided for @spyCount.
  ///
  /// In en, this message translates to:
  /// **'Number of Spies'**
  String get spyCount;

  /// No description provided for @minute.
  ///
  /// In en, this message translates to:
  /// **'Minute'**
  String get minute;

  /// No description provided for @isSpy.
  ///
  /// In en, this message translates to:
  /// **'You\'\'re a Spy'**
  String get isSpy;

  /// No description provided for @gotIt.
  ///
  /// In en, this message translates to:
  /// **'Got It'**
  String get gotIt;

  /// No description provided for @theSecretWordIs.
  ///
  /// In en, this message translates to:
  /// **'The secret word is: '**
  String get theSecretWordIs;

  /// No description provided for @slideToPlay.
  ///
  /// In en, this message translates to:
  /// **'Slide to Play'**
  String get slideToPlay;

  /// No description provided for @round.
  ///
  /// In en, this message translates to:
  /// **'Round'**
  String get round;

  /// No description provided for @wordGuessed.
  ///
  /// In en, this message translates to:
  /// **'Word Guessed'**
  String get wordGuessed;

  /// No description provided for @spyCaught.
  ///
  /// In en, this message translates to:
  /// **'Spy Caught'**
  String get spyCaught;

  /// No description provided for @remainingTime.
  ///
  /// In en, this message translates to:
  /// **'Remaining Time'**
  String get remainingTime;

  /// No description provided for @scoreboard.
  ///
  /// In en, this message translates to:
  /// **'Scoreboard'**
  String get scoreboard;

  /// No description provided for @spy.
  ///
  /// In en, this message translates to:
  /// **'Spy'**
  String get spy;

  /// No description provided for @player.
  ///
  /// In en, this message translates to:
  /// **'Player'**
  String get player;

  /// No description provided for @score.
  ///
  /// In en, this message translates to:
  /// **'Score'**
  String get score;

  /// No description provided for @startNextRound.
  ///
  /// In en, this message translates to:
  /// **'Start Next Round'**
  String get startNextRound;

  /// No description provided for @newGameQuestion.
  ///
  /// In en, this message translates to:
  /// **'New Game?'**
  String get newGameQuestion;

  /// No description provided for @wordGuessedQuestion.
  ///
  /// In en, this message translates to:
  /// **'Spy Guessed the Word?'**
  String get wordGuessedQuestion;

  /// No description provided for @spyCaughtQuestion.
  ///
  /// In en, this message translates to:
  /// **'Spy Got Caught?'**
  String get spyCaughtQuestion;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @categoryCountError.
  ///
  /// In en, this message translates to:
  /// **'You need at least one category to start the game.'**
  String get categoryCountError;

  /// No description provided for @selectAll.
  ///
  /// In en, this message translates to:
  /// **'Select All'**
  String get selectAll;

  /// No description provided for @secretWord.
  ///
  /// In en, this message translates to:
  /// **'Secret Word'**
  String get secretWord;

  /// No description provided for @spies.
  ///
  /// In en, this message translates to:
  /// **'Spies'**
  String get spies;

  /// No description provided for @godMode.
  ///
  /// In en, this message translates to:
  /// **'God Mode'**
  String get godMode;

  /// No description provided for @activateGodMode.
  ///
  /// In en, this message translates to:
  /// **'Activate God Mode?'**
  String get activateGodMode;

  /// No description provided for @deactivateGodMode.
  ///
  /// In en, this message translates to:
  /// **'Deactivate God Mode?'**
  String get deactivateGodMode;

  /// No description provided for @godModeDescription.
  ///
  /// In en, this message translates to:
  /// **'God Mode lets you view secret words and spy identities. Useful for moderators.'**
  String get godModeDescription;

  /// No description provided for @duplicatePlayerNameError.
  ///
  /// In en, this message translates to:
  /// **'This player already exists.'**
  String get duplicatePlayerNameError;

  /// No description provided for @spyWrongGuessPenalty.
  ///
  /// In en, this message translates to:
  /// **'If a spy guesses the word and gets it wrong, they lose 2 points and are excluded from the spy team\'\'s reward.'**
  String get spyWrongGuessPenalty;

  /// No description provided for @wrongGuess.
  ///
  /// In en, this message translates to:
  /// **'Wrong Guess'**
  String get wrongGuess;

  /// No description provided for @punishSpyQuestion.
  ///
  /// In en, this message translates to:
  /// **'Punish this spy?'**
  String get punishSpyQuestion;

  /// No description provided for @alreadyPunishedMessage.
  ///
  /// In en, this message translates to:
  /// **'This spy has already been punished.'**
  String get alreadyPunishedMessage;

  /// No description provided for @alreadyPunished.
  ///
  /// In en, this message translates to:
  /// **'Already punished'**
  String get alreadyPunished;

  /// No description provided for @spyPunished.
  ///
  /// In en, this message translates to:
  /// **'Spy was punished.'**
  String get spyPunished;

  /// No description provided for @customWords.
  ///
  /// In en, this message translates to:
  /// **'Custom Words'**
  String get customWords;

  /// No description provided for @switchToCategories.
  ///
  /// In en, this message translates to:
  /// **'Switch to categories'**
  String get switchToCategories;

  /// No description provided for @switchToCustomWords.
  ///
  /// In en, this message translates to:
  /// **'Switch to custom words'**
  String get switchToCustomWords;

  /// No description provided for @addWord.
  ///
  /// In en, this message translates to:
  /// **'Add Word'**
  String get addWord;

  /// No description provided for @enterWord.
  ///
  /// In en, this message translates to:
  /// **'Enter word'**
  String get enterWord;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @emptyCustomWordsError.
  ///
  /// In en, this message translates to:
  /// **'You need at least one word to start the game.'**
  String get emptyCustomWordsError;

  /// No description provided for @emptyCustomWordsHint.
  ///
  /// In en, this message translates to:
  /// **'Add at least one word to begin.\nMore words help prevent duplicates in future rounds.'**
  String get emptyCustomWordsHint;

  /// No description provided for @duplicateWordError.
  ///
  /// In en, this message translates to:
  /// **'This word has already been added.'**
  String get duplicateWordError;

  /// No description provided for @howToPlay_title.
  ///
  /// In en, this message translates to:
  /// **'Game Rules'**
  String get howToPlay_title;

  /// No description provided for @rolesAssigned_title.
  ///
  /// In en, this message translates to:
  /// **'Roles Are Assigned'**
  String get rolesAssigned_title;

  /// No description provided for @rolesAssigned_desc.
  ///
  /// In en, this message translates to:
  /// **'At the start of each game, some players are randomly chosen as the Spy. All other players receive the same secret word (e.g., \'\'Airport\'\', \'\'Restaurant\'\').'**
  String get rolesAssigned_desc;

  /// No description provided for @askQuestions_title.
  ///
  /// In en, this message translates to:
  /// **'Ask Each Other Questions'**
  String get askQuestions_title;

  /// No description provided for @askQuestions_desc.
  ///
  /// In en, this message translates to:
  /// **'Players take turns asking subtle questions (e.g., \'\'Is it usually crowded there?\'\'). The goal is to show you know the word without making it too obvious.'**
  String get askQuestions_desc;

  /// No description provided for @beCareful_title.
  ///
  /// In en, this message translates to:
  /// **'Be Careful!'**
  String get beCareful_title;

  /// No description provided for @beCareful_desc.
  ///
  /// In en, this message translates to:
  /// **'If you\'\'re not the spy: spot who doesn\'\'t know the word without revealing it.\nIf you\'\'re the spy: blend in and try to guess the word before you\'\'re caught.'**
  String get beCareful_desc;

  /// No description provided for @accuseOrGuess_title.
  ///
  /// In en, this message translates to:
  /// **'Accuse or Guess'**
  String get accuseOrGuess_title;

  /// No description provided for @accuseOrGuess_desc.
  ///
  /// In en, this message translates to:
  /// **'Any player can accuse someone of being the spy. If everyone agrees, the accused reveals their role.\n\n• If the spy is caught: other players win.\n• If the spy guesses the word correctly: the spy wins.'**
  String get accuseOrGuess_desc;

  /// No description provided for @timerEnds_title.
  ///
  /// In en, this message translates to:
  /// **'Timer Ends the Round'**
  String get timerEnds_title;

  /// No description provided for @timerEnds_desc.
  ///
  /// In en, this message translates to:
  /// **'When the timer runs out, everyone must vote who they think the spy is. After that, the spy has one chance to guess the word.'**
  String get timerEnds_desc;

  /// No description provided for @scoringSystem_title.
  ///
  /// In en, this message translates to:
  /// **'Scoring System'**
  String get scoringSystem_title;

  /// No description provided for @timeout_title.
  ///
  /// In en, this message translates to:
  /// **'Timeout'**
  String get timeout_title;

  /// No description provided for @timeout_desc.
  ///
  /// In en, this message translates to:
  /// **'The spy earns +1 point plus half of the round time limit if time runs out without being discovered.'**
  String get timeout_desc;

  /// No description provided for @spyGuesses_title.
  ///
  /// In en, this message translates to:
  /// **'Spy guesses the word'**
  String get spyGuesses_title;

  /// No description provided for @spyGuesses_desc.
  ///
  /// In en, this message translates to:
  /// **'The spy gets +2 points plus 1 bonus point per full minute remaining.'**
  String get spyGuesses_desc;

  /// No description provided for @spyCaught_title.
  ///
  /// In en, this message translates to:
  /// **'Spy is caught'**
  String get spyCaught_title;

  /// No description provided for @spyCaught_desc.
  ///
  /// In en, this message translates to:
  /// **'All other players get +1 point plus 1 bonus point per full minute left.'**
  String get spyCaught_desc;

  /// No description provided for @wrongGuess_title.
  ///
  /// In en, this message translates to:
  /// **'Wrong guess'**
  String get wrongGuess_title;

  /// No description provided for @wrongGuess_desc.
  ///
  /// In en, this message translates to:
  /// **'Spies who guess the secret word incorrectly will lose 2 points and won\'\'t receive any winning reward.'**
  String get wrongGuess_desc;

  /// No description provided for @tips_title.
  ///
  /// In en, this message translates to:
  /// **'Tips'**
  String get tips_title;

  /// No description provided for @tips_bullet_1.
  ///
  /// In en, this message translates to:
  /// **'• Don’t ask questions that are too obvious.'**
  String get tips_bullet_1;

  /// No description provided for @tips_bullet_2.
  ///
  /// In en, this message translates to:
  /// **'• The spy wins by either guessing the word or surviving the round.'**
  String get tips_bullet_2;

  /// No description provided for @tips_bullet_3.
  ///
  /// In en, this message translates to:
  /// **'• Pay attention to vague or strange answers.'**
  String get tips_bullet_3;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'fa'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'fa': return AppLocalizationsFa();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
