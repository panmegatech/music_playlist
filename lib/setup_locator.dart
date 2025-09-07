import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_playlist/features/core/constants/global_constant.dart';
import 'package:music_playlist/features/music/data/datasource/music_remote_data_source.dart';
import 'package:music_playlist/features/music/data/music_config_provider_impl.dart';
import 'package:music_playlist/features/music/data/repository/music_repository_impl.dart';
import 'package:music_playlist/features/music/domain/music_config_provider.dart';
import 'package:music_playlist/features/music/domain/repository/music_repository.dart';
import 'package:music_playlist/features/music/domain/usecases/pause_music_usecase.dart';
import 'package:music_playlist/features/music/domain/usecases/play_music_usecase.dart';
import 'package:music_playlist/features/music/domain/usecases/playlist_usecase.dart';
import 'package:music_playlist/features/music/domain/usecases/song_usecase.dart';
import 'package:music_playlist/features/music/presentation/bloc/player/player_cubit.dart';
import 'package:music_playlist/features/music/presentation/bloc/playlist/playlist_cubit.dart';
import 'package:music_playlist/features/music/presentation/bloc/song/song_cubit.dart';

Future<void> setupLocator() async {
  WidgetsFlutterBinding.ensureInitialized();
  _registerFeatureCore();
  _registerFeatureMusic();
}

void _registerFeatureCore() {
  if (!getIt.isRegistered<Dio>()) {
    getIt.registerLazySingleton<Dio>(() => Dio());
  }
}

void _registerFeatureMusic() {
  if (!getIt.isRegistered<MusicConfigProvider>()) {
    getIt.registerLazySingleton<MusicConfigProvider>(
      () => MusicConfigProviderImpl(),
    );
  }

  if (!getIt.isRegistered<MusicRemoteDataSource>()) {
    getIt.registerLazySingleton<MusicRemoteDataSource>(
      () => MusicRemoteDataSourceImpl(
          configProvider: getIt<MusicConfigProvider>(), dio: getIt<Dio>()),
    );
  }

  if (!getIt.isRegistered<AudioPlayer>()) {
    getIt.registerLazySingleton<AudioPlayer>(
      () => AudioPlayer(),
    );
  }

  if (!getIt.isRegistered<MusicRepository>()) {
    getIt.registerLazySingleton<MusicRepository>(
      () => MusicRepositoryImpl(
          remoteDataSource: getIt<MusicRemoteDataSource>(),
          audioPlayer: getIt<AudioPlayer>()),
    );
  }

  //usecases

  if (!getIt.isRegistered<PlaylistUsecase>()) {
    getIt.registerLazySingleton<PlaylistUsecase>(
      () => PlaylistUsecase(repository: getIt<MusicRepository>()),
    );
  }

  if (!getIt.isRegistered<SongUsecase>()) {
    getIt.registerLazySingleton<SongUsecase>(
      () => SongUsecase(repository: getIt<MusicRepository>()),
    );
  }

  if (!getIt.isRegistered<PlayMusicUsecase>()) {
    getIt.registerLazySingleton<PlayMusicUsecase>(
      () => PlayMusicUsecase(repository: getIt<MusicRepository>()),
    );
  }

  if (!getIt.isRegistered<PauseMusicUsecase>()) {
    getIt.registerLazySingleton<PauseMusicUsecase>(
      () => PauseMusicUsecase(repository: getIt<MusicRepository>()),
    );
  }

  //bloc

  if (!getIt.isRegistered<PlaylistCubit>()) {
    getIt.registerFactory<PlaylistCubit>(
      () => PlaylistCubit(playlistUsecase: getIt<PlaylistUsecase>()),
    );
  }

  if (!getIt.isRegistered<SongCubit>()) {
    getIt.registerFactory<SongCubit>(
      () => SongCubit(songUsecase: getIt<SongUsecase>()),
    );
  }

  if (!getIt.isRegistered<PlayerCubit>()) {
    getIt.registerFactory<PlayerCubit>(
      () => PlayerCubit(
          playMusicUsecase: getIt<PlayMusicUsecase>(),
          pauseMusicUsecase: getIt<PauseMusicUsecase>()),
    );
  }
}
