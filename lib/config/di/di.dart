// import 'package:dio/dio.dart';
// import 'package:get_it/get_it.dart';
// import 'package:talker_flutter/talker_flutter.dart';

// import '../../data/network/dio_factory.dart';
// import '../../data/network/api_services.dart';
// import '../../data/caching/cache_manager.dart';

// // Auth
// import '../../features/auth/data/sources/auth_remote_data_source.dart';
// import '../../features/auth/domain/repos/auth_repo.dart';
// import '../../features/auth/data/repos/auth_repo_impl.dart';
// import '../../features/auth/domain/usecases/login_usecase.dart';
// import '../../features/auth/views/bloc/login_bloc.dart';

// // Private Ride
// import '../../features/private_ride/data/sources/private_ride_remote_source.dart';
// import '../../features/private_ride/data/repos/private_ride_repo_impl.dart';
// import '../../features/private_ride/domain/repos/private_ride_repo.dart';
// import '../../features/private_ride/domain/usecases/calculate_price_usecase.dart';
// import '../../features/private_ride/domain/usecases/create_trip_usecase.dart';
// import '../../features/private_ride/domain/usecases/get_exchange_rates_usecase.dart';
// import '../../features/private_ride/domain/usecases/get_nearby_locations_usecase.dart';
// import '../../features/private_ride/domain/usecases/get_saved_places_usecase.dart';
// import '../../features/private_ride/domain/usecases/cancel_trip_usecase.dart';
// import '../../features/private_ride/domain/usecases/get_rating_options_usecase.dart';
// import '../../features/private_ride/domain/usecases/get_trip_by_id_usecase.dart';
// import '../../features/private_ride/domain/usecases/notify_stop_arrival_usecase.dart';
// import '../../features/private_ride/domain/usecases/notify_stop_departure_usecase.dart';
// import '../../features/private_ride/domain/usecases/save_place_usecase.dart';
// import '../../features/private_ride/domain/usecases/search_locations_usecase.dart';
// import '../../features/private_ride/domain/usecases/submit_rating_usecase.dart';
// import '../../features/private_ride/views/bloc/private_ride_bloc.dart';

// final getIt = GetIt.instance;

// void configureDependencies() {
//   final talker = TalkerFlutter.init();
//   getIt.registerLazySingleton<Talker>(() => talker);

//   final dioFactory = DioFactory();
//   getIt.registerLazySingleton<Dio>(() => dioFactory.createDio(talker));

//   getIt.registerLazySingleton<ApiService>(() => ApiService(getIt<Dio>()));
//   getIt.registerLazySingleton<CacheManager>(() => CacheManager());

//   // ── Auth ──────────────────────────────────────────────────────────────────
//   getIt.registerLazySingleton<AuthRemoteDataSource>(
//     () => AuthRemoteDataSourceImpl(getIt<ApiService>()),
//   );
//   getIt.registerLazySingleton<AuthRepo>(
//     () => AuthRepoImpl(getIt<AuthRemoteDataSource>(), getIt<CacheManager>()),
//   );
//   getIt.registerLazySingleton<LoginUseCase>(
//     () => LoginUseCase(getIt<AuthRepo>()),
//   );
//   getIt.registerFactory<LoginBloc>(() => LoginBloc(getIt<LoginUseCase>()));

//   // ── Private Ride ──────────────────────────────────────────────────────────
//   getIt.registerLazySingleton<PrivateRideRemoteSource>(
//     () => PrivateRideRemoteSourceImpl(getIt<ApiService>()),
//   );
//   getIt.registerLazySingleton<PrivateRideRepo>(
//     () => PrivateRideRepoImpl(getIt<PrivateRideRemoteSource>()),
//   );
//   getIt.registerLazySingleton<GetSavedPlacesUseCase>(
//     () => GetSavedPlacesUseCase(getIt<PrivateRideRepo>()),
//   );
//   getIt.registerLazySingleton<SavePlaceUseCase>(
//     () => SavePlaceUseCase(getIt<PrivateRideRepo>()),
//   );
//   getIt.registerLazySingleton<GetExchangeRatesUseCase>(
//     () => GetExchangeRatesUseCase(getIt<PrivateRideRepo>()),
//   );
//   getIt.registerLazySingleton<CalculatePriceUseCase>(
//     () => CalculatePriceUseCase(getIt<PrivateRideRepo>()),
//   );
//   getIt.registerLazySingleton<SearchLocationsUseCase>(
//     () => SearchLocationsUseCase(getIt<PrivateRideRepo>()),
//   );
//   getIt.registerLazySingleton<GetNearbyLocationsUseCase>(
//     () => GetNearbyLocationsUseCase(getIt<PrivateRideRepo>()),
//   );
//   getIt.registerLazySingleton<CreateTripUseCase>(
//     () => CreateTripUseCase(getIt<PrivateRideRepo>()),
//   );
//   getIt.registerLazySingleton<GetTripByIdUseCase>(
//     () => GetTripByIdUseCase(getIt<PrivateRideRepo>()),
//   );
//   getIt.registerLazySingleton<CancelTripUseCase>(
//     () => CancelTripUseCase(getIt<PrivateRideRepo>()),
//   );
//   getIt.registerLazySingleton<NotifyStopArrivalUseCase>(
//     () => NotifyStopArrivalUseCase(getIt<PrivateRideRepo>()),
//   );
//   getIt.registerLazySingleton<NotifyStopDepartureUseCase>(
//     () => NotifyStopDepartureUseCase(getIt<PrivateRideRepo>()),
//   );
//   getIt.registerLazySingleton<GetRatingOptionsUseCase>(
//     () => GetRatingOptionsUseCase(getIt<PrivateRideRepo>()),
//   );
//   getIt.registerLazySingleton<SubmitRatingUseCase>(
//     () => SubmitRatingUseCase(getIt<PrivateRideRepo>()),
//   );
//   getIt.registerFactory<PrivateRideBloc>(
//     () => PrivateRideBloc(
//       getSavedPlacesUseCase: getIt<GetSavedPlacesUseCase>(),
//       savePlaceUseCase: getIt<SavePlaceUseCase>(),
//       getExchangeRatesUseCase: getIt<GetExchangeRatesUseCase>(),
//       calculatePriceUseCase: getIt<CalculatePriceUseCase>(),
//       searchLocationsUseCase: getIt<SearchLocationsUseCase>(),
//       getNearbyLocationsUseCase: getIt<GetNearbyLocationsUseCase>(),
//       createTripUseCase: getIt<CreateTripUseCase>(),
//       getTripByIdUseCase: getIt<GetTripByIdUseCase>(),
//       cancelTripUseCase: getIt<CancelTripUseCase>(),
//       notifyStopArrivalUseCase: getIt<NotifyStopArrivalUseCase>(),
//       notifyStopDepartureUseCase: getIt<NotifyStopDepartureUseCase>(),
//       getRatingOptionsUseCase: getIt<GetRatingOptionsUseCase>(),
//       submitRatingUseCase: getIt<SubmitRatingUseCase>(),
//       cacheManager: getIt<CacheManager>(),
//     ),
//   );
// }
