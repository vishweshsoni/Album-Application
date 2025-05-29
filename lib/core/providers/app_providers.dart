import 'package:album/core/di/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:album/features/home/presentation/bloc/home_bloc.dart';
import 'package:get_it/get_it.dart';

class AppProviders extends StatelessWidget {
  final Widget child;

  const AppProviders({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    // Ensure GetIt is initialized before accessing it
    if (!GetIt.instance.isRegistered<GetIt>()) {
      throw Exception('Dependency injection not initialized. Call setupDependencies() before using AppProviders.');
    }
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<HomeBloc>()..add(const HomeEvent.loadAlbums()),
        ),
        // Add more bloc providers here as needed
      ],
      child: child,
    );
  }
} 