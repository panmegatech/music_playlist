import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_playlist/features/core/constants/global_constant.dart';
import 'package:music_playlist/features/core/routes/route_name.dart';
import 'package:music_playlist/features/music/presentation/bloc/playlist/playlist_cubit.dart';
import 'package:music_playlist/features/music/presentation/pages/playlist_screen.dart';
import 'package:music_playlist/features/music/presentation/pages/playlist_view_screen.dart';
import 'package:music_playlist/features/music/presentation/pages/page_not_found_screen.dart';

class AppRouter {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) {
        switch (settings.name) {
          case RouteName.musicList:
            return BlocProvider(
              create: (context) => PlaylistCubit(playlistUsecase: getIt()),
              child: PlaylistScreen(),
            );
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
