import 'package:record/record.dart';

class RecordService {
  static final AudioRecorder _recorder = AudioRecorder();

  static final RecordService _instance = RecordService._internal();

  factory RecordService() => _instance;

  RecordService._internal();

  void startRecord(String path) async {
    if (await _recorder.hasPermission()) {
      await _recorder.start(const RecordConfig(), path: path);
    }
  }

  Future<String?> stopRecord() async {
    return await _recorder.stop();
  }

  Future<bool> get isRecording => _recorder.isRecording();

  Stream<RecordState> get recordStateStream => _recorder.onStateChanged();
}
