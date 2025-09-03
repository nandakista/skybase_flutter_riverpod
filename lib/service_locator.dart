import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:skybase/config/base/main_navigation.dart';

import 'config/app/app_info.dart';

/* Created by
   Varcant
   nanda.kista@gmail.com
*/

final sl = GetIt.instance;

class ServiceLocator {
  static Future<void> init() async {
    if (kReleaseMode) debugPrint = (String? message, {int? wrapWidth}) {};
    AppInfo.setInfo(await PackageInfo.fromPlatform());

    sl.registerLazySingleton(() => Navigation());
  }
}
