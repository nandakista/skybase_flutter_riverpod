import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skybase/config/environment/app_env.dart';
import 'package:skybase/config/network/api_interceptor.dart';

import 'api_config.dart';
import 'api_exception.dart';

/* Created by
   Varcant
   nanda.kista@gmail.com
*/
final apiRequestProvider = Provider<ApiRequest>((ref) {
  final NetworkUtilsRequest networkUtils = ref.read(networkUtilsProvider);
  return ApiRequest(dio: networkUtils.dio, networkUtils: networkUtils);
});

/// Base Request for calling API.
/// * Can be modify as needed.
class ApiRequest {
  final NetworkUtilsRequest networkUtils;
  final Dio dio;

  ApiRequest({required this.networkUtils, required this.dio});

  Map<String, String> headers = {
    HttpHeaders.authorizationHeader: '',
  };

  Future<Response> post({
    required String url,
    bool useToken = true,
    String? contentType = Headers.jsonContentType,
    Object? body,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
  }) async {
    await networkUtils.tokenManager(headers, useToken);
    return await networkUtils.safeFetch(
      () => dio.post(
        url,
        data: networkUtils.setBody(contentType: contentType, body: body),
        options: Options(headers: headers, contentType: contentType),
        queryParameters: queryParameters,
        cancelToken: cancelToken,
      ),
    );
  }

  Future<Response> get({
    required String url,
    bool useToken = true,
    String? contentType = Headers.jsonContentType,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
  }) async {
    await networkUtils.tokenManager(headers, useToken);
    return await networkUtils.safeFetch(
      () => dio.get(
        url,
        options: Options(headers: headers, contentType: contentType),
        queryParameters: queryParameters,
        cancelToken: cancelToken,
      ),
    );
  }

  Future<Response> patch({
    required String url,
    bool useToken = true,
    String? contentType = Headers.jsonContentType,
    Object? body,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
  }) async {
    await networkUtils.tokenManager(headers, useToken);
    return await networkUtils.safeFetch(
      () => dio.patch(
        url,
        data: networkUtils.setBody(contentType: contentType, body: body),
        options: Options(headers: headers, contentType: contentType),
        queryParameters: queryParameters,
        cancelToken: cancelToken,
      ),
    );
  }

  Future<Response> put({
    required String url,
    bool useToken = true,
    String? contentType = Headers.jsonContentType,
    Object? body,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
  }) async {
    await networkUtils.tokenManager(headers, useToken);
    return await networkUtils.safeFetch(
      () => dio.put(
        url,
        data: networkUtils.setBody(contentType: contentType, body: body),
        options: Options(headers: headers, contentType: contentType),
        queryParameters: queryParameters,
        cancelToken: cancelToken,
      ),
    );
  }

  Future<Response> delete({
    required String url,
    bool useToken = true,
    String? contentType = Headers.jsonContentType,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
  }) async {
    await networkUtils.tokenManager(headers, useToken);
    return await networkUtils.safeFetch(
      () => dio.delete(
        url,
        options: Options(headers: headers),
        queryParameters: queryParameters,
        cancelToken: cancelToken,
      ),
    );
  }
}

final networkUtilsProvider = Provider<NetworkUtilsRequest>((ref) {
  final Dio dio = ref.read(dioProvider);
  final ApiInterceptors apiInterceptors = ref.read(apiInterceptorsProvider);
  return NetworkUtilsRequest(dio: dio, apiInterceptors: apiInterceptors);
});

final class NetworkUtilsRequest with NetworkException {
  final Dio dio;
  final ApiInterceptors apiInterceptors;

  NetworkUtilsRequest({required this.dio, required this.apiInterceptors});

  Object? setBody({
    required String? contentType,
    required Object? body,
  }) {
    if (contentType == Headers.jsonContentType) {
      return body = jsonEncode(body);
    } else if (contentType == Headers.formUrlEncodedContentType) {
      return body;
    } else if (contentType == Headers.multipartFormDataContentType) {
      (body as Map<String, dynamic>).removeWhere((k, v) => v == null);
      return FormData.fromMap(body);
    } else {
      return null;
    }
  }

  Future<void> tokenManager(Map<String, String> headers, bool useToken) async {
    dio.interceptors.clear();
    dio.interceptors.add(apiInterceptors);
    // String? token = await SecureStorageManager.instance.getToken();
    if (useToken) {
      headers[HttpHeaders.authorizationHeader] = 'token ${AppEnv.config.clientToken}';
    } else {
      headers.clear();
    }
  }

  Future<Response> safeFetch(Future<Response> Function() tryFetch) async {
    try {
      final response = await tryFetch();
      // return ApiResponse.fromJson(response.data);
      return response;
    } on DioException catch (e, stackTrace) {
      debugPrint('Api Request -> $e, $stackTrace');
      throw getErrorException(e);
    } catch (e, stackTrace) {
      debugPrint('Api Request -> $e, $stackTrace');
      rethrow;
    }
  }
}
