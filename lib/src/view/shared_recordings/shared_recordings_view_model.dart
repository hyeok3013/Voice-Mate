import 'package:voice_mate/src/data/model/recording_model.dart';
import 'package:voice_mate/src/repository/recording_repository.dart';
import 'package:voice_mate/src/view/base_view_model.dart';

class SharedRecordingsViewModel extends BaseViewModel {
  SharedRecordingsViewModel({
    required RecordingRepository repository,
  }) : _repository = repository;

  final RecordingRepository _repository;
  List<RecordingModel> _recordings = [];
  Map<String, List<RecordingModel>> _repliesMap = {};

  List<RecordingModel> get recordings => _recordings;
  Map<String, List<RecordingModel>> get repliesMap => _repliesMap;

  Future<void> loadRecordings() async {
    try {
      final allRecordings = await _repository.getSharedRecordings();

      // 원본 메시지와 답장을 분리
      _recordings = allRecordings.where((r) => !r.isReply).toList();

      // 답장을 원본 메시지 ID를 기준으로 그룹화
      _repliesMap = {};
      for (var reply in allRecordings.where((r) => r.isReply)) {
        if (reply.originalRecordingId != null) {
          _repliesMap.putIfAbsent(reply.originalRecordingId!, () => []);
          _repliesMap[reply.originalRecordingId]!.add(reply);
        }
      }

      notifyListeners();
    } catch (e) {
      print('녹음 목록 로드 실패: $e');
      rethrow;
    }
  }
}
