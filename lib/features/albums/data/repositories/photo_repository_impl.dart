import 'package:album/core/database/database_helper.dart';
import 'package:album/core/di/injection.dart';
import 'package:album/features/albums/domain/entities/photo.dart';
import 'package:album/features/albums/domain/repositories/photo_repository.dart';
import 'package:album/service/api_service.dart';
import 'package:chopper/chopper.dart';

class PhotoRepositoryImpl implements PhotoRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  @override
  Future<List<Photo>> getPhotosByAlbumId(int albumId) async {
    // Try to get data from the local database first
    final localPhotos = await _databaseHelper.getPhotosByAlbumId(albumId);
    if (localPhotos.isNotEmpty) {
      // Return cached data immediately
      // print('Returning photos from cache for album $albumId'); // Optional: for debugging
      return localPhotos;
    }

    // If no data in cache, fetch from network
    // print('Fetching photos from network for album $albumId'); // Optional: for debugging
    try {
      Response<List<Photo>> response = await getIt<ApiService>().getPhotosByAlbumId(albumId);
      if (response.statusCode == 200 && response.body != null) {
        final networkPhotos = response.body!;
        // Store network data in the database
        // The insertPhotos method in DatabaseHelper handles clearing existing photos for this albumId
        await _databaseHelper.insertPhotos(networkPhotos);
        // Return network data
        return networkPhotos;
      } else {
        // Handle non-200 status codes or empty body from network
        throw Exception('Failed to fetch photos from network for album $albumId: ${response.statusCode}');
      }
    } catch (e) {
      // Handle network errors
      print('Network error fetching photos for album $albumId: $e'); // Optional: for debugging
      rethrow; // Rethrow the exception to be handled by the BLoC
    }
  }
} 