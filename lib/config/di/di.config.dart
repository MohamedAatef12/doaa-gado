// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:talker/talker.dart' as _i993;

import '../../data/caching/cache_manager.dart' as _i676;
import '../../data/caching/secure_storage_helper.dart' as _i640;
import '../../data/caching/shared_prefs_helper.dart' as _i293;
import '../../data/network/api_services.dart' as _i655;
import '../../features/auth/data/repos/auth_repository_impl.dart' as _i1006;
import '../../features/auth/data/sources/remote/auth_remote_datasource.dart'
    as _i1047;
import '../../features/auth/domain/repositories/auth_repository.dart' as _i787;
import '../../features/auth/domain/usecases/login_user.dart' as _i778;
import '../../features/auth/domain/usecases/sign_up.dart' as _i190;
import '../../features/auth/presentation/blocs/auth_bloc.dart' as _i85;
import '../../features/home/data/repositories/home_repository_impl.dart'
    as _i76;
import '../../features/home/domain/repositories/home_repository.dart' as _i0;
import '../../features/home/presentation/blocs/home_bloc.dart' as _i1061;
import '../env/app_config.dart' as _i92;
import 'di_module.dart' as _i211;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final dIModule = _$DIModule();
    gh.lazySingleton<_i640.SecureStorageHelper>(
      () => _i640.SecureStorageHelper(),
    );
    gh.lazySingleton<_i293.SharedPrefsHelper>(() => _i293.SharedPrefsHelper());
    gh.lazySingleton<_i0.HomeRepository>(() => _i76.HomeRepositoryImpl());
    gh.lazySingleton<_i676.CacheManager>(
      () => _i676.CacheManager(
        sharedPrefs: gh<_i293.SharedPrefsHelper>(),
        secureStorage: gh<_i640.SecureStorageHelper>(),
      ),
    );
    gh.lazySingleton<_i361.Dio>(
      () => dIModule.dio(gh<_i92.AppConfig>(), gh<_i993.Talker>()),
    );
    gh.factory<_i1061.HomeBloc>(
      () => _i1061.HomeBloc(gh<_i0.HomeRepository>()),
    );
    gh.lazySingleton<_i655.ApiService>(() => _i655.ApiService(gh<_i361.Dio>()));
    gh.lazySingleton<_i1047.AuthRemoteDataSource>(
      () => _i1047.AuthRemoteDataSourceImpl(gh<_i655.ApiService>()),
    );
    gh.lazySingleton<_i787.AuthRepository>(
      () => _i1006.AuthRepositoryImpl(
        gh<_i1047.AuthRemoteDataSource>(),
        gh<_i676.CacheManager>(),
      ),
    );
    gh.factory<_i778.LoginUseCase>(
      () => _i778.LoginUseCase(gh<_i787.AuthRepository>()),
    );
    gh.factory<_i190.RegisterUseCase>(
      () => _i190.RegisterUseCase(gh<_i787.AuthRepository>()),
    );
    gh.factory<_i85.AuthBloc>(
      () => _i85.AuthBloc(
        loginUseCase: gh<_i778.LoginUseCase>(),
        registerUseCase: gh<_i190.RegisterUseCase>(),
      ),
    );
    return this;
  }
}

class _$DIModule extends _i211.DIModule {}
