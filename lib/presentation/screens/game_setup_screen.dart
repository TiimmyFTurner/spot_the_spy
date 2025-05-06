import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:spot_the_spy/applications/state_management/game_config_provider.dart';
import 'package:spot_the_spy/applications/state_management/players_provider.dart';
import 'package:spot_the_spy/infrastructure/data/categories_en.dart';
import 'package:spot_the_spy/infrastructure/data/categories_fa.dart';
import 'package:spot_the_spy/infrastructure/router/router_consts.dart';
import 'package:spot_the_spy/l10n/app_localizations.dart';
import 'package:spot_the_spy/l10n/l10n.dart';

class GameSetupScreen extends ConsumerStatefulWidget {
  const GameSetupScreen({super.key});

  @override
  ConsumerState createState() => _GameSetupScreenState();
}

class _GameSetupScreenState extends ConsumerState<GameSetupScreen> {
  @override
  Widget build(BuildContext context) {
    Locale locale = Localizations.localeOf(context);
    List<String> categories =
        locale == L10n.en
            ? categoriesEN.keys.toList()
            : categoriesFA.keys.toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.gameSetup),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Expanded(child: Container()),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    flex: 3,
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: AppLocalizations.of(context)!.category,
                      ),
                      value: ref.watch(categoryProvider),
                      items:
                          categories.map<DropdownMenuItem<String>>((
                            String category,
                          ) {
                            return DropdownMenuItem<String>(
                              value: category,
                              child: Text(
                                category,
                                overflow: TextOverflow.ellipsis,
                              ),
                            );
                          }).toList(),
                      onChanged: (String? newValue) {
                        ref.read(categoryProvider.notifier).set(newValue!);
                      },
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    flex: 2,
                    child: DropdownButtonFormField<int>(
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: AppLocalizations.of(context)!.spyCount,
                      ),
                      value: ref.watch(spyCountProvider),
                      items:
                          List.generate(
                            (ref.read(playerNamesProvider).length ~/ 3) + 1,
                            (index) => index + 1,
                          ).map<DropdownMenuItem<int>>((int spyCount) {
                            return DropdownMenuItem<int>(
                              value: spyCount,
                              child: Text(spyCount.toString()),
                            );
                          }).toList(),
                      onChanged: (int? newValue) {
                        ref.read(spyCountProvider.notifier).set(newValue!);
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: DropdownButtonFormField<int>(
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: AppLocalizations.of(context)!.time,
                      ),
                      value: ref.watch(timeProvider),
                      items:
                          List.generate(
                            13,
                            (index) => index + 3,
                          ).map<DropdownMenuItem<int>>((int time) {
                            return DropdownMenuItem<int>(
                              value: time,
                              child: Text(
                                "$time (${AppLocalizations.of(context)!.minute})",
                              ),
                            );
                          }).toList(),
                      onChanged: (int? newValue) {
                        ref.read(timeProvider.notifier).set(newValue!);
                      },
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    flex: 2,
                    child: DropdownButtonFormField<int>(
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: AppLocalizations.of(context)!.roundCount,
                      ),
                      value: ref.watch(roundCountProvider),
                      items:
                          List.generate(
                            20,
                            (index) => index + 1,
                          ).map<DropdownMenuItem<int>>((int roundCount) {
                            return DropdownMenuItem<int>(
                              value: roundCount,
                              child: Text(roundCount.toString()),
                            );
                          }).toList(),
                      onChanged: (int? newValue) {
                        ref.read(roundCountProvider.notifier).set(newValue!);
                      },
                    ),
                  ),
                ],
              ),
              Expanded(child: Container()),
              SizedBox(
                height: 70,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: FilledButton(
                    child: Text(
                      AppLocalizations.of(context)!.goToRoleReveal,
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      HapticFeedback.lightImpact();
                      ref.read(playersProvider.notifier).set();
                      ref
                          .read(playersProvider.notifier)
                          .setRoles(
                            categoriesEN[ref.read(categoryProvider)]?.toList(),
                          );
                      context.pushNamed(Routes.roleReveal);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
