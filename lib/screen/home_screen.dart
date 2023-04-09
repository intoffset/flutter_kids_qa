import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_kids_qa/repository/theme_mode_reopsitory.dart';
import 'package:flutter_kids_qa/screen/answer_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const String name = 'Home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('しつもん しよう'),
        centerTitle: true,
      ),
      body: const QuestionForm(),
      drawer: const HomeDrawer(),
    );
  }
}

class QuestionForm extends HookConsumerWidget {
  const QuestionForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final queryController = useTextEditingController();
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: queryController,
              style: const TextStyle(fontSize: 32),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'インターネット',
              ),
              textAlign: TextAlign.center,
              autofocus: true,
              minLines: 1,
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            OutlinedButton(
              child: const Text('ってなに？'),
              onPressed: () {
                FocusManager.instance.primaryFocus?.unfocus();
                context.goNamed(
                  AnswerScreen.name,
                  queryParams: {'query': queryController.text + 'ってなに？'},
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class HomeDrawer extends ConsumerWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.info_outline_rounded),
            title: const Text('ライセンス'),
            onTap: () => showLicensePage(context: context),
          ),
          const Divider(),
          _themeModeToTile(
            ref.watch(themeModeProvider),
            () async => await ref.read(themeModeProvider.notifier).toggle(),
          ),
        ],
      ),
    );
  }

  ListTile _themeModeToTile(ThemeMode mode, void Function() toggle) {
    switch (mode) {
      case ThemeMode.light:
        return ListTile(
          leading: const Icon(Icons.light_mode_rounded),
          title: const Text('あかるい'),
          onTap: toggle,
        );
      case ThemeMode.dark:
        return ListTile(
          leading: const Icon(Icons.dark_mode_rounded),
          title: const Text('くらい'),
          onTap: toggle,
        );
      case ThemeMode.system:
        return ListTile(
          leading: const Icon(Icons.smartphone_rounded),
          title: const Text('おまかせ'),
          onTap: toggle,
        );
    }
  }
}
