import 'package:album/features/home/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static const String home = '/';
  static const String album = '/album';
  static const String photoView = '/photo-view';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case album:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Album Screen'),
            ),
          ),
        );
      case photoView:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Photo View Screen'),
            ),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
