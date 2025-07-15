import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:spot_the_spy/applications/state_management/custom_words_provider.dart';
import 'package:spot_the_spy/applications/state_management/game_config_provider.dart';
import 'package:spot_the_spy/applications/state_management/players_provider.dart';
import 'package:spot_the_spy/infrastructure/router/router_consts.dart';
import 'package:spot_the_spy/l10n/app_localizations.dart';

class GameSetupScreen extends ConsumerStatefulWidget {
  const GameSetupScreen({super.key});

  @override
  ConsumerState createState() => _GameSetupScreenState();
}

class _GameSetupScreenState extends ConsumerState<GameSetupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.gameSetup),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 16),

              _buildDropdownRow(
                  icon: Icons.timer,
                  label: AppLocalizations.of(context)!.time,
                  value: ref.watch(timeProvider),
                  items: List.generate(13, (i) => i + 3),
                  onChanged: (val) =>
                      ref.read(timeProvider.notifier).set(val!),
                  labelBuilder: (val) =>
                  "${AppLocalizations.of(context)!.number(val)} ${AppLocalizations.of(context)!.minute}",
                ),                const SizedBox(height: 16),

              _buildDropdownRow(
                icon: Icons.loop,
                label: AppLocalizations.of(context)!.roundCount,
                value: ref.watch(roundCountProvider),
                items: List.generate(20, (i) => i + 1),
                onChanged: (val) =>
                    ref.read(roundCountProvider.notifier).set(val!),
                labelBuilder: (val) =>
                    AppLocalizations.of(context)!.number(val),
              ),                const SizedBox(height: 16),

              _buildDropdownRow(
                icon: Icons.person_outline,
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
              Spacer(),
              SizedBox(
                height: 70,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: FilledButton(
                    onPressed: () {
                      HapticFeedback.lightImpact();
                      ref.read(playersProvider.notifier).set();
                      ref.read(playersProvider.notifier).setRoles();
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
        const SizedBox(width: 16),
        Expanded(
          child: _buildDropdown<int>(
            label: label,
            value: value,
            items: items,
            onChanged: onChanged,
            labelBuilder: labelBuilder,
          ),
        ),
        const SizedBox(width: 36),
      ],
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
