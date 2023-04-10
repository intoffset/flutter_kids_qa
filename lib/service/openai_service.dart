import 'package:dart_openai/openai.dart';

class OpenAIService {
  static const defaultChatModel = 'gpt-3.5-turbo-0301';

  static final OpenAIService _instance = OpenAIService._internal();

  factory OpenAIService() => _instance;

  OpenAIService._internal();

  static initialize(String apiKey) {
    OpenAI.apiKey = apiKey;
  }

  Future<List<OpenAIModelModel>> getModels() async => await OpenAI.instance.model.list();

  Future<OpenAIChatCompletionModel> postMessage(List<OpenAIChatCompletionChoiceMessageModel> messages,
      {String model = defaultChatModel}) async {
    final completion = await OpenAI.instance.chat.create(
      model: model,
      messages: messages,
    );
    return completion;
  }

  Stream<OpenAIStreamChatCompletionModel> postMessageStream(List<OpenAIChatCompletionChoiceMessageModel> messages,
      {String model = defaultChatModel}) {
    final stream = OpenAI.instance.chat.createStream(
      model: model,
      messages: messages,
    );
    return stream;
  }

  Future<OpenAIModerationModel> moderate(String input) {
    return OpenAI.instance.moderation.create(
      input: input,
    );
  }
}
