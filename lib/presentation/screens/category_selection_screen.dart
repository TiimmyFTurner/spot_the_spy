import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:spot_the_spy/applications/state_management/custom_words_provider.dart';
import 'package:spot_the_spy/applications/state_management/game_config_provider.dart';
import 'package:spot_the_spy/infrastructure/data/categories_en.dart';
import 'package:spot_the_spy/infrastructure/data/categories_fa.dart';
import 'package:spot_the_spy/infrastructure/router/router_consts.dart';
import 'package:spot_the_spy/l10n/app_localizations.dart';
import 'package:spot_the_spy/l10n/l10n.dart';

class CategorySelectionScreen extends ConsumerStatefulWidget {
  const CategorySelectionScreen({super.key});

  @override
  ConsumerState createState() => _CategorySelectionScreenState();
}

class _CategorySelectionScreenState
    extends ConsumerState<CategorySelectionScreen> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  String? error;


  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);
    final categories =
        locale == L10n.en
            ? categoriesEN.keys.toList()
            : categoriesFA.keys.toList();
    final selectedCategories = ref.watch(categoryProvider);
    final customWordActive = ref.watch(customWordsActiveProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.categorySelection),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: ChoiceChip(
                      showCheckmark: false,
                      label: Center(
                        child: Text(AppLocalizations.of(context)!.categories),
                      ),
                      selected: customWordActive == false,
                      onSelected: (_) {
                        setState(() {
                          ref.read(customWordsActiveProvider.notifier).toggle();
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ChoiceChip(
                      showCheckmark: false,
                      label: Center(
                        child: Text(AppLocalizations.of(context)!.customWords),
                      ),
                      selected: customWordActive,
                      onSelected: (_) {
                        setState(() {
                          ref.read(customWordsActiveProvider.notifier).toggle();
                        });
                      },
                    ),
                  ),
                ],
              ),
                 //body
                 Expanded(
                   child: SizedBox(
                      width: double.infinity,
                      child: Card(
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        elevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: customWordActive
                              ? _customWordsWidget()
                              : _categoriesWidget(categories, selectedCategories),
                        ),
                      ),
                                   ),
                 ),

              SizedBox(height: 16,),
              if(customWordActive) TextField(
                autofocus: true,
                focusNode: _focusNode,
                controller: _controller,
                onChanged: (value) {
                  setState(() {
                    error=null;
                  });
                },
                onSubmitted: _addWord,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: AppLocalizations.of(context)!.enterWord,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 20,
                  ),
                  errorText: error,
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: _addWord,
                  ),
                ),
              ),
              const SizedBox(height: 12),
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
                          messenger.showSnackBar(
                            SnackBar(
                              behavior: SnackBarBehavior.floating,
                              content: Text(
                                AppLocalizations.of(
                                  context,
                                )!.emptyCustomWordsError,
                              ),
                            ),
                          );
                          return;
                        }
                        ref.read(wordsListProvider.notifier).set(words);
                      } else {
                        final selected = ref.read(categoryProvider);
                        if (selected.isEmpty) {
                          messenger.showSnackBar(
                            SnackBar(
                              behavior: SnackBarBehavior.floating,
                              content: Text(
                                AppLocalizations.of(
                                  context,
                                )!.categoryCountError,
                              ),
                            ),
                          );
                          return;
                        }
                        final words = <String>[];
                        for (final cat in selected) {
                          words.addAll(
                            (locale == L10n.en
                                        ? categoriesEN[cat]
                                        : categoriesFA[cat])
                                    ?.toList() ??
                                [],
                          );
                        }
                        ref.read(wordsListProvider.notifier).set(words);
                      }

                      context.pushNamed(Routes.gameSetup);
                    },
                    child: Text(
                      AppLocalizations.of(context)!.goToGameSetup,
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

  Widget _customWordsWidget() {
    final words = ref.watch(customWordsProvider);
    return
      words.isEmpty
          ? Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Text(
                AppLocalizations.of(context)!.emptyCustomWordsHint,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          )
          : SingleChildScrollView(
            child: Wrap(
              spacing: 8.0,
              children:
                  words
                      .map(
                        (word) => Chip(
                          label: Text(word),
                          onDeleted:
                              () => setState(
                                () => ref
                                    .read(customWordsProvider.notifier)
                                    .removeWord(word),
                              ),
                        ),
                      )
                      .toList(),
            ),
          );
  }

  Widget _categoriesWidget(
    List<String> categories,
    List<String> selected,
  ) {
    return
      SingleChildScrollView(
        child: MultiCategorySelector(
          allCategories: categories,
          selected: selected,
          onSelectionChanged: (list) {
            HapticFeedback.lightImpact();
            ref.read(categoryProvider.notifier).set(list);
          },
        ),
      );
  }

  void _addWord([_]) {
    final input = _controller.text.trim();
    if (input.isEmpty) return;

    final word = input[0].toUpperCase() + input.substring(1);

    if (ref.read(customWordsProvider).contains(word)) {
      setState(() {
        error =
            AppLocalizations.of(context)!.duplicateWordError;
      });
    } else {
      ref.read(customWordsProvider.notifier).addWord(word);
      _controller.clear();
    }
    _focusNode.requestFocus();
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
