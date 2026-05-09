import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/di/injection.dart';
import 'core/routes/app_router.dart';

// 🔥 FIX IMPORT YANG BENAR
import 'features/crypto/data/websocket_service.dart';
import 'features/crypto/data/crypto_repository_impl.dart';
import 'features/crypto/presentation/cubit/crypto_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox('bookmarks');

  await setupLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) {
            final repo = CryptoRepositoryImpl(WebSocketService());
            return CryptoCubit(repo)..start();
          },
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: router,
      ),
    );
  }
}
