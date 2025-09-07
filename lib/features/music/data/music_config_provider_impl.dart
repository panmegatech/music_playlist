import 'package:music_playlist/features/core/constants/config.dart';
import 'package:music_playlist/features/music/domain/music_config_provider.dart';

class MusicConfigProviderImpl implements MusicConfigProvider {
  static const playlistEndpoint = "/playlists";
  static const songsEndpoint = "/songs";
  static const songsByPlaylistIdEndpoint = "/songs?playlist_id=";
  static const songByIdEndpoint = "/songs?id=";

  @override
  String getPlaylistUrl() {
    return Config.apiUrl + playlistEndpoint;
  }

  @override
  int get requestTimeout => Config.requestTimeout;
}
