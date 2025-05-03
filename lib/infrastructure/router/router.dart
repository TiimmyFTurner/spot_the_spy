import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:spot_the_spy/infrastructure/router/router_consts.dart';
import 'package:spot_the_spy/presentation/screens/add_players_screen.dart';
import 'package:spot_the_spy/presentation/screens/home_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: Routes.homePath,
    routes: <RouteBase>[
      // --- Home Route ---
      GoRoute(
        name: Routes.home,
        path: Routes.homePath,
        builder: (BuildContext context, GoRouterState state) {
          return const HomeScreen();
        },
      ),
      GoRoute(
        name: Routes.addPlayers,
        path: Routes.addPlayersPath,
        builder: (BuildContext context, GoRouterState state) {
          return const AddPlayersScreen();
        },
      ),
    ],
  );
}
