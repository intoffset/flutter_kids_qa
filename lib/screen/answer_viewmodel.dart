import 'dart:async';

import 'package:flutter_kids_qa/model/answer_viewmodel_model.dart';
import 'package:flutter_kids_qa/repository/qa_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AnswerViewModelNotifier extends StateNotifier<AnswerViewModel> {
  AnswerViewModelNotifier({required qaRepository, required query})
      : _qaReporitory = qaRepository,
        _query = query,
        super(AnswerViewModel.empty()) {
    _subscription = _qaReporitory.getAnswerStreamWithModeration(query).listen((answer) {
      state = state.copyWith(answer: answer);
    });
  }

  final QaRepository _qaReporitory;
  final String _query;
  late final StreamSubscription _subscription;

  onDispose() {
    _subscription.cancel();
  }
}

final answerViewModelProvider =
    StateNotifierProvider.family.autoDispose<AnswerViewModelNotifier, AnswerViewModel, String>((ref, query) {
  final notifier = AnswerViewModelNotifier(qaRepository: ref.read(qaRepositoryProvider), query: query);
  ref.onDispose(notifier.onDispose);
  return notifier;
});
