import 'package:dart_either/dart_either.dart';
import 'package:music_playlist/features/core/error/failure.dart';
import 'package:music_playlist/features/music/domain/entities/song_entity.dart';
import 'package:music_playlist/features/music/domain/repository/music_repository.dart';

class SongUsecase {
  final MusicRepository repository;
  const SongUsecase({required this.repository});

  Future<Either<Failure, SongEntity>> execute(
      {String? playlistId, String? songId}) async {
    return await repository.song();
  }
}
