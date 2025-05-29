import 'package:album/features/albums/domain/entities/album.dart';
import 'package:album/features/albums/domain/entities/photo.dart';
import 'package:album/features/home/presentation/bloc/home_bloc.dart';
import 'package:album/features/home/presentation/widgets/photo_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:io';
import 'package:album/core/constant/strings.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc()..add(const HomeEvent.loadAlbums()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(Strings.albums),
        ),
        body: BlocConsumer<HomeBloc, HomeState>(
          listener: (context, state) {
            state.maybeWhen(
              error: (message) {
                String errorMessage = message;
                if (message.contains('SocketException')) {
                  errorMessage = Strings.noInternetConnection;
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(errorMessage),
                    backgroundColor: Colors.red,
                    duration: const Duration(seconds: 3),
                    action: SnackBarAction(
                      label: Strings.retry,
                      textColor: Colors.white,
                      onPressed: () {
                        context.read<HomeBloc>().add(const HomeEvent.loadAlbums());
                      },
                    ),
                  ),
                );
              },
              orElse: () {},
            );
          },
          builder: (context, state) {
            return state.map(
              initial: (_) => const SizedBox.shrink(),
              loading: (_) => const Center(child: CircularProgressIndicator()),
              error: (error) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, size: 48, color: Colors.red),
                    const SizedBox(height: 16),
                    Text(
                      error.message.contains('SocketException')
                          ? Strings.noInternetConnectionShort
                          : Strings.somethingWentWrong,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        context.read<HomeBloc>().add(const HomeEvent.loadAlbums());
                      },
                      child: const Text(Strings.retry),
                    ),
                  ],
                ),
              ),
              loaded: (loaded) => _buildLoadedState(context, loaded.albums, loaded.photos),
            );
          },
        ),
      ),
    );
  }

  Widget _buildLoadedState(BuildContext context, List<Album> albums, Map<int, List<Photo>> allPhotos) {
    // Use a very large number for infinite-like scrolling
    final int infiniteScrollCount = albums.length * 1000; // Arbitrary large number

    return ListView.builder(
      itemCount: infiniteScrollCount,
      itemBuilder: (context, index) {
        final albumIndex = index % albums.length; // Loop index
        final album = albums[albumIndex];
        final albumPhotos = allPhotos[album.id] ?? [];
        return _AlbumCard(
          album: album,
          photos: albumPhotos,
          onTap: () {
            // If we want to do something when the album card is tapped,
            // we can add logic here. For now, photos are loaded by default.
          },
        );
      },
    );
  }
}

class _AlbumCard extends StatelessWidget {
  final Album album;
  final List<Photo> photos;
  final VoidCallback onTap;

  const _AlbumCard({
    required this.album,
    required this.photos,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Use a large number for infinite-like horizontal scrolling
    final int infinitePhotoScrollCount = photos.length * 1000; // Arbitrary large number

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              album.title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            // Display the photos in a horizontal scrollable list
            if (photos.isNotEmpty)
              SizedBox(
                height: 100, // Adjust height as needed for the horizontal list
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: infinitePhotoScrollCount,
                  itemBuilder: (context, index) {
                    final photoIndex = index % photos.length; // Loop index
                    final photo = photos[photoIndex];
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0), // Space between images
                      child: SizedBox(
                        width: 100, // Width of each photo item
                        child: CachedNetworkImage(
                          imageUrl: photo.thumbnailUrl,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) => const Placeholder(),
                        ),
                      ),
                    );
                  },
                ),
              )
            else
              const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
} 