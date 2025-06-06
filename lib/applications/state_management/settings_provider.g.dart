// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$themeModeSettingHash() => r'70904c7f117edbc844ae65057c479d985d34e843';

/// See also [ThemeModeSetting].
@ProviderFor(ThemeModeSetting)
final themeModeSettingProvider =
    AutoDisposeNotifierProvider<ThemeModeSetting, ThemeMode>.internal(
      ThemeModeSetting.new,
      name: r'themeModeSettingProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$themeModeSettingHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ThemeModeSetting = AutoDisposeNotifier<ThemeMode>;
String _$localeSettingHash() => r'707f9e89b31b3fa7d81e37da1cca9a25b538729a';

/// See also [LocaleSetting].
@ProviderFor(LocaleSetting)
final localeSettingProvider =
    AutoDisposeNotifierProvider<LocaleSetting, Locale>.internal(
      LocaleSetting.new,
      name: r'localeSettingProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$localeSettingHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$LocaleSetting = AutoDisposeNotifier<Locale>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
