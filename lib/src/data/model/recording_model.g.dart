// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recording_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RecordingModelImpl _$$RecordingModelImplFromJson(Map<String, dynamic> json) =>
    _$RecordingModelImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      url: json['url'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      isReply: json['isReply'] as bool? ?? false,
      originalRecordingId: json['originalRecordingId'] as String?,
    );

Map<String, dynamic> _$$RecordingModelImplToJson(
        _$RecordingModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'url': instance.url,
      'timestamp': instance.timestamp.toIso8601String(),
      'isReply': instance.isReply,
      'originalRecordingId': instance.originalRecordingId,
    };
