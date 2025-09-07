import 'package:dart_either/dart_either.dart';
import 'package:just_audio/just_audio.dart';
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
  final AudioPlayer? audioPlayer;

  MusicRepositoryImpl({
    required this.remoteDataSource,
    required this.audioPlayer,
  });
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
      final responseModel =
          await remoteDataSource.song(playlistId: playlistId, songId: songId);

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
  Future<void> pause() async {
    await audioPlayer?.pause();
  }

  @override
  Future<bool> play(String url) async {
    try {
      logDebug("play (url): $url");
      await stop();
      // await audioPlayer?.dispose();
      await audioPlayer?.setUrl(url);
      audioPlayer?.play();
      return true;
    } catch (e) {
      logError("repoImpl error: $e");
      return false;
    }
  }

  @override
  Future<void> stop() async {
    await audioPlayer?.stop();
  }
}
