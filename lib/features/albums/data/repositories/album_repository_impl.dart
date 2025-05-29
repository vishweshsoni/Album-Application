import 'package:album/core/database/database_helper.dart';
import 'package:album/core/di/injection.dart';
import 'package:album/features/albums/domain/entities/album.dart';
import 'package:album/features/albums/domain/repositories/album_repository.dart';
import 'package:album/service/api_service.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/cupertino.dart';

class AlbumRepositoryImpl implements AlbumRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  @override
  Future<List<Album>> getAll() async {
    // Try to get data from the local database first
    final localAlbums = await _databaseHelper.getAlbums();
    if (localAlbums.isNotEmpty) {
      // Return cached data immediately
      // print('Returning albums from cache'); // Optional: for debugging
      return localAlbums;
    }

    // If no data in cache, fetch from network
    // print('Fetching albums from network'); // Optional: for debugging
    try {
      Response<List<Album>> response = await getIt<ApiService>().getAlbums();
      if (response.statusCode == 200 && response.body != null) {
        final networkAlbums = response.body!;
        // Store network data in the database
        await _databaseHelper.insertAlbums(networkAlbums);
        // Return network data
        return networkAlbums;
      } else {
        // Handle non-200 status codes or empty body from network
        throw Exception('Failed to fetch albums from network: ${response.statusCode}');
      }
    } catch (e) {
      // Handle network errors
      debugPrint('Network error fetching albums: $e'); // Optional: for debugging
      rethrow; // Rethrow the exception to be handled by the BLoC
    }
  }
}
