// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_session_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GameSessionState {

 Duration get remaining; Duration get total; bool get godMode; List<Player> get punishPlayers; bool get isTimerRunning; bool get isTimeout;
/// Create a copy of GameSessionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GameSessionStateCopyWith<GameSessionState> get copyWith => _$GameSessionStateCopyWithImpl<GameSessionState>(this as GameSessionState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GameSessionState&&(identical(other.remaining, remaining) || other.remaining == remaining)&&(identical(other.total, total) || other.total == total)&&(identical(other.godMode, godMode) || other.godMode == godMode)&&const DeepCollectionEquality().equals(other.punishPlayers, punishPlayers)&&(identical(other.isTimerRunning, isTimerRunning) || other.isTimerRunning == isTimerRunning)&&(identical(other.isTimeout, isTimeout) || other.isTimeout == isTimeout));
}


@override
int get hashCode => Object.hash(runtimeType,remaining,total,godMode,const DeepCollectionEquality().hash(punishPlayers),isTimerRunning,isTimeout);

@override
String toString() {
  return 'GameSessionState(remaining: $remaining, total: $total, godMode: $godMode, punishPlayers: $punishPlayers, isTimerRunning: $isTimerRunning, isTimeout: $isTimeout)';
}


}

/// @nodoc
abstract mixin class $GameSessionStateCopyWith<$Res>  {
  factory $GameSessionStateCopyWith(GameSessionState value, $Res Function(GameSessionState) _then) = _$GameSessionStateCopyWithImpl;
@useResult
$Res call({
 Duration remaining, Duration total, bool godMode, List<Player> punishPlayers, bool isTimerRunning, bool isTimeout
});




}
/// @nodoc
class _$GameSessionStateCopyWithImpl<$Res>
    implements $GameSessionStateCopyWith<$Res> {
  _$GameSessionStateCopyWithImpl(this._self, this._then);

  final GameSessionState _self;
  final $Res Function(GameSessionState) _then;

/// Create a copy of GameSessionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? remaining = null,Object? total = null,Object? godMode = null,Object? punishPlayers = null,Object? isTimerRunning = null,Object? isTimeout = null,}) {
  return _then(_self.copyWith(
remaining: null == remaining ? _self.remaining : remaining // ignore: cast_nullable_to_non_nullable
as Duration,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as Duration,godMode: null == godMode ? _self.godMode : godMode // ignore: cast_nullable_to_non_nullable
as bool,punishPlayers: null == punishPlayers ? _self.punishPlayers : punishPlayers // ignore: cast_nullable_to_non_nullable
as List<Player>,isTimerRunning: null == isTimerRunning ? _self.isTimerRunning : isTimerRunning // ignore: cast_nullable_to_non_nullable
as bool,isTimeout: null == isTimeout ? _self.isTimeout : isTimeout // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [GameSessionState].
extension GameSessionStatePatterns on GameSessionState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GameSessionState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GameSessionState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GameSessionState value)  $default,){
final _that = this;
switch (_that) {
case _GameSessionState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GameSessionState value)?  $default,){
final _that = this;
switch (_that) {
case _GameSessionState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Duration remaining,  Duration total,  bool godMode,  List<Player> punishPlayers,  bool isTimerRunning,  bool isTimeout)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GameSessionState() when $default != null:
return $default(_that.remaining,_that.total,_that.godMode,_that.punishPlayers,_that.isTimerRunning,_that.isTimeout);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Duration remaining,  Duration total,  bool godMode,  List<Player> punishPlayers,  bool isTimerRunning,  bool isTimeout)  $default,) {final _that = this;
switch (_that) {
case _GameSessionState():
return $default(_that.remaining,_that.total,_that.godMode,_that.punishPlayers,_that.isTimerRunning,_that.isTimeout);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Duration remaining,  Duration total,  bool godMode,  List<Player> punishPlayers,  bool isTimerRunning,  bool isTimeout)?  $default,) {final _that = this;
switch (_that) {
case _GameSessionState() when $default != null:
return $default(_that.remaining,_that.total,_that.godMode,_that.punishPlayers,_that.isTimerRunning,_that.isTimeout);case _:
  return null;

}
}

}

/// @nodoc


class _GameSessionState implements GameSessionState {
  const _GameSessionState({required this.remaining, required this.total, this.godMode = false, final  List<Player> punishPlayers = const [], this.isTimerRunning = false, this.isTimeout = false}): _punishPlayers = punishPlayers;
  

@override final  Duration remaining;
@override final  Duration total;
@override@JsonKey() final  bool godMode;
 final  List<Player> _punishPlayers;
@override@JsonKey() List<Player> get punishPlayers {
  if (_punishPlayers is EqualUnmodifiableListView) return _punishPlayers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_punishPlayers);
}

@override@JsonKey() final  bool isTimerRunning;
@override@JsonKey() final  bool isTimeout;

/// Create a copy of GameSessionState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GameSessionStateCopyWith<_GameSessionState> get copyWith => __$GameSessionStateCopyWithImpl<_GameSessionState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GameSessionState&&(identical(other.remaining, remaining) || other.remaining == remaining)&&(identical(other.total, total) || other.total == total)&&(identical(other.godMode, godMode) || other.godMode == godMode)&&const DeepCollectionEquality().equals(other._punishPlayers, _punishPlayers)&&(identical(other.isTimerRunning, isTimerRunning) || other.isTimerRunning == isTimerRunning)&&(identical(other.isTimeout, isTimeout) || other.isTimeout == isTimeout));
}


@override
int get hashCode => Object.hash(runtimeType,remaining,total,godMode,const DeepCollectionEquality().hash(_punishPlayers),isTimerRunning,isTimeout);

@override
String toString() {
  return 'GameSessionState(remaining: $remaining, total: $total, godMode: $godMode, punishPlayers: $punishPlayers, isTimerRunning: $isTimerRunning, isTimeout: $isTimeout)';
}


}

/// @nodoc
abstract mixin class _$GameSessionStateCopyWith<$Res> implements $GameSessionStateCopyWith<$Res> {
  factory _$GameSessionStateCopyWith(_GameSessionState value, $Res Function(_GameSessionState) _then) = __$GameSessionStateCopyWithImpl;
@override @useResult
$Res call({
 Duration remaining, Duration total, bool godMode, List<Player> punishPlayers, bool isTimerRunning, bool isTimeout
});




}
/// @nodoc
class __$GameSessionStateCopyWithImpl<$Res>
    implements _$GameSessionStateCopyWith<$Res> {
  __$GameSessionStateCopyWithImpl(this._self, this._then);

  final _GameSessionState _self;
  final $Res Function(_GameSessionState) _then;

/// Create a copy of GameSessionState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? remaining = null,Object? total = null,Object? godMode = null,Object? punishPlayers = null,Object? isTimerRunning = null,Object? isTimeout = null,}) {
  return _then(_GameSessionState(
remaining: null == remaining ? _self.remaining : remaining // ignore: cast_nullable_to_non_nullable
as Duration,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as Duration,godMode: null == godMode ? _self.godMode : godMode // ignore: cast_nullable_to_non_nullable
as bool,punishPlayers: null == punishPlayers ? _self._punishPlayers : punishPlayers // ignore: cast_nullable_to_non_nullable
as List<Player>,isTimerRunning: null == isTimerRunning ? _self.isTimerRunning : isTimerRunning // ignore: cast_nullable_to_non_nullable
as bool,isTimeout: null == isTimeout ? _self.isTimeout : isTimeout // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
