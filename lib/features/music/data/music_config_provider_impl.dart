import 'package:music_playlist/features/core/constants/config.dart';
import 'package:music_playlist/features/music/domain/music_config_provider.dart';

class MusicConfigProviderImpl implements MusicConfigProvider {
  static const playlistEndpoint = "/playlists";
  static const songsEndpoint = "/songs";

  @override
  int get requestTimeout => Config.requestTimeout;

  @override
  String getPlaylistUrl() {
    return Config.apiUrl + playlistEndpoint;
  }

  @override
  String getSongsUrl({String? playlistId, String? songId}) {
    var endpoint = Config.apiUrl + songsEndpoint;
    if (playlistId != null) {
      endpoint = "$endpoint?playlist_id=$playlistId";
    } else if (songId != null) {
      endpoint = "$endpoint?id=$songId";
    }

    return endpoint;
  }
}
