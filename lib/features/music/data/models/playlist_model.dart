import 'package:music_playlist/features/music/data/models/playlist_model_playlist_item_model.dart';
import 'package:music_playlist/features/music/domain/entities/playlist_entity.dart';

class PlaylistModel {
  final List<PlaylistModelPlaylistItemModel>? playlist;

  const PlaylistModel({
    this.playlist,
  });

  factory PlaylistModel.fromJson(Map<String, dynamic> json) {
    return PlaylistModel(
      playlist: (json['playlist'] as List)
          .map((e) => PlaylistModelPlaylistItemModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'playlist': playlist,
      };

  PlaylistEntity toEntity() {
    return PlaylistEntity(
      playlist: playlist == null
          ? null
          : List.from(playlist!.map((e) => e.toEntity())),
    );
  }
}
