import 'package:flutter/material.dart';
import 'package:music_playlist/main_app.dart';
import 'package:music_playlist/setup_locator.dart';

Future<void> main() async {
  //* setup Locator
  await setupLocator();
  runApp(const MainApp());
}
