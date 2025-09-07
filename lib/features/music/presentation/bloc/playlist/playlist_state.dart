part of 'playlist_cubit.dart';

sealed class PlaylistState extends Equatable {
  const PlaylistState();

  @override
  List<Object?> get props => [];
}

final class PlaylistInitialState extends PlaylistState {}

final class PlaylistLoadingState extends PlaylistState {}

final class PlaylistErrorState extends PlaylistState {}

final class PlaylistHasDataState extends PlaylistState {
  final PlaylistEntity playlistEntity;

  const PlaylistHasDataState(this.playlistEntity);

  @override
  List<Object?> get props => [
        playlistEntity,
      ];
}
