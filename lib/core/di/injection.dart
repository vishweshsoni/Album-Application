import 'package:album/features/albums/domain/repositories/album_repository.dart';
import 'package:album/features/albums/data/repositories/album_repository_impl.dart';
import 'package:album/features/albums/domain/repositories/photo_repository.dart';
import 'package:album/features/albums/data/repositories/photo_repository_impl.dart';
import 'package:album/features/home/presentation/bloc/home_bloc.dart';
import 'package:album/service/api_service.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  // Register GetIt itself
  getIt.registerSingleton<GetIt>(getIt);

  // Services
  getIt.registerSingleton<ApiService>(ApiService.create());

  // Repositories
  getIt.registerLazySingleton<AlbumRepositoryImpl>(
    () => AlbumRepositoryImpl(),
  );
  getIt.registerLazySingleton<PhotoRepositoryImpl>(
    () => PhotoRepositoryImpl(),
  );

  // Initialize SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(sharedPreferences);

  // Register HomeBloc
  getIt.registerFactory<HomeBloc>(() => HomeBloc());
}
