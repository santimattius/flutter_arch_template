import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter_arch_template/features/pictures/data/datasources/local_data_source.dart';
import 'package:flutter_arch_template/features/pictures/data/datasources/remote_data_source.dart';
import 'package:flutter_arch_template/features/pictures/data/repositories/pictures_repository_impl.dart';
import 'package:flutter_arch_template/features/pictures/domain/repositories/pictures_repository.dart';
import 'package:flutter_arch_template/features/pictures/domain/usecases/get_pictures.dart';
import 'package:flutter_arch_template/features/pictures/presentation/bloc/home_pictures_bloc.dart';
import 'package:flutter_arch_template/shared/network/network_info.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features
  sl.registerFactory<HomePicturesBloc>(
    () => HomePicturesBloc(pictures: sl()),
  );
  // Use cases
  sl.registerLazySingleton(() => GetPictures(sl()));

  // Repository
  sl.registerLazySingleton<PicturesRepository>(
    () => PicturesRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<PicturesRemoteDataSource>(
    () => PicturesRemoteDataSourceImpl(client: sl()),
  );

  sl.registerLazySingleton<PicturesLocalDataSource>(
    () => SharedPreferencesLocalDataSourceImpl(sharedPreferences: sl()),
  );

  //! Share
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
}
