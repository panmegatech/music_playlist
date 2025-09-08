import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_playlist/features/core/utils/log_color.dart';
import 'package:music_playlist/features/music/domain/entities/song_model_songs_item_entity.dart';
import 'package:music_playlist/features/music/domain/usecases/pause_music_usecase.dart';
import 'package:music_playlist/features/music/domain/usecases/play_music_usecase.dart';

part 'player_state.dart';

class PlayerCubit extends Cubit<PlayerState> {
  final PlayMusicUsecase _playMusicUsecase;
  final PauseMusicUsecase _pauseMusicUsecase;
  PlayerCubit({
    required PlayMusicUsecase playMusicUsecase,
    required PauseMusicUsecase pauseMusicUsecase,
  })  : _playMusicUsecase = playMusicUsecase,
        _pauseMusicUsecase = pauseMusicUsecase,
        super(PlayerState(
          isLoading: false,
          isPlaying: false,
        ));
  Future<void> playMusic(
      {SongModelSongsItemEntity? songModelSongsItemEntity}) async {
    final String? url = songModelSongsItemEntity?.trackUrl;
    emit(state.copyWith(isLoading: true));
    final isPlayMusic = await _playMusicUsecase.execute(url);

    logInfo("isPlayMusic >> $isPlayMusic");

    return emit(state.copyWith(
      isLoading: false,
      isPlaying: isPlayMusic,
      songModelSongsItemEntity: songModelSongsItemEntity,
    ));
  }

  Future<void> pause() async {
    emit(state.copyWith(isLoading: true));

    await _pauseMusicUsecase.execute();

    return emit(state.copyWith(isLoading: false, isPlaying: false));
  }
}
