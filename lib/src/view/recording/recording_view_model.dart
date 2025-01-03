import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:voice_mate/src/view/base_view_model.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class RecordingViewModel extends BaseViewModel {
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  final FlutterSoundPlayer _player = FlutterSoundPlayer();

  bool _isRecording = false;
  bool _isPlaying = false;
  String? _recordedFilePath;
  bool _isRecorderInitialized = false;
  bool _isPlayerInitialized = false;

  bool get isRecording => _isRecording;
  bool get isPlaying => _isPlaying;

  Future<void> initRecorder() async {
    if (!_isRecorderInitialized) {
      final status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        throw '마이크 권한이 필요합니다';
      }

      await _recorder.openRecorder();
      await _player.openPlayer();
      _isRecorderInitialized = true;
      _isPlayerInitialized = true;
    }
  }

  Future<void> startRecording() async {
    if (!_isRecorderInitialized) return;

    final directory = await getTemporaryDirectory();
    _recordedFilePath =
        '${directory.path}/temp_recording${Platform.isIOS ? '.m4a' : '.aac'}';

    await _recorder.startRecorder(
      toFile: _recordedFilePath,
      codec: Platform.isIOS ? Codec.aacMP4 : Codec.aacADTS,
    );

    _isRecording = true;
    notifyListeners();
  }

  Future<void> stopRecording() async {
    if (!_isRecorderInitialized || !_isRecording) return;

    await _recorder.stopRecorder();
    _isRecording = false;
    notifyListeners();
  }

  Future<void> playRecording() async {
    if (!_isPlayerInitialized || _recordedFilePath == null) {
      print('재생 실패: 녹음된 파일이 없습니다.');
      return;
    }

    try {
      if (_isPlaying) {
        // 이미 재생 중이면 일시정지
        await pausePlaying();
      } else {
        final file = File(_recordedFilePath!);
        if (!await file.exists()) {
          print('재생 실패: 파일이 존재하지 않습니다. 경로: $_recordedFilePath');
          return;
        }

        await _player.startPlayer(
          fromURI: _recordedFilePath,
          codec: Platform.isIOS ? Codec.aacMP4 : Codec.aacADTS,
          whenFinished: () {
            _isPlaying = false;
            notifyListeners();
          },
        );
        _isPlaying = true;
        notifyListeners();
      }
    } catch (e) {
      print('재생 실패: $e');
      rethrow;
    }
  }

  Future<void> pausePlaying() async {
    if (!_isPlayerInitialized || !_isPlaying) return;

    await _player.pausePlayer();
    _isPlaying = false;
    notifyListeners();
  }

  Future<void> stopPlaying() async {
    if (!_isPlayerInitialized || !_isPlaying) return;

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
