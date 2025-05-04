import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spot_the_spy/applications/state_management/settings_provider.dart';
import 'package:spot_the_spy/infrastructure/router/router.dart';
import 'package:spot_the_spy/l10n/app_localizations.dart';
import 'package:spot_the_spy/l10n/l10n.dart';



class SpotTheSpyApp extends ConsumerWidget {
  const SpotTheSpyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

      Locale locale = ref.watch(localeSettingProvider);
      String? font = locale == L10n.fa ? 'Koodak' : null;

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
      title: 'Spot the Spy',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
        useMaterial3: true,
        // TODO: fontFamily: font
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.pink,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        // TODO: fontFamily: font
      ),

      themeMode: ref.watch(themeModeSettingProvider),
      supportedLocales: AppLocalizations.supportedLocales,
      locale: locale != L10n.system ? locale : null,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
    );
  }
}
