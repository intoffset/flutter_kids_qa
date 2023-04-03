import 'package:flutter/material.dart';
import 'package:flutter_kids_qa/repository/theme_mode_reopsitory.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const String name = 'Home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
      ),
      drawer: const HomeDrawer(),
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
            title: const Text('Abount'),
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
          title: const Text('Light'),
          onTap: toggle,
        );
      case ThemeMode.dark:
        return ListTile(
          leading: const Icon(Icons.dark_mode_rounded),
          title: const Text('Dark'),
          onTap: toggle,
        );
      case ThemeMode.system:
        return ListTile(
          leading: const Icon(Icons.smartphone_rounded),
          title: const Text('System'),
          onTap: toggle,
        );
    }
  }
}
