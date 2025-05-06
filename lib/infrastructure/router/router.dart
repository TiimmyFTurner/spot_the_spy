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
        pageBuilder:
            (context, state) =>
                MaterialPage(key: state.pageKey, child: HomeScreen()),
      ),
      GoRoute(
        name: Routes.addPlayers,
        path: Routes.addPlayersPath,
        pageBuilder:
            (context, state) =>
                MaterialPage(key: state.pageKey, child: AddPlayersScreen()),
      ),
      GoRoute(
        name: Routes.settings,
        path: Routes.settingsPath,
        pageBuilder:
            (context, state) =>
                MaterialPage(key: state.pageKey, child: SettingsScreen()),
      ),
      GoRoute(
        name: Routes.howToPlay,
        path: Routes.howToPlayPath,
        pageBuilder:
            (context, state) =>
                MaterialPage(key: state.pageKey, child: HowToPlayScreen()),
      ),
      GoRoute(
        name: Routes.gameSetup,
        path: Routes.gameSetupPath,
        pageBuilder:
            (context, state) =>
                MaterialPage(key: state.pageKey, child: GameSetupScreen()),
      ),
      GoRoute(
        name: Routes.roleReveal,
        path: Routes.roleRevealPath,
        pageBuilder:
            (context, state) =>
                MaterialPage(key: state.pageKey, child: RoleRevealScreen()),
      ),
      GoRoute(
        name: Routes.gamePlay,
        path: Routes.gamePlayPath,
        pageBuilder:
            (context, state) =>
                MaterialPage(key: state.pageKey, child: GamePlayScreen()),
      ),
      GoRoute(
        name: Routes.scoreBoard,
        path: Routes.scoreBoardPath,
        pageBuilder:
            (context, state) =>
                MaterialPage(key: state.pageKey, child: ScoreBoardScreen()),
      ),
    ],
  );
}
