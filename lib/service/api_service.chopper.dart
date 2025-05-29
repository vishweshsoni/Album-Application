// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$ApiService extends ApiService {
  _$ApiService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = ApiService;

  @override
  Future<Response<List<Album>>> getAlbums() {
    final Uri $url = Uri.parse('/albums');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<Album>, Album>($request);
  }

  @override
  Future<Response<List<Photo>>> getPhotosByAlbumId(int albumId) {
    final Uri $url = Uri.parse('/photos');
    final Map<String, dynamic> $params = <String, dynamic>{'albumId': albumId};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<List<Photo>, Photo>($request);
  }
}
