import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'recording_model.freezed.dart';
part 'recording_model.g.dart';

@freezed
class RecordingModel with _$RecordingModel {
  const factory RecordingModel({
    required String id,
    required String userId,
    required String url,
    required DateTime timestamp,
    @Default(false) bool isReply,
    String? originalRecordingId,
  }) = _RecordingModel;

  factory RecordingModel.fromJson(Map<String, dynamic> json) =>
      _$RecordingModelFromJson(json);

  // Firestore 변환을 위한 팩토리 생성자
  factory RecordingModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return RecordingModel(
      id: doc.id,
      userId: data['userId'] as String,
      url: data['url'] as String,
      timestamp: (data['timestamp'] as Timestamp).toDate(),
      isReply: data['isReply'] as bool? ?? false,
      originalRecordingId: data['originalRecordingId'] as String?,
    );
  }
}
