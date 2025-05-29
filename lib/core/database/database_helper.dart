import 'package:album/features/albums/domain/entities/album.dart';
import 'package:album/features/albums/domain/entities/photo.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'album_app.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE albums(id INTEGER PRIMARY KEY, userId INTEGER, title TEXT)',
    );
    await db.execute(
      'CREATE TABLE photos(id INTEGER PRIMARY KEY, albumId INTEGER, title TEXT, url TEXT, thumbnailUrl TEXT)',
    );
  }

  Future<void> insertAlbums(List<Album> albums) async {
    final db = await database;
    final batch = db.batch();
    // Clear existing albums before inserting new ones to avoid duplicates
    batch.delete('albums');
    for (final album in albums) {
      batch.insert('albums', album.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
    }
    await batch.commit(noResult: true);
  }

  Future<void> insertPhotos(List<Photo> photos) async {
    final db = await database;
    final batch = db.batch();
    // Clear existing photos for the relevant albums before inserting new ones
    // This is a simplified approach; a more robust solution might delete only photos for the albums being updated.
    if (photos.isNotEmpty) {
       // Get distinct album IDs from the photos list
       final albumIds = photos.map((photo) => photo.albumId).toSet().toList();
       for (final albumId in albumIds) {
         batch.delete('photos', where: 'albumId = ?', whereArgs: [albumId]);
       }
    }
    for (final photo in photos) {
      batch.insert('photos', photo.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
    }
    await batch.commit(noResult: true);
  }


  Future<List<Album>> getAlbums() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('albums');
    return List.generate(maps.length, (i) {
      return Album.fromJson(maps[i]);
    });
  }

  Future<List<Photo>> getPhotosByAlbumId(int albumId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'photos',
      where: 'albumId = ?',
      whereArgs: [albumId],
    );
    return List.generate(maps.length, (i) {
      return Photo.fromJson(maps[i]);
    });
  }

   // Method to get all photos
  Future<List<Photo>> getAllPhotos() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('photos');
    return List.generate(maps.length, (i) {
      return Photo.fromJson(maps[i]);
    });
  }

} 