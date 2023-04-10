import 'dart:async';

import 'package:collection/collection.dart';
import 'package:dart_openai/openai.dart';
import 'package:flutter_kids_qa/service/openai_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stream_transform/stream_transform.dart';

class QaRepository {
  QaRepository();

  final openAiService = OpenAIService();

  Future<bool> _moderate(String input) {
    return openAiService.moderate(input).then((value) {
      final result = value.results.firstOrNull;
      if (result == null) {
        throw Exception('Moderation failed');
      }
      return result.flagged;
    });
  }

  Stream<String> getAnswerStream(String query) {
    final messages = [
      OpenAIChatCompletionChoiceMessageModel(
        role: OpenAIChatMessageRole.system,
        content: 'あなたは小学生向けのアシスタントです。この後の質問には、漢字を一切使わずに子供向けにわかりやすく答えてください。',
      ),
      OpenAIChatCompletionChoiceMessageModel(role: OpenAIChatMessageRole.user, content: query),
    ];

    final answerStream = openAiService.postMessageStream(messages).scan('', (answerPrev, response) {
      final deltaContent = response.choices.firstOrNull?.delta.content ?? '';
      final answer = answerPrev + deltaContent;
      return answer;
    });

    return answerStream;
  }

  Stream<String> getAnswerStreamWithModeration(String query) {
    final moderationStream = _moderate(query).asStream();

    return moderationStream.switchMap((flagged) {
      if (flagged) {
        return Stream.fromIterable(['この質問は自分や他人を傷つける危険があるため回答できません。']);
      }
      return getAnswerStream(query);
    });
  }
}

final qaRepositoryProvider = Provider.autoDispose((ref) {
  return QaRepository();
});

class ModerationFlaggedException implements Exception {
  final String message;
  ModerationFlaggedException(this.message);
}
