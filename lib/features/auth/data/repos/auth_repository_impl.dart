import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:doaa_gado/features/auth/domain/entities/auth_entities.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failure.dart';
import '../../../../data/caching/cache_manager.dart';
import '../models/auth_models.dart';
import '../sources/remote/auth_remote_datasource.dart';

import '../../domain/repositories/auth_repository.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final CacheManager _cacheManager;

  AuthRepositoryImpl(this._remoteDataSource, this._cacheManager);

  String _handleError(dynamic e) {
    if (e is DioException) {
      if (e.response?.data != null && e.response?.data is Map) {
        final data = e.response!.data as Map<String, dynamic>;
        return data['message'] ?? data['errors']?.toString() ?? e.message ?? 'Unknown error';
      }
      return e.message ?? 'Network error occurred';
    }
    return e.toString();
  }

  @override
  Future<Either<Failure, LoginEntity>> login({
    required int code,
    required String mobile,
  }) async {
    try {
      final response = await _remoteDataSource.login(
        LoginRequestModel(code: code, mobile: mobile),
      );

      if (response.statusCode == 200 && response.data != null) {
        await _cacheManager.saveTokens(
          access: response.data!.accessToken,
          refresh: response.data!.refreshToken,
        );

        return Right(LoginEntity(
          accessToken: response.data!.accessToken,
          refreshToken: response.data!.refreshToken,
        ));
      } else {
        return Left(ServerFailure(response.message));
      }
    } catch (e) {
      return Left(ServerFailure(_handleError(e)));
    }
  }

  @override
  Future<Either<Failure, RegisterEntity>> register({
    required String fullName,
    required String mobile,
    required DateTime birthdate,
  }) async {
    try {
      final response = await _remoteDataSource.register(
        RegisterRequestModel(
          fullName: fullName,
          mobile: mobile,
          birthdate: birthdate,
        ),
      );

      if (response.statusCode == 200 && response.data != null) {
        await _cacheManager.saveTokens(
          access: response.data!.accessToken,
          refresh: response.data!.refreshToken,
        );

        return Right(RegisterEntity(
          accessToken: response.data!.accessToken,
          refreshToken: response.data!.refreshToken,
        ));
      } else {
        return Left(ServerFailure(response.message));
      }
    } catch (e) {
      return Left(ServerFailure(_handleError(e)));
    }
  }
}
