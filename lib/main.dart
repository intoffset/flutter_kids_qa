import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_kids_qa/repository/theme_mode_reopsitory.dart';
import 'package:flutter_kids_qa/screen/home_screen.dart';
import 'package:flutter_kids_qa/shared_preferences/shared_preferences_instance.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load();
  await SharedPreferencesInstance.initialize();
  runApp(
    const ProviderScope(
      child: KidsQaApp(),
    ),
  );
}

class KidsQaApp extends ConsumerWidget {
  const KidsQaApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DynamicColorBuilder(
      builder: (lightColorSchema, darkColorSchema) => MaterialApp.router(
        title: 'Flutter Kids QA',
        theme: _buildTheme(Brightness.light, lightColorSchema),
        darkTheme: _buildTheme(Brightness.dark, darkColorSchema),
        themeMode: ref.watch(themeModeProvider),
        routerConfig: _router,
      ),
    );
  }
}

ThemeData _buildTheme(Brightness brightness, ColorScheme? colorScheme) {
  var baseTheme = ThemeData(
    useMaterial3: true,
    brightness: brightness,
    colorScheme: colorScheme,
  );

  return baseTheme.copyWith(
    textTheme: GoogleFonts.zenKakuGothicNewTextTheme(baseTheme.textTheme),
  );
}

final _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      name: HomeScreen.name,
      path: '/',
      builder: (context, state) => const HomeScreen(),
      routes: [],
    ),
  ],
);
