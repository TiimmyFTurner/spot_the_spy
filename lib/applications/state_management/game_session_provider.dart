import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spot_the_spy/domain/data_models/player_model.dart';

part 'game_session_provider.freezed.dart';
part 'game_session_provider.g.dart';

@freezed
abstract class GameSessionState with _$GameSessionState {
  const factory GameSessionState({
    required Duration remaining,
    required Duration total,
    @Default(false) bool godMode,
    @Default([]) List<Player> punishPlayers,
    @Default(false) bool isTimerRunning,
    @Default(false) bool isTimeout,
  }) = _GameSessionState;
}

@Riverpod(keepAlive: true)
class GameSession extends _$GameSession {
  Timer? _timer;

  @override
  GameSessionState build() {
    return const GameSessionState(
      remaining: Duration.zero,
      total: Duration.zero,
    );
  }

  void initialize(int minutes) {
    final total = Duration(minutes: minutes);
    state = GameSessionState(
      remaining: total,
      total: total,
      isTimerRunning: true,
    );
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (state.remaining.inSeconds == 0) {
        _timer?.cancel();
        state = state.copyWith(isTimerRunning: false, isTimeout: true);
      } else {
        state = state.copyWith(
          remaining: state.remaining - const Duration(seconds: 1),
        );
      }
    });
  }

  void toggleGodMode() {
    state = state.copyWith(godMode: !state.godMode);
  }

  void punishPlayer(Player player) {
    if (!state.punishPlayers.contains(player)) {
      state = state.copyWith(punishPlayers: [...state.punishPlayers, player]);
    }
  }

  void stopTimer() {
    _timer?.cancel();
    state = state.copyWith(isTimerRunning: false);
  }

  // Clean up timer when provider is disposed (though keepAlive is true, good practice)
  void dispose() {
    _timer?.cancel();
  }
}
