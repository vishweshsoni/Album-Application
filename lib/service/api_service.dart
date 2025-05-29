import 'package:album/core/converters/json_to_type_converter.dart';
import 'package:album/features/albums/domain/entities/album.dart';
import 'package:album/features/albums/domain/entities/photo.dart';
import 'package:album/service/api_endpoints.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

part 'api_service.chopper.dart';

@ChopperApi()
abstract class ApiService extends ChopperService {
  static ApiService create() {
    final client = ChopperClient(
      baseUrl: Uri.parse(ApiEndpoints.baseUrl),
      services: [
        _$ApiService(),
      ],
      converter: jsonToTypeConverter,
      interceptors: [
        (Request request) async {
          final headers = {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          };
          final req = request.copyWith(headers: headers);
          debugPrint('\n=== REQUEST ===');
          debugPrint('${req.method} ${req.uri}');
          debugPrint('Headers: ${req.headers}');
          return req;
        },
        (Response response) async {
          debugPrint('\n=== RESPONSE ===');
          debugPrint('Status: ${response.statusCode}');
          debugPrint('Headers: ${response.headers}');
          debugPrint('Body: ${response.body}');
          if (response.statusCode >= 400) {
            debugPrint('Error: ${response.error}');
          }
          return response;
        },
      ],
    );
    return _$ApiService(client);
  }

  @Get(path: ApiEndpoints.getAlbums)
  Future<Response<List<Album>>> getAlbums();

  @Get(path: ApiEndpoints.getPhotos)
  Future<Response<List<Photo>>> getPhotosByAlbumId(
    @Query('albumId') int albumId,
  );
}
