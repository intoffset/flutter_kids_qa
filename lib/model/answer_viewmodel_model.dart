import 'package:freezed_annotation/freezed_annotation.dart';

part 'answer_viewmodel_model.freezed.dart';

@freezed
class AnswerViewModel with _$AnswerViewModel {
  const AnswerViewModel._();

  const factory AnswerViewModel({
    required String answer,
  }) = _AnswerViewModel;

  factory AnswerViewModel.empty() => const AnswerViewModel(answer: '');
}
