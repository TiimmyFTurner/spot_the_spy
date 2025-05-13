import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:spot_the_spy/applications/state_management/players_provider.dart';
import 'package:spot_the_spy/infrastructure/router/router_consts.dart';
import 'package:spot_the_spy/l10n/app_localizations.dart';

class AddPlayersScreen extends ConsumerStatefulWidget {
  const AddPlayersScreen({super.key});

  @override
  ConsumerState createState() => _SetPlayersScreenState();
}

class _SetPlayersScreenState extends ConsumerState<AddPlayersScreen> {
  final TextEditingController _controller = TextEditingController();
  String _name = '';

  void _addPlayer([_]) {
    if (_name != '') {
      _name = _name.trim();
      String name = _name[0].toUpperCase() + _name.substring(1);
      if (!ref.read(playerNamesProvider).contains(name)) {
        ref.read(playerNamesProvider.notifier).addPlayer(name);
        _name = '';
        _controller.clear();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text(
              AppLocalizations.of(context)!.duplicatePlayerNameError,
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    List players = ref.watch(playerNamesProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.addPlayers(players.length)),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: () {
              showDialog<void>(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(AppLocalizations.of(context)!.help),
                    content: Text(
                      AppLocalizations.of(context)!.addPlayersHelpMessage,
                    ),
                    actions: <Widget>[
                      TextButton(
                        style: TextButton.styleFrom(
                          textStyle: Theme.of(context).textTheme.labelLarge,
                        ),
                        child: Text(AppLocalizations.of(context)!.back),
                        onPressed: () {
                          context.pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              shrinkWrap: true,
              itemCount: players.length + 1,
              itemBuilder: (BuildContext context, int index) {
                return index < players.length
                    ? listItemPlayer(players[index])
                    : const SizedBox(height: 8);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: TextField(
              controller: _controller,
              onChanged: (String value) => _name = value,
              onSubmitted: _addPlayer,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: AppLocalizations.of(context)!.playerName,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 20,
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: _addPlayer,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          SafeArea(
            child: SizedBox(
              height: 70,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 16,
                ),
                child: FilledButton(
                  child: Text(
                    AppLocalizations.of(context)!.goToGameSetup,
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    HapticFeedback.lightImpact();
                    if (players.length > 2) {
                      context.pushNamed(Routes.gameSetup);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          behavior: SnackBarBehavior.floating,
                          content: Text(
                            AppLocalizations.of(context)!.playerCountError,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget listItemPlayer(player) {
    return Card(
      color: Theme.of(context).colorScheme.surfaceContainer,
      elevation: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(15),
            child: Icon(
              Icons.person,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          Expanded(
            child: Text(
              player,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 16),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.delete,
              color: Theme.of(context).colorScheme.error,
            ),
            onPressed:
                () =>
                    ref.read(playerNamesProvider.notifier).removePlayer(player),
          ),
        ],
      ),
    );
  }
}
