import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skybase/config/environment/app_env.dart';

/* Created by
   Varcant
   nanda.kista@gmail.com
*/

final dioProvider = Provider<Dio>((ref) {
  final Dio dio = Dio();
  dio.options.baseUrl = AppEnv.config.baseUrl;
  dio.options.connectTimeout = const Duration(seconds: 60);
  dio.options.receiveTimeout = const Duration(seconds: 30);
  return dio;
});
