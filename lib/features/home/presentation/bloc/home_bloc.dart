import 'package:album/core/di/injection.dart';
import 'package:album/features/albums/data/repositories/album_repository_impl.dart';
import 'package:album/features/albums/data/repositories/photo_repository_impl.dart';
import 'package:album/features/albums/domain/entities/album.dart';
import 'package:album/features/albums/domain/entities/photo.dart';
import 'package:album/features/albums/domain/repositories/album_repository.dart';
import 'package:album/features/albums/domain/repositories/photo_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_event.dart';

part 'home_state.dart';

part 'home_bloc.freezed.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final AlbumRepository _albumRepository;
  final PhotoRepository _photoRepository;

  HomeBloc()
      : _albumRepository = getIt<AlbumRepositoryImpl>(),
        _photoRepository = getIt<PhotoRepositoryImpl>(),
        super(const HomeState.initial()) {
    on<HomeEvent>((event, emit) async {
      await event.map(
        loadAlbums: (_) => _onLoadAlbums(emit),
        loadPhotos: (e) => _onLoadPhotos(e, emit),
      );
    });
  }

  Future<void> _onLoadAlbums(Emitter<HomeState> emit) async {
    emit(const HomeState.loading());
    try {
      final albums = await _albumRepository.getAll();

      // Fetch photos for all albums concurrently
      final Map<int, List<Photo>> photosMap = {};
      await Future.wait(albums.map((album) async {
        try {
          final photos = await _photoRepository.getPhotosByAlbumId(album.id);
          photosMap[album.id] = photos;
        } catch (e) {
          // Log error but don't fail the whole process if photos for one album fail
          debugPrint('Error loading photos for album ${album.id}: $e');
          photosMap[album.id] = []; // Add empty list for albums with photo loading errors
        }
      }));

      emit(HomeState.loaded(
        albums,
        photos: photosMap,
      ));
    } catch (e) {
      emit(HomeState.error(e.toString()));
    }
  }

  Future<void> _onLoadPhotos(_LoadPhotos event, Emitter<HomeState> emit) async {
    if (state is _Loaded) {
      final currentState = state as _Loaded;
      try {
        final photos = await _photoRepository.getPhotosByAlbumId(event.albumId);
        final updatedPhotosMap = Map<int, List<Photo>>.from(currentState.photos)
          ..[event.albumId] = photos;
        emit(HomeState.loaded(
          currentState.albums,
          photos: updatedPhotosMap,
        ));
      } catch (e) {
        emit(HomeState.error('Error loading photos for album ${event.albumId}: $e'));
      }
    }
  }
}
