import 'package:equatable/equatable.dart';
import 'package:music_playlist/features/music/domain/entities/song_model_songs_item_entity.dart';

class SongEntity extends Equatable {
  final List<SongModelSongsItemEntity>? songs;

  const SongEntity({
    this.songs,
  });

  @override
  List<Object?> get props => [songs];
}
