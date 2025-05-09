// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Persian (`fa`).
class AppLocalizationsFa extends AppLocalizations {
  AppLocalizationsFa([String locale = 'fa']) : super(locale);

  @override
  String get newGame => 'بازی جدید';

  @override
  String get howToPlay => 'روش بازی';

  @override
  String get settings => 'تنظیمات';

  @override
  String addPlayers(int value) {
    final intl.NumberFormat valueNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String valueString = valueNumberFormat.format(value);

    return 'اضافه کردن بازیکن ($valueString)';
  }

  @override
  String number(int value) {
    final intl.NumberFormat valueNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String valueString = valueNumberFormat.format(value);

    return '$valueString';
  }

  @override
  String get help => 'راهنما';

  @override
  String get addPlayersHelpMessage => 'در این صفحه میتوانید هر تعداد بازیکن که میخواهید اضافه کنید.';

  @override
  String get back => 'برگشت';

  @override
  String get playerName => 'نام بازیکن';

  @override
  String get playerCountError => 'این بازی حداقل به ۳ بازیکن نیاز دارد.';

  @override
  String get goToGameSetup => 'مرحله بعد: تنظیم قوانین بازی';

  @override
  String themeMode(String theme_mode) {
    String _temp0 = intl.Intl.selectLogic(
      theme_mode,
      {
        'dark': 'تاریک',
        'light': 'روشن',
        'system': 'پیش فرض سیستم',
        'other': 'حالت تم',
      },
    );
    return '$_temp0';
  }

  @override
  String get chooseTheme => 'انتخاب تم';

  @override
  String get confirm => 'ثبت';

  @override
  String languageMode(String language) {
    String _temp0 = intl.Intl.selectLogic(
      language,
      {
        'en': 'English',
        'fa': 'فارسی',
        'system': 'پیش فرض سیستم',
        'other': 'زبان',
      },
    );
    return '$_temp0';
  }

  @override
  String get cancel => 'انصراف';

  @override
  String get language => 'زبان';

  @override
  String get goToRoleReveal => 'مرحله بعد: نمایش نقش ها';

  @override
  String get roleReveal => 'نمایش نقش ها';

  @override
  String get gameSetup => 'پیکربندی بازی';

  @override
  String get category => 'دسته بندی';

  @override
  String get time => 'مدت زمان هر دور';

  @override
  String get roundCount => 'تعداد دورها';

  @override
  String get spyCount => 'تعداد جاسوس ها';

  @override
  String get minute => 'دقیقه';

  @override
  String get isSpy => 'تو یک جاسوسی';

  @override
  String get gotIt => 'فهمیدم';

  @override
  String get theSecretWordIs => 'کلمهٔ مخفی اینه: ';

  @override
  String get slideToPlay => 'برای شروع بازی بکش';

  @override
  String get round => 'دور';

  @override
  String get wordGuessed => 'کلمه حدس زده شد';

  @override
  String get spyCaught => 'جاسوس پیدا شد';

  @override
  String get remainingTime => 'زمان باقی مانده';

  @override
  String get scoreboard => 'جدول امتیازات';

  @override
  String get spy => 'جاسوس';

  @override
  String get player => 'بازیکن';

  @override
  String get score => 'امتیاز';

  @override
  String get startNextRound => 'شروع دور بعدی';

  @override
  String get newGameQuestion => 'بازی جدید ؟';

  @override
  String get wordGuessedQuestion => 'کلمه حدس زده شد؟';

  @override
  String get spyCaughtQuestion => 'جاسوس پیدا شد؟';

  @override
  String get yes => 'بله';

  @override
  String get no => 'خیر';

  @override
  String get categoryCountError => 'برای این بازی حداقل به یک دسته بندی نیاز دارید.';

  @override
  String get selectAll => 'انتخاب همه';
}
