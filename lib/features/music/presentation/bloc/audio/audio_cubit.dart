import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_playlist/features/music/domain/usecases/get_duration_stream_usecase.dart';
import 'package:music_playlist/features/music/domain/usecases/get_playing_stream_usecase.dart';
import 'package:music_playlist/features/music/domain/usecases/get_position_stream_usecase.dart';

part 'audio_state.dart';

class AudioCubit extends Cubit<AudioState> {
  final GetPlayingStreamUsecase _getPlayingStreamUsecase;
  final GetPositionStreamUsecase _getPositionStreamUsecase;
  final GetDurationStreamUsecase _getDurationStreamUsecase;

  StreamSubscription? _playingSub;
  StreamSubscription? _positionSub;
  StreamSubscription? _durationSub;

  AudioCubit({
    required GetPlayingStreamUsecase getPlayingStreamUsecase,
    required GetPositionStreamUsecase getPositionStreamUsecase,
    required GetDurationStreamUsecase getDurationStreamUsecase,
  })  : _getPlayingStreamUsecase = getPlayingStreamUsecase,
        _getPositionStreamUsecase = getPositionStreamUsecase,
        _getDurationStreamUsecase = getDurationStreamUsecase,
        super(AudioState.initial()) {
    _playingSub = _getPlayingStreamUsecase.execute()?.listen((isPlaying) {
      emit(state.copyWith(isPlaying: isPlaying));
    });

    _positionSub = _getPositionStreamUsecase.execute()?.listen((pos) {
      emit(state.copyWith(position: pos));
    });

    _durationSub = _getDurationStreamUsecase.execute()?.listen((dur) {
      emit(state.copyWith(duration: dur));
    });
  }

  @override
  Future<void> close() {
    _playingSub?.cancel();
    _positionSub?.cancel();
    _durationSub?.cancel();
    return super.close();
  }
}
