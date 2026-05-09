import 'package:go_router/go_router.dart';

import '../../features/splash/presentation/pages/splash_page.dart';
import '../../features/product/presentation/pages/product_page.dart';
import '../../features/bookmark/presentation/pages/bookmark_page.dart';
import '../../features/crypto/presentation/pages/bitcoin_page.dart';
import '../../features/device/presentation/pages/batteray_page.dart';

final router = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: true,

  routes: [
    // 🔥 SPLASH
    GoRoute(path: '/', builder: (context, state) => const SplashPage()),

    // 🔥 HOME PRODUCT
    GoRoute(path: '/home', builder: (context, state) => const ProductPage()),

    // 🔖 BOOKMARK
    GoRoute(
      path: '/bookmark',
      builder: (context, state) => const BookmarkPage(),
    ),

    // 📈 CRYPTO
    GoRoute(path: '/crypto', builder: (context, state) => const BitcoinPage()),

    // 🔋 BATTERY NATIVE
    GoRoute(path: '/battery', builder: (context, state) => const BatteryPage()),
  ],
);
