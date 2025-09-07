import 'package:equatable/equatable.dart';
import 'package:music_playlist/features/music/domain/entities/playlist_model_playlist_item_entity.dart';

class PlaylistEntity extends Equatable {
  final List<PlaylistModelPlaylistItemEntity>? playlist;

  const PlaylistEntity({
    this.playlist,
  });

  @override
  List<Object?> get props => [playlist];
}
