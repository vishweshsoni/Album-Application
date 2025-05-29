part of 'home_bloc.dart';

@freezed
class HomeEvent with _$HomeEvent {
  const factory HomeEvent.loadAlbums() = _LoadAlbums;
  const factory HomeEvent.loadPhotos(int albumId) = _LoadPhotos;
}