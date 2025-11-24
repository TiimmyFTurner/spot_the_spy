import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:spot_the_spy/applications/state_management/settings_provider.dart';
import 'package:spot_the_spy/l10n/app_localizations.dart';
import 'package:spot_the_spy/l10n/l10n.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeModeSettingProvider);
    final locale = ref.watch(localeSettingProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settings),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            ListTile(
              title: Text(AppLocalizations.of(context)!.chooseTheme),
              subtitle: Text(
                AppLocalizations.of(
                  context,
                )!.themeMode(ref.watch(themeModeSettingProvider).name),
              ),
              onTap: () {
                ThemeMode themeMode = ref.read(themeModeSettingProvider);
                showDialog<String>(
                  context: context,
                  builder:
                      (BuildContext context) => StatefulBuilder(
                        builder: (context, setState) {
                          return AlertDialog(
                            contentPadding: EdgeInsets.zero,
                            title: Text(
                              AppLocalizations.of(context)!.chooseTheme,
                            ),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                RadioListTile<ThemeMode>(
                                  title: Text(
                                    AppLocalizations.of(
                                      context,
                                    )!.themeMode('light'),
                                  ),
                                  value: ThemeMode.light,
                                  groupValue: themeMode,
                                  onChanged: (value) {
                                    setState(() {
                                      themeMode = value!;
                                    });
                                  },
                                ),
                                RadioListTile<ThemeMode>(
                                  title: Text(
                                    AppLocalizations.of(
                                      context,
                                    )!.themeMode('dark'),
                                  ),
                                  value: ThemeMode.dark,
                                  groupValue: themeMode,
                                  onChanged: (value) {
                                    setState(() {
                                      themeMode = value!;
                                    });
                                  },
                                ),
                                RadioListTile<ThemeMode>(
                                  title: Text(
                                    AppLocalizations.of(
                                      context,
                                    )!.themeMode('system'),
                                  ),
                                  value: ThemeMode.system,
                                  groupValue: themeMode,
                                  onChanged: (value) {
                                    setState(() {
                                      themeMode = value!;
                                    });
                                  },
                                ),
                              ],
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => context.pop(),
                                child: Text(AppLocalizations.of(context)!.cancel),
                              ),
                              TextButton(
                                onPressed: () {
                                  context.pop();
                                  ref
                                      .read(themeModeSettingProvider.notifier)
                                      .changeTheme(themeMode);
                                },
                                child: Text(
                                  AppLocalizations.of(context)!.confirm,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                );
              },
            ),
            ListTile(
              title: Text(AppLocalizations.of(context)!.language),
              subtitle: Text(
                AppLocalizations.of(
                  context,
                )!.languageMode(ref.watch(localeSettingProvider).toString()),
              ),
              onTap: () {
                Locale locale = ref.read(localeSettingProvider);
                showDialog<String>(
                  context: context,
                  builder:
                      (BuildContext context) => StatefulBuilder(
                        builder: (context, setState) {
                          return AlertDialog(
                            contentPadding: EdgeInsets.zero,
                            title: Text(AppLocalizations.of(context)!.language),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                RadioListTile<Locale>(
                                  title: Text(
                                    AppLocalizations.of(
                                      context,
                                    )!.languageMode('en'),
                                  ),
                                  value: L10n.en,
                                  groupValue: locale,
                                  onChanged: (value) {
                                    setState(() {
                                      locale = value!;
                                    });
                                  },
                                ),
                                RadioListTile<Locale>(
                                  title: Text(
                                    AppLocalizations.of(
                                      context,
                                    )!.languageMode('fa'),
                                  ),
                                  value: L10n.fa,
                                  groupValue: locale,
                                  onChanged: (value) {
                                    setState(() {
                                      locale = value!;
                                    });
                                  },
                                ),
                                RadioListTile<Locale>(
                                  title: Text(
                                    AppLocalizations.of(
                                      context,
                                    )!.themeMode('system'),
                                  ),
                                  value: L10n.system,
                                  groupValue: locale,
                                  onChanged: (value) {
                                    setState(() {
                                      locale = value!;
                                    });
                                  },
                                ),
                              ],
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => context.pop(),
                                child: Text(AppLocalizations.of(context)!.cancel),
                              ),
                              TextButton(
                                onPressed: () {
                                  context.pop();
                                  ref
                                      .read(localeSettingProvider.notifier)
                                      .changeLocale(locale);
                                },
                                child: Text(
                                  AppLocalizations.of(context)!.confirm,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                );
              },
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: _openTelegram,
                  icon: FaIcon(
                    FontAwesomeIcons.telegram,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                SizedBox(width: 16),
                IconButton(
                  onPressed: _sendMail,
                  icon: FaIcon(
                    FontAwesomeIcons.solidEnvelope,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              "Spot the Spy 1.6.0",
              style: TextStyle(color: Theme.of(context).colorScheme.outline),
            ),
            Text(
              "Copyright © 2025 Tiimmy F. Turner. All Rights Reserved",
              style: TextStyle(color: Theme.of(context).colorScheme.outline),
            ),
            SizedBox(height: 4,)
          ],
        ),
      ),
    );
  }

  Future<void> _sendMail() async {
    final Uri url = Uri.parse(
      'mailto:TiimmyFTurner@gmail.com?subject=Spot The Spy',
    );
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> _openTelegram() async {
    final Uri url = Uri.parse('https://T.me/TiimmyFTurner');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
