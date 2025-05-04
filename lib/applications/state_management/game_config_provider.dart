import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'game_config_provider.g.dart';

// --- Category Provider ---
@Riverpod(keepAlive: true)
class Category extends _$Category {
  @override
  String build() => 'Place';

  void set(String value) => state = value;
}

// --- Time Provider ---
@Riverpod(keepAlive: true)
class Time extends _$Time {
  @override
  int build() => 5;

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
@riverpod
class SpyCount extends _$SpyCount {
  @override
  int build() => 1;

  void set(int value) => state = value;
}
