import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skybase/config/themes/theme_manager.dart';
import 'package:skybase/ui/widgets/sky_appbar.dart';

class ThemeComponentUtilsView extends ConsumerStatefulWidget {
  static const String route = 'theme-component';

  const ThemeComponentUtilsView({super.key});

  @override
  ConsumerState<ThemeComponentUtilsView> createState() =>
      _ThemeComponentUtilsViewState();
}

class _ThemeComponentUtilsViewState
    extends ConsumerState<ThemeComponentUtilsView> {
  bool switchValue = false;

  @override
  Widget build(BuildContext context) {
    final isDark = ref.watch(themeManagerProvider);

    return Scaffold(
      appBar: SkyAppBar.secondary(title: 'Theme Component'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Is Dark Mode'),
                Switch(
                  value: isDark,
                  onChanged: (value) {
                    ref.read(themeManagerProvider.notifier).changeTheme();
                  },
                ),
              ],
            ),
            RadioGroup(
              groupValue: true,
              onChanged: (value) => setState(() {
                switchValue = !switchValue;
              }),
              child: Column(
                children: [
                  Radio(value: switchValue),
                ],
              ),
            ),
            Switch(
              value: switchValue,
              onChanged: (value) => setState(() {
                switchValue = !switchValue;
              }),
            ),
            Checkbox(
              value: switchValue,
              onChanged: (value) => setState(() {
                switchValue = !switchValue;
              }),
            ),
          ],
        ),
      ),
    );
  }
}
