import 'package:music_playlist/features/music/domain/repository/music_repository.dart';
import 'package:music_playlist/features/music/domain/usecases/stream_usecase.dart';

class GetPlayingStreamUsecase implements StreamUseCase<bool> {
  final MusicRepository repository;

  GetPlayingStreamUsecase({required this.repository});

  @override
  Stream<bool>? execute() {
    return repository.playingStream;
  }
}
