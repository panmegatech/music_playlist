import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_playlist/features/core/utils/log_color.dart';
import 'package:music_playlist/features/music/domain/entities/song_entity.dart';
import 'package:music_playlist/features/music/domain/usecases/song_usecase.dart';

part 'song_state.dart';

class SongCubit extends Cubit<SongState> {
  final SongUsecase _songUsecase;
  SongCubit({required SongUsecase songUsecase})
      : _songUsecase = songUsecase,
        super(SongInitialState());
  Future<void> getSong({String? playlistId, String? songId}) async {
    emit(SongLoadingState());
    final callSongUsecase = await _songUsecase.execute();

    return callSongUsecase.fold(
      ifLeft: (value) {
        logError("callSongUsecase (left) : $value");
        return emit(SongErrorState());
      },
      ifRight: (value) {
        return emit(SongHasDataState(value));
      },
    );
  }
}
