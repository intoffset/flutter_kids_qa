import 'package:record/record.dart';

class RecordService {
  static final Record _record = Record();

  static final RecordService _instance = RecordService._internal();

  factory RecordService() => _instance;

  RecordService._internal();

  void startRecord(String? path) async {
    if (await _record.hasPermission()) {
      await _record.start(path: path);
    }
  }

  Future<String?> stopRecord() async {
    return await _record.stop();
  }

  Future<bool> get isRecording => _record.isRecording();

  Stream<RecordState> get recordStateStream => _record.onStateChanged();
}
