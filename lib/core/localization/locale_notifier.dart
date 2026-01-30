import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:skybase/config/themes/app_colors.dart';
import 'package:skybase/config/themes/app_style.dart';
import 'package:skybase/config/base/navigation.dart';
import 'package:skybase/core/database/storage/storage_key.dart';
import 'package:skybase/core/database/storage/storage_manager.dart';
import 'package:skybase/ui/widgets/sky_dialog.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

/* Created by
   Varcant
   nanda.kista@gmail.com
*/

part 'locale_notifier.g.dart';

@riverpod
class LocaleNotifier extends _$LocaleNotifier {
  late final StorageManager _storage;

  final Map<String, Locale> locales = const {
    'English': Locale('en'),
    'Indonesia': Locale('id'),
  };

  final fallbackLocale = const Locale('en');

  @override
  Locale build() {
    _storage = ref.read(storageManagerProvider);
    if (_storage.has(StorageKey.CURRENT_LOCALE)) {
      return _storage.get<String>(StorageKey.CURRENT_LOCALE).toLocale();
    }
    return fallbackLocale;
  }

  Future<void> updateLocale(BuildContext context, Locale locale) async {
    await _storage.save<String>(
      StorageKey.CURRENT_LOCALE,
      locale.languageCode,
    );
    state = locale;
    if (context.mounted) {
      context.setLocale(locale);
    }
    await WidgetsBinding.instance.performReassemble();
  }

  void showLocaleDialog(BuildContext context, Navigation navigation) {
    showDialog(
      context: context,
      builder: (context) {
        return SkyDialog(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'txt_choose_language'.tr(),
                style: AppStyle.subtitle2.copyWith(
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 16),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: locales.length,
                separatorBuilder: (_, __) => const Divider(thickness: 1.5),
                itemBuilder: (context, index) {
                  final entry = locales.entries.elementAt(index);
                  return InkWell(
                    onTap: () {
                      updateLocale(context, entry.value);
                      navigation.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        entry.key,
                        style: AppStyle.body1,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
