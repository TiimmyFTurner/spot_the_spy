import 'package:freezed_annotation/freezed_annotation.dart';

part 'player_model.freezed.dart';

@freezed
abstract class Player with _$Player {
  const factory Player({
    required final String name,
    required bool isSpy,
    required int score,
  }) = _Player;
}
