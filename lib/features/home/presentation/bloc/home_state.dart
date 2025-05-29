part of 'home_bloc.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState.initial() = _Initial;
  const factory HomeState.loading() = _Loading;
  const factory HomeState.loaded(
    List<Album> albums, {
    @Default({}) Map<int, List<Photo>> photos,
  }) = _Loaded;
  const factory HomeState.error(String message) = _Error;
}
