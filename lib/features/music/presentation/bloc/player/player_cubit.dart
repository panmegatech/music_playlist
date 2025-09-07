import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_playlist/features/music/domain/usecases/play_music_usecase.dart';

part 'player_state.dart';

class PlayerCubit extends Cubit<PlayerState> {
  final PlayMusicUsecase _playMusicUsecase;
  PlayerCubit({required PlayMusicUsecase playMusicUsecase})
      : _playMusicUsecase = playMusicUsecase,
        super(PlayerInitialState());
  Future<void> playMusic({required String url}) async {
    emit(PlayerLoadingState());
    final isPlayMusic = await _playMusicUsecase.execute(url);

    return emit(isPlayMusic ? PlayerHasDataState() : PlayerErrorState());
  }
}
