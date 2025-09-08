part of 'player_cubit.dart';

class PlayerState extends Equatable {
  final bool isLoading;
  final bool isPlaying;
  final SongModelSongsItemEntity? songModelSongsItemEntity;

  const PlayerState(
      {required this.isLoading,
      required this.isPlaying,
      this.songModelSongsItemEntity});

  @override
  List<Object?> get props => [
        isLoading,
        isPlaying,
        songModelSongsItemEntity,
        songModelSongsItemEntity,
      ];

  PlayerState copyWith(
          {bool? isLoading,
          bool? isPlaying,
          SongModelSongsItemEntity? songModelSongsItemEntity}) =>
      PlayerState(
        isLoading: isLoading ?? this.isLoading,
        isPlaying: isPlaying ?? this.isPlaying,
        songModelSongsItemEntity:
            songModelSongsItemEntity ?? this.songModelSongsItemEntity,
      );
}
