import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:spot_the_spy/infrastructure/router/router_consts.dart';

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
    ],
  );
}
