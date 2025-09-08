import 'package:dart_either/dart_either.dart';
import 'package:music_playlist/features/core/error/failure.dart';
import 'package:music_playlist/features/music/domain/entities/playlist_entity.dart';
import 'package:music_playlist/features/music/domain/entities/song_entity.dart';

abstract class MusicRepository {
  Future<Either<Failure, PlaylistEntity>> playlist();
  Future<Either<Failure, SongEntity>> song({
    String? playlistId,
    String? songId,
  });
  Future<bool> play(String? url);
  Future<void> pause();
  Future<void> stop();

  Stream<bool>? get playingStream;
  Stream<Duration?>? get durationStream;
  Stream<Duration>? get positionStream;
}
