import 'package:equatable/equatable.dart';

class SongModelSongsItemEntity extends Equatable {

  final int? id;
  final int? playlistId;
  final String? title;
  final String? artist;
  final String? duration;
  final String? imageUrl;
  final String? trackUrl;

  const SongModelSongsItemEntity({
    this.id,
    this.playlistId,
    this.title,
    this.artist,
    this.duration,
    this.imageUrl,
    this.trackUrl,
  });

  @override
  List<Object?> get props => [id, playlistId, title, artist, duration, imageUrl, trackUrl];
}