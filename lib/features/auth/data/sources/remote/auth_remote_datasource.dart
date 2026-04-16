import 'package:dio/dio.dart';
import 'package:doaa_gado/core/constants/api_endpoints.dart';
import 'package:doaa_gado/data/network/api_services.dart';
import 'package:doaa_gado/features/auth/data/models/auth_models.dart';
import 'package:injectable/injectable.dart';


abstract class AuthRemoteDataSource {
  Future<BaseResponseModel<LoginResponseModel>> login(LoginRequestModel request);
  Future<BaseResponseModel<RegisterResponseModel>> register(RegisterRequestModel request);
}

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiService _apiService;

  AuthRemoteDataSourceImpl(this._apiService);

  @override
  Future<BaseResponseModel<LoginResponseModel>> login(LoginRequestModel request) async {
    final response = await _apiService.post(
      ApiEndpoints.loginEndpoint,
      data: request.toJson(),
    );

    return BaseResponseModel.fromJson(
      response.data,
      (json) => LoginResponseModel.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<BaseResponseModel<RegisterResponseModel>> register(RegisterRequestModel request) async {
    final response = await _apiService.post(
      ApiEndpoints.registerEndpoint,
      data: request.toJson(),
    );

    return BaseResponseModel.fromJson(
      response.data,
      (json) => RegisterResponseModel.fromJson(json as Map<String, dynamic>),
    );
  }
}
