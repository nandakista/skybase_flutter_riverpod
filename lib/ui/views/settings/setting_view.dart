import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:skybase/config/app/app_info.dart';
import 'package:skybase/config/themes/app_style.dart';
import 'package:skybase/config/themes/theme_manager.dart';
import 'package:skybase/ui/views/settings/setting_notifier.dart';
import 'package:skybase/ui/widgets/colored_status_bar.dart';
import 'package:skybase/ui/widgets/sky_appbar.dart';
import 'package:skybase/ui/widgets/sky_button.dart';

class SettingView extends ConsumerWidget {
  static const String route = '/setting';

  const SettingView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final languageCode = ref.watch(settingProvider);
    final isDark = ref.watch(themeManagerProvider);

    final settingNotifier = ref.read(settingProvider.notifier);

    return ColoredStatusBar.primary(
      child: Scaffold(
        appBar: SkyAppBar.secondary(title: 'txt_setting'.tr()),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.fromLTRB(
            24,
            12,
            24,
            MediaQuery.paddingOf(context).bottom + 12,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${'txt_version'.tr()} ${AppInfo.appVersion}',
                style: AppStyle.body2.copyWith(color: Colors.grey),
              ),
              const SizedBox(height: 12),
              SkyButton(
                onPressed: () {
                  settingNotifier.onLogout(context);
                },
                text: 'txt_logout'.tr(),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(child: Text('txt_language'.tr())),
                  Flexible(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        RadioGroup(
                          groupValue: languageCode,
                          onChanged: (value) {
                            settingNotifier.onUpdateLocale(
                              context,
                              languageCode: value.toString(),
                            );
                          },
                          child: Row(
                            children: [
                              const Text('ENG'),
                              Radio(value: 'en'),
                              const Text('ID'),
                              Radio(value: 'id'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const Divider(color: Colors.grey),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('txt_dark_mode'.tr()),
                  Switch(
                    value: isDark,
                    onChanged: (value) {
                      ref.read(themeManagerProvider.notifier).changeTheme();
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
