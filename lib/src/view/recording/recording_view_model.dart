import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:voice_mate/src/view/base_view_model.dart';

class RecordingViewModel extends BaseViewModel {
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  final FlutterSoundPlayer _player = FlutterSoundPlayer();
  bool _isRecorderInitialized = false;
  bool _isPlayerInitialized = false;
  bool _isRecording = false;
  bool _isPlaying = false;
  String? _recordedFilePath;

  bool get isRecording => _isRecording;
  bool get isPlaying => _isPlaying;

  Future<void> initializeRecorder() async {
    try {
      // 여러 권한 동시 요청
      Map<Permission, PermissionStatus> statuses = await [
        Permission.microphone,
        Permission.storage,
      ].request();

      // 마이크 권한 확인
      if (statuses[Permission.microphone] != PermissionStatus.granted) {
        throw RecordingPermissionException('마이크 권한이 필요합니다.');
      }

      // 저장소 권한 확인 (Android용)
      if (statuses[Permission.storage] != PermissionStatus.granted) {
        throw RecordingPermissionException('저장소 권한이 필요합니다.');
      }

      await _recorder.openRecorder();
      await _player.openPlayer();
      _isRecorderInitialized = true;
      _isPlayerInitialized = true;
      notifyListeners();
    } catch (e) {
      print('Recorder initialization failed: $e');
      rethrow;
    }
  }

  Future<void> startRecording() async {
    if (!_isRecorderInitialized) return;

    await _recorder.startRecorder(
      toFile: 'temp_recording.aac',
      codec: Codec.aacADTS,
    );
    _isRecording = true;
    _recordedFilePath = 'temp_recording.aac';
    notifyListeners();
  }

  Future<void> stopRecording() async {
    if (!_isRecorderInitialized) return;

    await _recorder.stopRecorder();
    _isRecording = false;
    notifyListeners();
  }

  Future<void> playRecording() async {
    if (!_isPlayerInitialized || _recordedFilePath == null) return;

    await _player.startPlayer(
      fromURI: _recordedFilePath,
      codec: Codec.aacADTS,
    );
    _isPlaying = true;
    notifyListeners();
  }

  Future<void> stopPlaying() async {
    if (!_isPlayerInitialized) return;

    await _player.stopPlayer();
    _isPlaying = false;
    notifyListeners();
  }

  @override
  void dispose() {
    _recorder.closeRecorder();
    _player.closePlayer();
    super.dispose();
  }
}

class RecordingPermissionException implements Exception {
  final String message;
  RecordingPermissionException(this.message);
}
