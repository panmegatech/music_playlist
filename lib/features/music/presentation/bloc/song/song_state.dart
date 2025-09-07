part of 'song_cubit.dart';

sealed class SongState extends Equatable {
  const SongState();

  @override
  List<Object?> get props => [];
}

final class SongInitialState extends SongState {}

final class SongLoadingState extends SongState {}

final class SongErrorState extends SongState {}

final class SongHasDataState extends SongState {
  final SongEntity songEntity;

  const SongHasDataState(this.songEntity);

  @override
  List<Object?> get props => [
        songEntity,
      ];
}
