// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'players_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$playerNamesHash() => r'ec0d1768c42bee696c513ad45a7583cbc6241756';

/// See also [PlayerNames].
@ProviderFor(PlayerNames)
final playerNamesProvider =
    NotifierProvider<PlayerNames, List<String>>.internal(
      PlayerNames.new,
      name: r'playerNamesProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$playerNamesHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$PlayerNames = Notifier<List<String>>;
String _$playersHash() => r'fb0f95f030d97508fcf31a1a78a23d19fc3b7200';

/// See also [Players].
@ProviderFor(Players)
final playersProvider = NotifierProvider<Players, List<Player>>.internal(
  Players.new,
  name: r'playersProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$playersHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Players = Notifier<List<Player>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
