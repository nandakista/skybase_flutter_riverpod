import 'dart:ui';

import 'package:intl/intl.dart';
import 'package:skybase/core/localization/locale_helper.dart';

/* Created by
   Varcant
   nanda.kista@gmail.com
*/
extension DateTimeExt on DateTime {
  DateTime copy() =>
      DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch, isUtc: isUtc);

  String format({
    String locale = 'id',
    String format = 'dd MMM yyyy',
    String? idFormat,
  }) {
    // String local = StorageManager.instance.get(StorageKey.CURRENT_LOCALE) ?? 'id';
    return LocaleHelper.builder<String>(
      locale: Locale(locale),
      en: DateFormat(format, locale).format(this),
      id: DateFormat(idFormat ?? format, locale).format(this),
    );
  }

  String todayddMMMyyyy({String locale = 'id'}) =>
      format(format: 'EEEE, dd MMM yyyy', locale: locale);

  String toHHmm({String locale = 'id'}) => format(format: 'HH:mm', locale: locale);

  String toyyyyMMdd({String locale = 'id'}) => format(format: 'yyyy-MM-dd', locale: locale);

  String todMMyyyy({String locale = 'id'}) => format(format: 'd MMMM yyyy', locale: locale);

  String toddMMyyyy({String locale = 'id'}) => format(format: 'dd-MMMM-yyyy', locale: locale);

  String toMMddyyyy({String locale = 'id'}) => format(format: 'MM/dd/yyyy', locale: locale);

  String toTimestamp({String locale = 'id'}) =>
      format(format: 'yyyy-MM-dd HH:mm:ss', locale: locale);
}
