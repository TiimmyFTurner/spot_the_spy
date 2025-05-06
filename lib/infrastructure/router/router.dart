import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:spot_the_spy/infrastructure/router/router_consts.dart';
import 'package:spot_the_spy/presentation/screens/add_players_screen.dart';
import 'package:spot_the_spy/presentation/screens/game_setup_screen.dart';
import 'package:spot_the_spy/presentation/screens/game_play_screen.dart';
import 'package:spot_the_spy/presentation/screens/home_screen.dart';
import 'package:spot_the_spy/presentation/screens/how_to_play_screen.dart';
import 'package:spot_the_spy/presentation/screens/score_board_screen.dart';
import 'package:spot_the_spy/presentation/screens/settings_screen.dart';
import 'package:spot_the_spy/presentation/screens/role_reveal_screen.dart';

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
      GoRoute(
        name: Routes.settings,
        path: Routes.settingsPath,
        builder: (BuildContext context, GoRouterState state) {
          return const SettingsScreen();
        },
      ),
      GoRoute(
        name: Routes.howToPlay,
        path: Routes.howToPlayPath,
        builder: (BuildContext context, GoRouterState state) {
          return const HowToPlayScreen();
        },
      ),
      GoRoute(
        name: Routes.gameSetup,
        path: Routes.gameSetupPath,
        builder: (BuildContext context, GoRouterState state) {
          return const GameSetupScreen();
        },
      ),
      GoRoute(
        name: Routes.roleReveal,
        path: Routes.roleRevealPath,
        builder: (BuildContext context, GoRouterState state) {
          return const RoleRevealScreen();
        },
      ),
      GoRoute(
        name: Routes.gamePlay,
        path: Routes.gamePlayPath,
        builder: (BuildContext context, GoRouterState state) {
          return const GamePlayScreen();
        },
      ),
      GoRoute(
        name: Routes.scoreBoard,
        path: Routes.scoreBoardPath,
        builder: (BuildContext context, GoRouterState state) {
          return const ScoreBoardScreen();
        },
      ),
    ],
  );
}
