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
  String get goToGameConfig => 'مرحله بعد: تنظیم قوانین بازی';
}
