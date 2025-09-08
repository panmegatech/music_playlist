import 'package:music_playlist/features/music/domain/repository/music_repository.dart';
import 'package:music_playlist/features/music/domain/usecases/stream_usecase.dart';

class GetPositionStreamUsecase implements StreamUseCase<Duration> {
  final MusicRepository repository;

  GetPositionStreamUsecase({required this.repository});

  @override
  Stream<Duration>? execute() {
    return repository.positionStream;
  }
}
