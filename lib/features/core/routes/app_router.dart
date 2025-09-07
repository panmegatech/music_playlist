import 'package:flutter/material.dart';
import 'package:music_playlist/features/core/routes/route_name.dart';
import 'package:music_playlist/features/music/presentation/pages/playlist_screen.dart';
import 'package:music_playlist/features/music/presentation/pages/playlist_view_screen.dart';
import 'package:music_playlist/features/music/presentation/pages/page_not_found_screen.dart';

class AppRouter {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) {
        switch (settings.name) {
          case RouteName.musicList:
            return PlaylistScreen();
          case RouteName.musicView:
            return PlaylistViewScreen();
          case RouteName.pageNotFound:
          default:
            return PageNotFoundScreen();
        }
      },
    );
  }
}
