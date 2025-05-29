import 'package:album/core/providers/app_providers.dart';
import 'package:album/core/routes/app_routes.dart';
import 'package:album/core/constant/strings.dart';
import 'package:flutter/material.dart';

class AlbumApp extends StatelessWidget {
  const AlbumApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppProviders(
      child: MaterialApp(
        title: Strings.appTitle,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: AppRouter.home,
        onGenerateRoute: AppRouter.generateRoute,
      ),
    );
  }
}
