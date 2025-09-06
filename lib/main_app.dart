import 'package:flutter/material.dart';
import 'package:music_playlist/features/core/routes/app_router.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
