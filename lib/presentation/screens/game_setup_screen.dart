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
    List<String> selectedCategories = ref.watch(categoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.gameSetup),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: Container()),
              Text(
                AppLocalizations.of(context)!.category,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              MultiCategorySelector(
                allCategories: categories,
                selected: selectedCategories,
                onSelectionChanged: (selectedList) {
                  ref.read(categoryProvider.notifier).set(selectedList);
                },
              ),
              SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.timer,size: 30,color: Theme.of(context).colorScheme.primary,),
                  SizedBox(width: 15),
                  Expanded(
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
                              child: Center(
                                child: Text(
                                  "${AppLocalizations.of(context)!.number(time)} ${AppLocalizations.of(context)!.minute}",
                                ),
                              ),
                            );
                          }).toList(),
                      onChanged: (int? newValue) {
                        ref.read(timeProvider.notifier).set(newValue!);
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Icon(Icons.loop,size: 30,color: Theme.of(context).colorScheme.primary,),
                  SizedBox(width: 15),
                  Expanded(
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
                              child: Center(
                                child: Text(
                                  AppLocalizations.of(
                                    context,
                                  )!.number(roundCount),
                                ),
                              ),
                            );
                          }).toList(),
                      onChanged: (int? newValue) {
                        ref.read(roundCountProvider.notifier).set(newValue!);
                      },
                    ),
                  ),
                  SizedBox(width: 15),
                  Icon(Icons.person_outline,size: 30,color: Theme.of(context).colorScheme.primary,),
                  SizedBox(width: 15),
                  Expanded(
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
                              child: Center(
                                child: Text(
                                  AppLocalizations.of(
                                    context,
                                  )!.number(spyCount),
                                ),
                              ),
                            );
                          }).toList(),
                      onChanged: (int? newValue) {
                        ref.read(spyCountProvider.notifier).set(newValue!);
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
                      if (ref.read(categoryProvider).isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              AppLocalizations.of(context)!.categoryCountError,
                            ),
                          ),
                        );
                      } else {
                        List<String> wordsList = [];
                        for (var i = 0; i < selectedCategories.length; i++) {
                          wordsList.addAll(
                            (locale == L10n.en
                                    ? categoriesEN[selectedCategories[i]]
                                        ?.toList()
                                    : categoriesFA[selectedCategories[i]]
                                        ?.toList()) ??
                                [],
                          );
                        }
                        ref.read(playersProvider.notifier).set();
                        ref.read(playersProvider.notifier).setRoles(wordsList);
                        context.goNamed(Routes.roleReveal);
                      }
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

class MultiCategorySelector extends StatelessWidget {
  final List<String> allCategories;
  final List<String> selected;
  final Function(List<String>) onSelectionChanged;

  const MultiCategorySelector({
    super.key,
    required this.allCategories,
    required this.selected,
    required this.onSelectionChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children:
          allCategories.map((category) {
            final isSelected = selected.contains(category);
            return FilterChip(
              label: Text(category),
              selected: isSelected,
              onSelected: (bool selectedNow) {
                final newSelected = [...selected];
                if (selectedNow) {
                  newSelected.add(category);
                } else {
                  newSelected.remove(category);
                }
                onSelectionChanged(newSelected);
              },
            );
          }).toList(),
    );
  }
}
