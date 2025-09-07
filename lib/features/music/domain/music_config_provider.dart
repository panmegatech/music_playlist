abstract class MusicConfigProvider {
  String getPlaylistUrl();
  String getSongsUrl({String? playlistId, String? songId});
  int get requestTimeout;
}
