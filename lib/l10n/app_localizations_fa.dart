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

  @override
  String get secretWord => 'کلمهٔ مخفی';

  @override
  String get spies => 'جاسوس ها';

  @override
  String get godMode => 'God Mode';

  @override
  String get activateGodMode => 'فعال‌سازی حالت خدا؟';

  @override
  String get deactivateGodMode => 'غیرفعال‌سازی حالت خدا؟';

  @override
  String get godModeDescription => 'در حالت خدا می‌توانید کلمات مخفی و جاسوس‌ها را ببینید. مناسب برای ناظران.';

  @override
  String get duplicatePlayerNameError => 'این بازیکن قبلاً اضافه شده است.';

  @override
  String get spyWrongGuessPenalty => 'اگر جاسوس کلمه را اشتباه حدس بزند، ۲ امتیاز از دست می‌دهد و از پاداش تیم جاسوس‌ها محروم می‌شود.';

  @override
  String get wrongGuess => 'حدس اشتباه';

  @override
  String get punishSpyQuestion => 'این جاسوس را جریمه میکنید؟';

  @override
  String get alreadyPunishedMessage => 'این جاسوس قبلاً تنبیه شده است.';

  @override
  String get alreadyPunished => 'تنبیه شده است';

  @override
  String get spyPunished => 'جاسوس تنبیه شد.';

  @override
  String get customWords => 'کلمات سفارشی';

  @override
  String get switchToCategories => 'تغییر به دسته‌بندی‌ها';

  @override
  String get switchToCustomWords => 'تغییر به کلمات سفارشی';

  @override
  String get addWord => 'افزودن کلمه';

  @override
  String get enterWord => 'کلمه را وارد کنید';

  @override
  String get add => 'افزودن';

  @override
  String get emptyCustomWordsError => 'برای شروع بازی باید حداقل یک کلمه وارد کنید.';

  @override
  String get emptyCustomWordsHint => 'حداقل یک کلمه وارد کنید تا بتوانید بازی را شروع کنید.\nهرچه کلمات بیشتری وارد کنید، احتمال تکرار در دورهای بعدی کمتر می‌شود.';

  @override
  String get duplicateWordError => 'این کلمه قبلاً اضافه شده است.';

  @override
  String get howToPlay_title => 'قوانین بازی';

  @override
  String get rolesAssigned_title => 'نقش‌ها تعیین می‌شوند';

  @override
  String get rolesAssigned_desc => 'در ابتدای هر بازی، به‌صورت تصادفی چند نفر از بازیکنان به عنوان جاسوس انتخاب می‌شوند. سایر بازیکنان یک کلمه‌ی مخفی یکسان دریافت می‌کنند (مثلاً «فرودگاه»، «رستوران»).';

  @override
  String get askQuestions_title => 'از همدیگر سؤال بپرسید';

  @override
  String get askQuestions_desc => 'بازیکنان به نوبت سؤال‌های کوتاه و غیرمستقیم می‌پرسند (مثلاً «معمولاً شلوغه؟»). هدف این است که نشان دهید کلمه را می‌دانید بدون اینکه آن را لو بدهید.';

  @override
  String get beCareful_title => 'مراقب باشید!';

  @override
  String get beCareful_desc => 'اگر جاسوس نیستید: سعی کنید کسی را که کلمه را نمی‌داند پیدا کنید، ولی کلمه را لو ندهید.\nاگر شما جاسوس هستید: سعی کنید خودتان را لو ندهید و کلمه را حدس بزنید.';

  @override
  String get accuseOrGuess_title => 'اتهام یا حدس';

  @override
  String get accuseOrGuess_desc => 'هر بازیکنی می‌تواند در هر زمان به دیگری اتهام بزند که او جاسوس است. اگر همه موافق باشند، آن فرد باید نقش خود را فاش کند.\n\n• اگر جاسوس شناسایی شود: سایر بازیکنان برنده‌اند.\n• اگر جاسوس کلمه را درست حدس بزند: جاسوس برنده است.';

  @override
  String get timerEnds_title => 'پایان با تایمر';

  @override
  String get timerEnds_desc => 'وقتی تایمر تمام شود، بازیکنان رأی می‌دهند که چه کسی جاسوس است. سپس جاسوس یک فرصت برای حدس زدن کلمه خواهد داشت.';

  @override
  String get scoringSystem_title => 'سیستم امتیازدهی';

  @override
  String get timeout_title => 'پایان زمان';

  @override
  String get timeout_desc => 'جاسوس ۱ امتیاز می‌گیرد به‌علاوه نصف مدت کل زمان راند اگر تا پایان شناسایی نشده باشد.';

  @override
  String get spyGuesses_title => 'حدس درست توسط جاسوس';

  @override
  String get spyGuesses_desc => 'جاسوس ۲ امتیاز می‌گیرد و برای هر دقیقه کامل باقی‌مانده، ۱ امتیاز اضافه دریافت می‌کند.';

  @override
  String get spyCaught_title => 'شناسایی جاسوس';

  @override
  String get spyCaught_desc => 'سایر بازیکنان ۱ امتیاز دریافت می‌کنند به‌علاوه ۱ امتیاز اضافه برای هر دقیقه باقی‌مانده.';

  @override
  String get wrongGuess_title => 'حدس اشتباه';

  @override
  String get wrongGuess_desc => 'جاسوس‌هایی که کلمه مخفی را اشتباه حدس بزنند، ۲ امتیاز از دست می‌دهند و جایزه‌ی برد را دریافت نخواهند کرد.';

  @override
  String get tips_title => 'نکات';

  @override
  String get tips_bullet_1 => '• سؤال‌های خیلی واضح نپرسید.';

  @override
  String get tips_bullet_2 => '• جاسوس با حدس زدن کلمه یا زنده ماندن تا پایان برنده می‌شود.';

  @override
  String get tips_bullet_3 => '• به پاسخ‌های مبهم یا مشکوک توجه کنید!';
}
