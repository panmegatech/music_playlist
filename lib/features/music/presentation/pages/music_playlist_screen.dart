import 'package:flutter/material.dart';

class MusicPlaylistScreen extends StatelessWidget {
  const MusicPlaylistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const allPlaylist = [];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Playlist",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      body: Center(
        child: Text('music playlist screen'),
      ),
    );
  }
}
