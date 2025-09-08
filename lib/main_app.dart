import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_playlist/features/core/constants/global_constant.dart';
import 'package:music_playlist/features/core/routes/app_router.dart';
import 'package:music_playlist/features/music/domain/usecases/get_duration_stream_usecase.dart';
import 'package:music_playlist/features/music/domain/usecases/get_playing_stream_usecase.dart';
import 'package:music_playlist/features/music/domain/usecases/get_position_stream_usecase.dart';
import 'package:music_playlist/features/music/presentation/bloc/audio/audio_cubit.dart';
import 'package:music_playlist/features/music/presentation/bloc/player/player_cubit.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => PlayerCubit(
            playMusicUsecase: getIt(),
            pauseMusicUsecase: getIt(),
          ),
        ),
        BlocProvider(
          create: (_) => AudioCubit(
            getPlayingStreamUsecase: getIt<GetPlayingStreamUsecase>(),
            getPositionStreamUsecase: getIt<GetPositionStreamUsecase>(),
            getDurationStreamUsecase: getIt<GetDurationStreamUsecase>(),
          ),
        ),
      ],
      child: MaterialApp(
        onGenerateRoute: AppRouter.generateRoute,
        theme: ThemeData(
          fontFamily: 'Prompt',
          textTheme: const TextTheme(
            bodyLarge: TextStyle(fontSize: 18, color: Colors.black),
            bodyMedium: TextStyle(fontSize: 16, color: Colors.white),
          ),
          colorScheme: ColorScheme(
            brightness: Brightness.light,
            primary: Color.fromARGB(255, 35, 49, 63),
            onPrimary: Colors.black,
            secondary: Color.fromARGB(255, 51, 73, 98),
            onSecondary: Colors.white,
            error: Color(0xFFB00020),
            onError: Color(0xFFB00020),
            surface: Colors.white,
            onSurface: Colors.black,
          ),
        ),
        themeMode: ThemeMode.light,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
