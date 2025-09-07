import 'package:music_playlist/features/music/domain/entities/playlist_model_playlist_item_entity.dart';

class PlaylistModelPlaylistItemModel {
  final int? id;
  final String? title;
  final String? description;
  final String? imageUrl;

  const PlaylistModelPlaylistItemModel({
    this.id,
    this.title,
    this.description,
    this.imageUrl,
  });

  factory PlaylistModelPlaylistItemModel.fromJson(Map<String, dynamic> json) {
    return PlaylistModelPlaylistItemModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      imageUrl: json['image_url'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'image_url': imageUrl,
      };

  PlaylistModelPlaylistItemEntity toEntity() {
    return PlaylistModelPlaylistItemEntity(
      id: id,
      title: title,
      description: description,
      imageUrl: imageUrl,
    );
  }
}
