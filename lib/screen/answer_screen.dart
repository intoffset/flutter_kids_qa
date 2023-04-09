import 'package:flutter/material.dart';
import 'package:flutter_kids_qa/screen/answer_viewmodel.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AnswerScreen extends StatelessWidget {
  const AnswerScreen({super.key, required this.query});

  static const String name = 'Answer';

  final String query;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('こたえ'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  query,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 32),
                Align(
                  alignment: Alignment.topLeft,
                  child: AnswerWidget(query: query),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AnswerWidget extends ConsumerWidget {
  const AnswerWidget({super.key, required this.query});
  final String query;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(answerViewModelProvider(query));
    return Text(
      viewModel.answer,
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }
}
