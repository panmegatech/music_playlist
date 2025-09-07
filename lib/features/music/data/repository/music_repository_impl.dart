import 'package:dart_either/dart_either.dart';
import 'package:music_playlist/features/core/error/exception.dart';
import 'package:music_playlist/features/core/error/failure.dart';
import 'package:music_playlist/features/core/utils/handle_catch_failure.dart';
import 'package:music_playlist/features/core/utils/log_color.dart';
import 'package:music_playlist/features/music/data/datasource/music_remote_data_source.dart';
import 'package:music_playlist/features/music/domain/entities/playlist_entity.dart';
import 'package:music_playlist/features/music/domain/entities/song_entity.dart';
import 'package:music_playlist/features/music/domain/repository/music_repository.dart';

class MusicRepositoryImpl implements MusicRepository {
  final MusicRemoteDataSource remoteDataSource;

  MusicRepositoryImpl({required this.remoteDataSource});
  @override
  Future<Either<Failure, PlaylistEntity>> playlist() async {
    try {
      final responseModel = await remoteDataSource.playlist();

      final responseEntity = responseModel.toEntity();

      return Right(responseEntity);
    } on UnauthorizedException {
      logError("fail UnauthorizedException");
      return Left(InvalidCredentialsFailure());
    } catch (error) {
      logError("repoImpl error: $error");
      return Left(handleCatchFailure(error));
    }
  }

  @override
  Future<Either<Failure, SongEntity>> song(
      {String? playlistId, String? songId}) async {
    try {
      final responseModel = await remoteDataSource.song();

      final responseEntity = responseModel.toEntity();

      return Right(responseEntity);
    } on UnauthorizedException {
      logError("fail UnauthorizedException");
      return Left(InvalidCredentialsFailure());
    } catch (error) {
      logError("repoImpl error: $error");
      return Left(handleCatchFailure(error));
    }
  }
}
