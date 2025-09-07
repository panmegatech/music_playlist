import 'package:music_playlist/features/music/domain/repository/music_repository.dart';

class PauseMusicUsecase {
  final MusicRepository repository;
  const PauseMusicUsecase({required this.repository});

  Future<void> execute() async {
    return await repository.pause();
  }
}
