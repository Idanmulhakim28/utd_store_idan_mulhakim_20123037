import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// PRODUCT
import '../../features/product/data/datasource/product_remote_datasource.dart';
import '../../features/product/data/repositories/product_repository_impl.dart';
import '../../features/product/domain/repositories/product_repository.dart';
import '../../features/product/domain/usecases/get_products.dart';
import '../../features/product/presentation/cubit/product_cubit.dart';

/// SPLASH
import '../../features/splash/domain/usecases/get_splash_delay.dart';

/// BOOKMARK
import '../../features/bookmark/data/datasource/bookmark_local_datasource.dart';
import '../../features/bookmark/data/repositories/bookmark_repository_impl.dart';
import '../../features/bookmark/domain/repositories/bookmark_repository.dart';

final locator = GetIt.instance;

Future<void> setupLocator() async {
  // =========================
  // 🔥 HIVE
  // =========================
  await Hive.initFlutter();

  final bookmarkBox = await Hive.openBox('bookmarks');

  locator.registerLazySingleton<Box>(() => bookmarkBox);

  // =========================
  // 🔥 SPLASH
  // =========================
  locator.registerLazySingleton<GetSplashDelay>(() => GetSplashDelay(20123037));

  // =========================
  // 🔥 PRODUCT
  // =========================

  // datasource
  locator.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(),
  );

  // repository
  locator.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(locator<ProductRemoteDataSource>()),
  );

  // usecase
  locator.registerLazySingleton<GetProducts>(
    () => GetProducts(locator<ProductRepository>()),
  );

  // cubit
  locator.registerFactory<ProductCubit>(
    () => ProductCubit(locator<GetProducts>()),
  );

  // =========================
  // 🔥 BOOKMARK
  // =========================

  // datasource
  locator.registerLazySingleton<BookmarkLocalDataSource>(
    () => BookmarkLocalDataSourceImpl(locator<Box>()),
  );

  // repository
  locator.registerLazySingleton<BookmarkRepository>(
    () => BookmarkRepositoryImpl(locator<Box>()),
  );
}
