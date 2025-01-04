import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:voice_mate/src/data/model/recording_model.dart';

class RecordingRepository {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> uploadRecording(String localPath, String userId) async {
    try {
      // 파일명 생성 (타임스탬프 사용)
      final fileName =
          'recordings/${userId}_${DateTime.now().millisecondsSinceEpoch}.aac';
      final ref = _storage.ref().child(fileName);

      // 파일 업로드
      await ref.putFile(File(localPath));
      final downloadUrl = await ref.getDownloadURL();

      // Firestore에 메타데이터 저장
      await _firestore.collection('recordings').add({
        'userId': userId,
        'url': downloadUrl,
        'timestamp': FieldValue.serverTimestamp(),
        'isReply': false,
        'originalRecordingId': null,
      });

      return downloadUrl;
    } catch (e) {
      print('업로드 실패: $e');
      rethrow;
    }
  }

  Future<List<RecordingModel>> getSharedRecordings() async {
    try {
      final snapshot = await _firestore
          .collection('recordings')
          .orderBy('timestamp', descending: true)
          .get();

      return snapshot.docs
          .map((doc) => RecordingModel.fromFirestore(doc))
          .toList();
    } catch (e) {
      print('녹음 목록 조회 실패: $e');
      rethrow;
    }
  }

  Future<void> addReply(String originalRecordingId, String replyUrl) async {
    try {
      final userId = _auth.currentUser?.uid;
      if (userId == null) {
        throw Exception('사용자가 로그인되어 있지 않습니다.');
      }

      await _firestore.collection('recordings').add({
        'userId': userId,
        'url': replyUrl,
        'timestamp': FieldValue.serverTimestamp(),
        'isReply': true,
        'originalRecordingId': originalRecordingId,
      });
    } catch (e) {
      print('답장 저장 실패: $e');
      rethrow;
    }
  }
}
