import 'dart:ui';

class LocaleHelper {
  static T builder<T>({
    required Locale locale,
    required T en,
    required T id,
  }) {
    if (locale.languageCode == 'en') {
      return en;
    } else {
      return id;
    }
  }
}