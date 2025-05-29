import 'package:album/album_app.dart';
import 'package:album/core/bloc_observer.dart';
import 'package:album/core/di/injection.dart';
import 'package:album/features/home/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show Bloc;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  await setupDependencies();
  runApp(const AlbumApp());
}
