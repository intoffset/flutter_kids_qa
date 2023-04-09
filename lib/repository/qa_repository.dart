import 'package:collection/collection.dart';
import 'package:dart_openai/openai.dart';
import 'package:flutter_kids_qa/service/openai_service.dart';
import 'package:flutter_kids_qa/util/logger.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class QaRepository {
  QaRepository();
  final openAiService = OpenAIService();

  Stream<String> getAnswerStream(String query) {
    final messages = [
      OpenAIChatCompletionChoiceMessageModel(
        role: OpenAIChatMessageRole.system,
        content: 'あなたは未就学児向けのアシスタントです。この後の質問には、漢字を一切使わずに子供向けにわかりやすく答えてください。',
      ),
      OpenAIChatCompletionChoiceMessageModel(role: OpenAIChatMessageRole.user, content: query),
    ];
    String answer = '';
    return openAiService.postMessageStream(messages).map((response) {
      final deltaContent = response.choices.firstOrNull?.delta.content ?? '';
      answer = answer + deltaContent;
      return answer;
    });
  }
}

final qaRepositoryProvider = Provider.autoDispose((ref) {
  return QaRepository();
});
