import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:zumrah/core/cubit/global_cubit.dart';
import 'package:zumrah/core/database/api/dio_consumer.dart';
import 'package:zumrah/core/network/local_network.dart';

import '../data/repo/settings_repo.dart';

final sl = GetIt.instance;
void initServiceLocator() {
//!external
  sl.registerLazySingleton(() => CacheHelper());
  sl.registerLazySingleton(() => GlobalCubit());
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => DioConsumer(sl<Dio>()));
  sl.registerLazySingleton(() => SettingsRepo(sl<DioConsumer>()));

  //! Repositorys
}
