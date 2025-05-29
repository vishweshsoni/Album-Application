class ApiEndpoints {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';

  // Album endpoints
  static const String getAlbums = '/albums';
  static const String getPhotos = '/photos';
  static const String getPhotosByAlbumId = '/albums/{id}/photos';
}