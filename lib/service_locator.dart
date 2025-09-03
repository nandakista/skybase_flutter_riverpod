import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'config/app/app_info.dart';

/* Created by
   Varcant
   nanda.kista@gmail.com
*/

class Initializer {
  static Future<void> init() async {
    if (kReleaseMode) debugPrint = (String? message, {int? wrapWidth}) {};
    AppInfo.setInfo(await PackageInfo.fromPlatform());
  }
}
