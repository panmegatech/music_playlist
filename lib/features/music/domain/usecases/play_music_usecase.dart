import 'package:music_playlist/features/music/domain/repository/music_repository.dart';

class PlayMusicUsecase {
  final MusicRepository repository;
  const PlayMusicUsecase({required this.repository});

  Future<bool> execute(String? url) async {
    return await repository.play(url);
  }
}
