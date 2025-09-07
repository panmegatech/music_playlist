import 'package:music_playlist/features/music/data/models/song_model_songs_item_model.dart';
import 'package:music_playlist/features/music/domain/entities/song_entity.dart';

class SongModel {
  final List<SongModelSongsItemModel>? songs;

  const SongModel({
    this.songs,
  });

  factory SongModel.fromJson(Map<String, dynamic> json) {
    return SongModel(
      songs: (json['songs'] as List)
          .map((e) => SongModelSongsItemModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'songs': songs,
      };

  SongEntity toEntity() {
    return SongEntity(
      songs: songs == null ? null : List.from(songs!.map((e) => e.toEntity())),
    );
  }
}
