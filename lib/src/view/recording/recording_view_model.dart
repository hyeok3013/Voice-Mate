import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:voice_mate/src/view/base_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:voice_mate/src/repository/recording_repository.dart';

class RecordingViewModel extends BaseViewModel {
  RecordingViewModel({
    required RecordingRepository repository,
    AudioRecorder? recorder,
    AudioPlayer? player,
  })  : _repository = repository,
        _recorder = recorder ?? AudioRecorder(),
        _player = player ?? AudioPlayer();

  final RecordingRepository _repository;
  final AudioRecorder _recorder;
  final AudioPlayer _player;

  String _recordedFilePath = '';
  bool _isRecording = false;
  bool _isPlaying = false;
  bool _isRecorderInitialized = false;
  bool _isReplyMode = false;
  String? _originalRecordingId;
  String _targetNickname = '모두에게';

  bool get isRecording => _isRecording;
  bool get isPlaying => _isPlaying;
  bool get isReplyMode => _isReplyMode;
  String get targetNickname => _targetNickname;

  void setReplyMode(String originalRecordingId, String targetNickname) {
    _isReplyMode = true;
    _originalRecordingId = originalRecordingId;
    _targetNickname = targetNickname;
    notifyListeners();
  }

  Future<void> uploadRecording() async {
    if (_recordedFilePath.isEmpty) return;

    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) throw Exception('사용자가 로그인되어 있지 않습니다.');

      if (_isReplyMode && _originalRecordingId != null) {
        final url =
            await _repository.uploadRecording(_recordedFilePath, userId);
        await _repository.addReply(_originalRecordingId!, url);
      } else {
        await _repository.uploadRecording(_recordedFilePath, userId);
      }
    } catch (e) {
      print('업로드 실패: $e');
      rethrow;
    }
  }

  Future<void> initRecorder() async {
    try {
      final status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        throw '마이크 권한이 필요합니다';
      }

      _isRecorderInitialized = true;
    } catch (e) {
      print('레코더 초기화 실패: $e');
      rethrow;
    }
  }

  Future<void> startRecording() async {
    if (!_isRecorderInitialized) {
      await initRecorder();
    }

    try {
      final directory = await getApplicationDocumentsDirectory();
      _recordedFilePath =
          '${directory.path}/recording_${DateTime.now().millisecondsSinceEpoch}.aac';

      print('녹음 시작 - 파일 경로: $_recordedFilePath');
      await _recorder.start(
        RecordConfig(
          encoder: AudioEncoder.aacLc,
          bitRate: 64000, // 음성용으로 충분
          sampleRate: 44100, // 표준 품질
          numChannels: 1, // 모노 녹음으로 크기 절약
        ),
        path: _recordedFilePath,
      );

      _isRecording = true;
      notifyListeners();
    } catch (e) {
      print('녹음 시작 실패: $e');
      rethrow;
    }
  }

  Future<void> stopRecording() async {
    if (!_isRecording) return;

    try {
      final path = await _recorder.stop();
      print('녹음 중지 - 저장된 파일 경로: $path');

      if (path != null) {
        _recordedFilePath = path;
        final file = File(path);
        final exists = await file.exists();
        final fileSize = exists ? await file.length() : 0;
        print('파일 존재 여부: $exists, 파일 크기: $fileSize bytes');
      }

      _isRecording = false;
      notifyListeners();
    } catch (e) {
      print('녹음 중지 실패: $e');
      rethrow;
    }
  }

  Future<void> playRecording() async {
    if (_recordedFilePath.isEmpty) {
      print('재생할 녹음 파일이 없습니다');
      return;
    }

    try {
      if (_isPlaying) {
        await pausePlaying();
        return;
      }

      final file = File(_recordedFilePath);
      if (!await file.exists()) {
        print('재생 실패: 파일이 존재하지 않음 - $_recordedFilePath');
        return;
      }

      print('재생 시작 - 파일 경로: $_recordedFilePath');
      await _player.play(DeviceFileSource(_recordedFilePath));

      _player.onPlayerComplete.listen((_) {
        _isPlaying = false;
        notifyListeners();
      });

      _isPlaying = true;
      notifyListeners();
    } catch (e) {
      print('재생 실패: $e');
      _isPlaying = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<void> pausePlaying() async {
    if (!_isPlaying) return;

    try {
      await _player.pause();
      _isPlaying = false;
      notifyListeners();
    } catch (e) {
      print('일시정지 실패: $e');
      rethrow;
    }
  }

  void resetTarget() {
    _isReplyMode = false;
    _originalRecordingId = null;
    _targetNickname = '모두에게';
    notifyListeners();
  }

  @override
  void dispose() {
    _recorder.dispose();
    _player.dispose();
    super.dispose();
  }
}
