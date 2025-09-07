import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:music_playlist/features/core/utils/log_color.dart';
import 'package:music_playlist/features/music/domain/entities/playlist_entity.dart';
import 'package:music_playlist/features/music/domain/usecases/playlist_usecase.dart';

part 'playlist_state.dart';

class PlaylistCubit extends Cubit<PlaylistState> {
  final PlaylistUsecase _playlistUsecase;
  PlaylistCubit({required PlaylistUsecase playlistUsecase})
      : _playlistUsecase = playlistUsecase,
        super(PlaylistInitialState());
  Future<void> getPlayList() async {
    emit(PlaylistLoadingState());
    final callPlaylistUsecase = await _playlistUsecase.execute();

    return callPlaylistUsecase.fold(
      ifLeft: (value) {
        logError("callPlaylistUsecase (left) : $value");
        return emit(PlaylistErrorState());
      },
      ifRight: (value) {
        return emit(PlaylistHasDataState(value));
      },
    );
  }
}
