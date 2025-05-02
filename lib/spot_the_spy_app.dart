import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spot_the_spy/infrastructure/router/router.dart';

class SpotTheSpyApp extends ConsumerWidget {
  const SpotTheSpyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /** TODO
     * Locale locale = ref.watch(localeSettingProvider);
     * String? font = locale == L10n.fa ? 'Koodak' : null;
     */
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig:AppRouter.router,
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
      /**TODO:
       *       themeMode: ref.watch(themeModeSettingProvider),
       *   supportedLocales: L10n.all,
       *   locale: locale != L10n.system ? locale : null,
       *   localizationsDelegates: const [
       *   AppLocalizations.delegate,
       *   GlobalCupertinoLocalizations.delegate,
       *   GlobalMaterialLocalizations.delegate,
       *   GlobalWidgetsLocalizations.delegate,
       *  ],
       *
       * **/
    );
  }
}
