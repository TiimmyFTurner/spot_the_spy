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
  String get gameSetup => 'Game Setup';

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
}
