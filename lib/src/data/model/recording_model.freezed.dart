// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recording_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RecordingModel _$RecordingModelFromJson(Map<String, dynamic> json) {
  return _RecordingModel.fromJson(json);
}

/// @nodoc
mixin _$RecordingModel {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  bool get isReply => throw _privateConstructorUsedError;
  String? get originalRecordingId => throw _privateConstructorUsedError;

  /// Serializes this RecordingModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RecordingModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RecordingModelCopyWith<RecordingModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecordingModelCopyWith<$Res> {
  factory $RecordingModelCopyWith(
          RecordingModel value, $Res Function(RecordingModel) then) =
      _$RecordingModelCopyWithImpl<$Res, RecordingModel>;
  @useResult
  $Res call(
      {String id,
      String userId,
      String url,
      DateTime timestamp,
      bool isReply,
      String? originalRecordingId});
}

/// @nodoc
class _$RecordingModelCopyWithImpl<$Res, $Val extends RecordingModel>
    implements $RecordingModelCopyWith<$Res> {
  _$RecordingModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RecordingModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? url = null,
    Object? timestamp = null,
    Object? isReply = null,
    Object? originalRecordingId = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isReply: null == isReply
          ? _value.isReply
          : isReply // ignore: cast_nullable_to_non_nullable
              as bool,
      originalRecordingId: freezed == originalRecordingId
          ? _value.originalRecordingId
          : originalRecordingId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RecordingModelImplCopyWith<$Res>
    implements $RecordingModelCopyWith<$Res> {
  factory _$$RecordingModelImplCopyWith(_$RecordingModelImpl value,
          $Res Function(_$RecordingModelImpl) then) =
      __$$RecordingModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      String url,
      DateTime timestamp,
      bool isReply,
      String? originalRecordingId});
}

/// @nodoc
class __$$RecordingModelImplCopyWithImpl<$Res>
    extends _$RecordingModelCopyWithImpl<$Res, _$RecordingModelImpl>
    implements _$$RecordingModelImplCopyWith<$Res> {
  __$$RecordingModelImplCopyWithImpl(
      _$RecordingModelImpl _value, $Res Function(_$RecordingModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of RecordingModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? url = null,
    Object? timestamp = null,
    Object? isReply = null,
    Object? originalRecordingId = freezed,
  }) {
    return _then(_$RecordingModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isReply: null == isReply
          ? _value.isReply
          : isReply // ignore: cast_nullable_to_non_nullable
              as bool,
      originalRecordingId: freezed == originalRecordingId
          ? _value.originalRecordingId
          : originalRecordingId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RecordingModelImpl implements _RecordingModel {
  const _$RecordingModelImpl(
      {required this.id,
      required this.userId,
      required this.url,
      required this.timestamp,
      this.isReply = false,
      this.originalRecordingId});

  factory _$RecordingModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$RecordingModelImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String url;
  @override
  final DateTime timestamp;
  @override
  @JsonKey()
  final bool isReply;
  @override
  final String? originalRecordingId;

  @override
  String toString() {
    return 'RecordingModel(id: $id, userId: $userId, url: $url, timestamp: $timestamp, isReply: $isReply, originalRecordingId: $originalRecordingId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecordingModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.isReply, isReply) || other.isReply == isReply) &&
            (identical(other.originalRecordingId, originalRecordingId) ||
                other.originalRecordingId == originalRecordingId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, userId, url, timestamp, isReply, originalRecordingId);

  /// Create a copy of RecordingModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RecordingModelImplCopyWith<_$RecordingModelImpl> get copyWith =>
      __$$RecordingModelImplCopyWithImpl<_$RecordingModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RecordingModelImplToJson(
      this,
    );
  }
}

abstract class _RecordingModel implements RecordingModel {
  const factory _RecordingModel(
      {required final String id,
      required final String userId,
      required final String url,
      required final DateTime timestamp,
      final bool isReply,
      final String? originalRecordingId}) = _$RecordingModelImpl;

  factory _RecordingModel.fromJson(Map<String, dynamic> json) =
      _$RecordingModelImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get url;
  @override
  DateTime get timestamp;
  @override
  bool get isReply;
  @override
  String? get originalRecordingId;

  /// Create a copy of RecordingModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RecordingModelImplCopyWith<_$RecordingModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
