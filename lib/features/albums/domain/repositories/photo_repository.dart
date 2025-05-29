import 'package:album/features/albums/domain/entities/photo.dart';

abstract class PhotoRepository {
  Future<List<Photo>> getPhotosByAlbumId(int albumId);
} 