import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skybase/config/network/api_request.dart';
import 'package:skybase/data/models/repo/repo.dart';
import 'package:skybase/data/models/user/user.dart';

import 'auth_sources_impl.dart';

final authSourcesProvider = Provider<AuthSources>((ref) {
  final apiRequest = ref.read(apiRequestProvider);
  return AuthSourcesImpl(apiRequest: apiRequest);
});

abstract class AuthSources {
  Future<User> verifyToken({
    required int userId,
    required String token,
  });

  Future<User> login({
    required String phoneNumber,
    required String email,
    required String password,
  });

  Future<User> getProfile({
    required CancelToken cancelToken,
    required String username,
  });

  Future<List<Repo>> getProfileRepository({
    required CancelToken cancelToken,
    required String username,
  });
}
