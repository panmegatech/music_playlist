import 'package:dart_either/dart_either.dart';
import 'package:music_playlist/features/core/error/failure.dart';
import 'package:music_playlist/features/music/domain/entities/playlist_entity.dart';
import 'package:music_playlist/features/music/domain/repository/music_repository.dart';

class PlaylistUsecase {
  final MusicRepository repository;
  const PlaylistUsecase({required this.repository});

  Future<Either<Failure, PlaylistEntity>> execute() async {
    return await repository.playlist();
  }
}
