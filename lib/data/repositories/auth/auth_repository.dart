import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skybase/config/base/request_param.dart';
import 'package:skybase/data/models/repo/repo.dart';
import 'package:skybase/data/models/user/user.dart';
import 'package:skybase/data/sources/server/auth/auth_sources.dart';

import 'auth_repository_impl.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final apiService = ref.watch(authSourcesProvider);
  return AuthRepositoryImpl(apiService: apiService);
});

abstract interface class AuthRepository {
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
    required RequestParams requestParams,
    required String username,
  });

  Future<List<Repo>> getProfileRepository({
    required RequestParams requestParams,
    required String username,
  });
}
