import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:spot_the_spy/applications/state_management/custom_words_provider.dart';
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
    final locale = Localizations.localeOf(context);
    final categories = locale == L10n.en
        ? categoriesEN.keys.toList()
        : categoriesFA.keys.toList();
    final selectedCategories = ref.watch(categoryProvider);
    final customWordActive = ref.watch(customWordsActiveProvider);

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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...(customWordActive
                        ? _customWordsWidget()
                        : _categoriesWidget(categories, selectedCategories)),
                    const SizedBox(height: 20),
                    _buildDropdownRow(
                      icon: Icons.timer,
                      label: AppLocalizations.of(context)!.time,
                      value: ref.watch(timeProvider),
                      items: List.generate(13, (i) => i + 3),
                      onChanged: (val) =>
                          ref.read(timeProvider.notifier).set(val!),
                      labelBuilder: (val) =>
                      "${AppLocalizations.of(context)!.number(val)} ${AppLocalizations.of(context)!.minute}",
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        _buildIcon(Icons.loop),
                        Expanded(
                          child: _buildDropdown(
                            label: AppLocalizations.of(context)!.roundCount,
                            value: ref.watch(roundCountProvider),
                            items: List.generate(20, (i) => i + 1),
                            onChanged: (val) =>
                                ref.read(roundCountProvider.notifier).set(val!),
                            labelBuilder: (val) =>
                                AppLocalizations.of(context)!.number(val),
                          ),
                        ),
                        const SizedBox(width: 15),
                        _buildIcon(Icons.person_outline),
                        Expanded(
                          child: _buildDropdown(
                            label: AppLocalizations.of(context)!.spyCount,
                            value: ref.watch(spyCountProvider),
                            items: List.generate(
                                (ref.read(playerNamesProvider).length ~/ 3) + 1,
                                    (i) => i + 1),
                            onChanged: (val) =>
                                ref.read(spyCountProvider.notifier).set(val!),
                            labelBuilder: (val) =>
                                AppLocalizations.of(context)!.number(val),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 70,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: FilledButton(
                    onPressed: () {
                      HapticFeedback.lightImpact();
                      final messenger = ScaffoldMessenger.of(context);

                      if (customWordActive) {
                        final words = ref.read(customWordsProvider);
                        if (words.isEmpty) {
                          messenger.showSnackBar(SnackBar(
                            behavior: SnackBarBehavior.floating,
                            content: Text(AppLocalizations.of(context)!
                                .emptyCustomWordsError),
                          ));
                          return;
                        }
                        ref.read(playersProvider.notifier).set();
                        ref.read(playersProvider.notifier).setRoles(words);
                      } else {
                        final selected = ref.read(categoryProvider);
                        if (selected.isEmpty) {
                          messenger.showSnackBar(SnackBar(
                            behavior: SnackBarBehavior.floating,
                            content: Text(AppLocalizations.of(context)!
                                .categoryCountError),
                          ));
                          return;
                        }
                        final words = <String>[];
                        for (final cat in selected) {
                          words.addAll((locale == L10n.en
                              ? categoriesEN[cat]
                              : categoriesFA[cat])
                              ?.toList() ??
                              []);
                        }
                        ref.read(playersProvider.notifier).set();
                        ref.read(playersProvider.notifier).setRoles(words);
                      }

                      context.goNamed(Routes.roleReveal);
                    },
                    child: Text(
                      AppLocalizations.of(context)!.goToRoleReveal,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(IconData icon) => Icon(
    icon,
    size: 30,
    color: Theme.of(context).colorScheme.primary,
  );

  Widget _buildDropdown<T>({
    required String label,
    required T value,
    required List<T> items,
    required void Function(T?) onChanged,
    required String Function(T) labelBuilder,
  }) {
    return DropdownButtonFormField<T>(
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: label,
      ),
      value: value,
      items: items
          .map((item) => DropdownMenuItem<T>(
        value: item,
        child: Center(child: Text(labelBuilder(item))),
      ))
          .toList(),
      onChanged: onChanged,
    );
  }

  Widget _buildDropdownRow({
    required IconData icon,
    required String label,
    required int value,
    required List<int> items,
    required void Function(int?) onChanged,
    required String Function(int) labelBuilder,
  }) {
    return Row(
      children: [
        _buildIcon(icon),
        const SizedBox(width: 15),
        Expanded(
          child: _buildDropdown<int>(
            label: label,
            value: value,
            items: items,
            onChanged: onChanged,
            labelBuilder: labelBuilder,
          ),
        ),
      ],
    );
  }

  List<Widget> _customWordsWidget() {
    final words = ref.watch(customWordsProvider);
    return [
      Row(
        children: [
          Text(AppLocalizations.of(context)!.customWords,
              style: Theme.of(context).textTheme.titleMedium),
          IconButton(
            onPressed: _showAddWordDialog,
            icon: const Icon(Icons.add),
            color: Theme.of(context).colorScheme.primary,
          ),
          const Spacer(),
          TextButton(
            onPressed: () =>
                ref.read(customWordsActiveProvider.notifier).toggle(),
            child: Text(AppLocalizations.of(context)!.switchToCategories),
          ),
        ],
      ),
      Flexible(
        child: SingleChildScrollView(
          child: words.isEmpty
              ? Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Text(
                AppLocalizations.of(context)!.emptyCustomWordsHint,
                style: TextStyle(
                  color:
                  Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          )
              : Wrap(
            spacing: 8.0,
            children: words
                .map((word) => Chip(
              label: Text(word),
              onDeleted: () => setState(() => ref
                  .read(customWordsProvider.notifier)
                  .removeWord(word)),
            ))
                .toList(),
          ),
        ),
      ),
    ];
  }

  List<Widget> _categoriesWidget(
      List<String> categories,
      List<String> selected,
      ) {
    return [
      Row(
        children: [
          Text(AppLocalizations.of(context)!.category,
              style: Theme.of(context).textTheme.titleMedium),
          const Spacer(),
          TextButton(
            onPressed: () =>
                ref.read(customWordsActiveProvider.notifier).toggle(),
            child: Text(AppLocalizations.of(context)!.switchToCustomWords),
          ),
        ],
      ),
      Flexible(
        child: SingleChildScrollView(
          child: MultiCategorySelector(
            allCategories: categories,
            selected: selected,
            onSelectionChanged: (list) {
              HapticFeedback.lightImpact();
              ref.read(categoryProvider.notifier).set(list);
            },
          ),
        ),
      ),
    ];
  }

  void _showAddWordDialog() {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        String? error;
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            title: Text(AppLocalizations.of(context)!.addWord),
            content: TextField(
              controller: controller,
              autofocus: true,
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.enterWord,
                border: const OutlineInputBorder(),
                errorText: error,
              ),
              onChanged: (_) => setState(() => error = null),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(AppLocalizations.of(context)!.cancel),
              ),
              TextButton(
                onPressed: () {
                  final input = controller.text.trim();
                  if (input.isEmpty) return;

                  final word =
                      input[0].toUpperCase() + input.substring(1);

                  if (ref.read(customWordsProvider).contains(word)) {
                    setState(() {
                      error =
                          AppLocalizations.of(context)!.duplicateWordError;
                    });
                  } else {
                    ref.read(customWordsProvider.notifier).addWord(word);
                    Navigator.pop(context);
                  }
                },
                child: Text(AppLocalizations.of(context)!.add),
              ),
            ],
          ),
        );
      },
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
    final allSelected = selected.length == allCategories.length;

    return Wrap(
      spacing: 8,
      children: [
        FilterChip(
          label: Text(AppLocalizations.of(context)!.selectAll),
          selected: allSelected,
          onSelected: (selected) {
            onSelectionChanged(selected ? [...allCategories] : []);
          },
        ),
        ...allCategories.map((category) {
          final isSelected = selected.contains(category);
          return FilterChip(
            label: Text(category),
            selected: isSelected,
            onSelected: (selectedNow) {
              final newList = [...selected];
              selectedNow ? newList.add(category) : newList.remove(category);
              onSelectionChanged(newList);
            },
          );
        }),
      ],
    );
  }
}
