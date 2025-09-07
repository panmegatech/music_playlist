import 'package:music_playlist/features/music/domain/entities/song_model_songs_item_entity.dart';

class SongModelSongsItemModel {
  final int? id;
  final int? playlistId;
  final String? title;
  final String? artist;
  final String? duration;
  final String? imageUrl;
  final String? trackUrl;

  const SongModelSongsItemModel({
    this.id,
    this.playlistId,
    this.title,
    this.artist,
    this.duration,
    this.imageUrl,
    this.trackUrl,
  });

  factory SongModelSongsItemModel.fromJson(Map<String, dynamic> json) {
    return SongModelSongsItemModel(
      id: json['id'],
      playlistId: json['playlist_id'],
      title: json['title'],
      artist: json['artist'],
      duration: json['duration'],
      imageUrl: json['image_url'],
      trackUrl: json['track_url'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'playlist_id': playlistId,
        'title': title,
        'artist': artist,
        'duration': duration,
        'image_url': imageUrl,
        'track_url': trackUrl,
      };

  SongModelSongsItemEntity toEntity() {
    return SongModelSongsItemEntity(
      id: id,
      playlistId: playlistId,
      title: title,
      artist: artist,
      duration: duration,
      imageUrl: imageUrl,
      trackUrl: trackUrl,
    );
  }
}
