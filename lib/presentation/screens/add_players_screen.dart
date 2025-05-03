import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:spot_the_spy/applications/state_management/players_provider.dart';
import 'package:spot_the_spy/infrastructure/router/router_consts.dart';

class AddPlayersScreen extends ConsumerStatefulWidget {
  const AddPlayersScreen({super.key});

  @override
  ConsumerState createState() => _SetPlayersScreenState();
}

class _SetPlayersScreenState extends ConsumerState<AddPlayersScreen> {
  final TextEditingController _controller = TextEditingController();
  String _name = '';

  void _addPlayer([_]) {
    if (_name != '' && !ref.read(playerNamesProvider).contains(_name)) {
      ref.read(playerNamesProvider.notifier).addPlayer(_name);
      _name = '';
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    List players = ref.watch(playerNamesProvider);
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          title: Text("انتخاب بازیکن ها (${players.length})"),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.home),
            onPressed: () => context.pushReplacementNamed(Routes.home),
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.help_outline),
              onPressed: () {
                showDialog<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("راهنما"),
                      content: const Text(
                        'در این قسمت شما میتوانید به هر تعدادی میخواهید بازیکن اضافه کنید',
                      ),
                      actions: <Widget>[
                        TextButton(
                          style: TextButton.styleFrom(
                            textStyle: Theme.of(context).textTheme.labelLarge,
                          ),
                          child: const Text("بازگشت"),
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
                  labelText: 'نام بازیکن',
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
                child: Hero(
                  tag: "play",
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 16,
                    ),
                    child: FilledButton(
                      child: const Text(
                        "انتخاب نقش",
                        style: TextStyle(fontSize: 22),
                      ),
                      onPressed: () {
                        HapticFeedback.lightImpact();
                        if (players.length > 2) {
                          //TODO: context.push(Routes.setRolesRoutePath);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                "حداقل تعداد بازیکنان باید سه نفر باشد",
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
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
            child: Center(
              child: Text(player, overflow: TextOverflow.ellipsis),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.delete,
              color: Theme.of(context).colorScheme.error,
            ),
            onPressed:
                () => ref
                    .read(playerNamesProvider.notifier)
                    .removePlayer(player),
          ),
        ],
      ),
    );
  }
}
