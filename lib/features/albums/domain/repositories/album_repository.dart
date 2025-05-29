import 'package:album/features/albums/domain/entities/album.dart';

abstract class AlbumRepository {
  Future<List<Album>> getAll();
}
