// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reservation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ReservationEntity {
  ReservationStatus get status => throw _privateConstructorUsedError;
  int? get price => throw _privateConstructorUsedError;
  int get fromTime => throw _privateConstructorUsedError;
  String? get userName => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ReservationEntityCopyWith<ReservationEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReservationEntityCopyWith<$Res> {
  factory $ReservationEntityCopyWith(
          ReservationEntity value, $Res Function(ReservationEntity) then) =
      _$ReservationEntityCopyWithImpl<$Res, ReservationEntity>;
  @useResult
  $Res call(
      {ReservationStatus status, int? price, int fromTime, String? userName});
}

/// @nodoc
class _$ReservationEntityCopyWithImpl<$Res, $Val extends ReservationEntity>
    implements $ReservationEntityCopyWith<$Res> {
  _$ReservationEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? price = freezed,
    Object? fromTime = null,
    Object? userName = freezed,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ReservationStatus,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as int?,
      fromTime: null == fromTime
          ? _value.fromTime
          : fromTime // ignore: cast_nullable_to_non_nullable
              as int,
      userName: freezed == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReservationEntityImplCopyWith<$Res>
    implements $ReservationEntityCopyWith<$Res> {
  factory _$$ReservationEntityImplCopyWith(_$ReservationEntityImpl value,
          $Res Function(_$ReservationEntityImpl) then) =
      __$$ReservationEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {ReservationStatus status, int? price, int fromTime, String? userName});
}

/// @nodoc
class __$$ReservationEntityImplCopyWithImpl<$Res>
    extends _$ReservationEntityCopyWithImpl<$Res, _$ReservationEntityImpl>
    implements _$$ReservationEntityImplCopyWith<$Res> {
  __$$ReservationEntityImplCopyWithImpl(_$ReservationEntityImpl _value,
      $Res Function(_$ReservationEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? price = freezed,
    Object? fromTime = null,
    Object? userName = freezed,
  }) {
    return _then(_$ReservationEntityImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ReservationStatus,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as int?,
      fromTime: null == fromTime
          ? _value.fromTime
          : fromTime // ignore: cast_nullable_to_non_nullable
              as int,
      userName: freezed == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$ReservationEntityImpl implements _ReservationEntity {
  _$ReservationEntityImpl(
      {required this.status,
      this.price,
      required this.fromTime,
      this.userName});

  @override
  final ReservationStatus status;
  @override
  final int? price;
  @override
  final int fromTime;
  @override
  final String? userName;

  @override
  String toString() {
    return 'ReservationEntity(status: $status, price: $price, fromTime: $fromTime, userName: $userName)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReservationEntityImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.fromTime, fromTime) ||
                other.fromTime == fromTime) &&
            (identical(other.userName, userName) ||
                other.userName == userName));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, status, price, fromTime, userName);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ReservationEntityImplCopyWith<_$ReservationEntityImpl> get copyWith =>
      __$$ReservationEntityImplCopyWithImpl<_$ReservationEntityImpl>(
          this, _$identity);
}

abstract class _ReservationEntity implements ReservationEntity {
  factory _ReservationEntity(
      {required final ReservationStatus status,
      final int? price,
      required final int fromTime,
      final String? userName}) = _$ReservationEntityImpl;

  @override
  ReservationStatus get status;
  @override
  int? get price;
  @override
  int get fromTime;
  @override
  String? get userName;
  @override
  @JsonKey(ignore: true)
  _$$ReservationEntityImplCopyWith<_$ReservationEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
