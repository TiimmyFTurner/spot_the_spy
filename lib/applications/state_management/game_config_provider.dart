import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'game_config_provider.g.dart';

// --- Category Provider ---
@Riverpod(keepAlive: true)
class Category extends _$Category {
  @override
  List<String> build() => [];

  void set(List<String> value) => state = value;
}

// --- Time Provider ---
@Riverpod(keepAlive: true)
class Time extends _$Time {
  @override
  int build() => 3;

  void set(int value) => state = value;
}

// --- RoundCount Provider ---
@Riverpod(keepAlive: true)
class RoundCount extends _$RoundCount {
  @override
  int build() => 5;

  void set(int value) => state = value;
}

// --- SpyCount Provider ---
@Riverpod(keepAlive: true)
class SpyCount extends _$SpyCount {
  @override
  int build() => 1;

  void set(int value) => state = value;
}

// --- TheWord Provider ---
@Riverpod(keepAlive: true)
class TheWord extends _$TheWord {
  @override
  String build() => '';

  void set(String value) => state = value;
}

// --- CurrentRound Provider ---
@Riverpod(keepAlive: true)
class CurrentRound extends _$CurrentRound {
  @override
  int build() => 1;

  void next() => state++;
}