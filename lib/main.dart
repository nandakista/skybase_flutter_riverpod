import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skybase/config/themes/theme_manager.dart';
import 'package:skybase/core/localization/locale_notifier.dart';

import 'config/auth_manager/auth_manager.dart';
import 'config/themes/app_theme.dart';
import 'core/database/storage/storage_manager.dart';
import 'service_locator.dart';
import 'ui/routes/app_routes.dart';
import 'ui/views/404_500/crash_error_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Initializer.init();
  final sharedPreferences = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
      ],
      child: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          final localeNotifier = ref.read(localeProvider.notifier);
          final startLocale = ref.watch(localeProvider);

          return EasyLocalization(
            path: 'lib/core/localization/languages',
            supportedLocales: localeNotifier.locales.values.toList(),
            startLocale: startLocale,
            fallbackLocale: localeNotifier.fallbackLocale,
            useFallbackTranslations: true,
            child: const App(),
          );
        },
      ),
    ),
  );
}

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeManagerProvider);
    final notifier = ref.read(authManagerProvider.notifier);
    ref.listen(authManagerProvider, (prev, next) {
      notifier.onAuthChanged(ref.watch(authManagerProvider));
    });

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Skybase Riverpod',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: (isDarkMode) ? ThemeMode.dark : ThemeMode.light,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      routeInformationParser: AppRoutes.router.routeInformationParser,
      routeInformationProvider: AppRoutes.router.routeInformationProvider,
      routerDelegate: AppRoutes.router.routerDelegate,
      builder: (BuildContext context, child) {
        ErrorWidget.builder = (FlutterErrorDetails error) {
          return CrashErrorView(errorDetails: error);
        };
        return child ?? const SizedBox.shrink();
      },
    );
  }
}
