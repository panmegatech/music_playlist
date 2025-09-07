import 'package:dart_either/dart_either.dart';
import 'package:music_playlist/features/core/error/failure.dart';
import 'package:music_playlist/features/music/domain/entities/playlist_entity.dart';

abstract class MusicRepository {
  Future<Either<Failure, PlaylistEntity>> playlist();
}
