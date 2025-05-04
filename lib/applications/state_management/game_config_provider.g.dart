// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_config_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$categoryHash() => r'2878778314ec5fa10693b729b9ee2b6d149962e4';

/// See also [Category].
@ProviderFor(Category)
final categoryProvider = NotifierProvider<Category, String>.internal(
  Category.new,
  name: r'categoryProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$categoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Category = Notifier<String>;
String _$timeHash() => r'5feac24ce046b7e3a47e86f9a164a3382bf48c55';

/// See also [Time].
@ProviderFor(Time)
final timeProvider = NotifierProvider<Time, int>.internal(
  Time.new,
  name: r'timeProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$timeHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Time = Notifier<int>;
String _$roundCountHash() => r'992eef0fb5f19cb9d1f5f2b4e2229a5738e929ca';

/// See also [RoundCount].
@ProviderFor(RoundCount)
final roundCountProvider = NotifierProvider<RoundCount, int>.internal(
  RoundCount.new,
  name: r'roundCountProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$roundCountHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$RoundCount = Notifier<int>;
String _$spyCountHash() => r'50ba534ae6e25763e2e0f51e44bd8032e583e831';

/// See also [SpyCount].
@ProviderFor(SpyCount)
final spyCountProvider = AutoDisposeNotifierProvider<SpyCount, int>.internal(
  SpyCount.new,
  name: r'spyCountProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$spyCountHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SpyCount = AutoDisposeNotifier<int>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
