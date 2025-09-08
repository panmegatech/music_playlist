import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_playlist/features/core/routes/route_name.dart';
import 'package:music_playlist/features/core/utils/log_color.dart';
import 'package:music_playlist/features/music/presentation/bloc/playlist/playlist_cubit.dart';
import 'package:music_playlist/features/music/presentation/widgets/error_display.dart';
import 'package:music_playlist/features/music/presentation/widgets/progress_slider.dart';

class PlaylistScreen extends StatefulWidget {
  const PlaylistScreen({super.key});

  @override
  State<PlaylistScreen> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  @override
  void initState() {
    //* call API by BLoC
    context.read<PlaylistCubit>().getPlayList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //? fake data for example
    // const allPlaylist = [
    //   {
    //     "id": 1,
    //     "title": "Indie, Pop, Alternative, New Wave 273",
    //     "description":
    //         "Collection of indie, pop, alternative, and new wave tracks.",
    //     "image_url": "https://i.ytimg.com/vi/GRdWGLMw8II/default.jpg"
    //   },
    //   {
    //     "id": 2,
    //     "title": "Alice <0>",
    //     "description": "Experimental and dreamy music selection.",
    //     "image_url": "https://i.ytimg.com/vi/5-I1lT6Jbdo/default.jpg"
    //   },
    //   {
    //     "id": 3,
    //     "title": "Mesmerizing Tracks",
    //     "description": "A playlist of songs that feel dreamy and floating.",
    //     "image_url": "https://i.ytimg.com/vi/7kNzDk2CPHI/default.jpg"
    //   },
    //   {
    //     "id": 4,
    //     "title": "Electro, Synthpop",
    //     "description": "Electronic and synthpop tunes.",
    //     "image_url": "https://i.ytimg.com/vi/AoKrfZSTUXo/default.jpg"
    //   },
    //   {
    //     "id": 5,
    //     "title": "Ethereal, Heavenly Voices",
    //     "description": "Tracks with ethereal and heavenly vocals.",
    //     "image_url": "https://i.ytimg.com/vi/AQs4ab99THE/default.jpg"
    //   },
    //   {
    //     "id": 6,
    //     "title": "Indie, Pop, Alternative, New Wave 272",
    //     "description": "Another indie pop collection continuing from 273.",
    //     "image_url": "https://i.ytimg.com/vi/roIaUb1TWYw/default.jpg"
    //   },
    //   {
    //     "id": 7,
    //     "title": "Female Vocalists",
    //     "description": "Songs featuring powerful female voices.",
    //     "image_url": "https://i.ytimg.com/vi/JOVQ4vAmM7Y/default.jpg"
    //   },
    //   {
    //     "id": 8,
    //     "title": "Punk",
    //     "description": "Raw and energetic punk tracks.",
    //     "image_url": "https://i.ytimg.com/vi/CEQsFA-CX3c/default.jpg"
    //   },
    //   {
    //     "id": 9,
    //     "title": "Rock it all!",
    //     "description": "Legendary rock tracks and popular hits.",
    //     "image_url": "https://i.ytimg.com/vi/XM0TUtqddpg/default.jpg"
    //   },
    //   {
    //     "id": 10,
    //     "title": "Darkwave, Goth, Post-Punk",
    //     "description": "Darkwave, goth, and post-punk vibes.",
    //     "image_url": "https://i.ytimg.com/vi/_AX6cTDKRjw/default.jpg"
    //   },
    //   {
    //     "id": 11,
    //     "title": "Phili192 2025",
    //     "description": "Curated tracks from Phil72 Le Mans.",
    //     "image_url": "https://i.ytimg.com/vi/ZjqLmCpPyKM/default.jpg"
    //   }
    // ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Playlist",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<PlaylistCubit, PlaylistState>(
          builder: (context, playlistState) {
            if (playlistState is PlaylistHasDataState) {
              final allPlaylist = playlistState.playlistEntity.playlist;
              return Column(
                children: [
                  ...List.generate(
                    allPlaylist?.length ?? 0,
                    (index) {
                      return ListTile(
                        onTap: () {
                          logWarning("playlist pressed");
                          //* playlist pressed goTo Playlist

                          Navigator.pushNamed(context, RouteName.musicView,
                              arguments: {
                                "playlist_id": allPlaylist?[index].id
                              });
                        },
                        leading: SizedBox(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: Image.network(
                                allPlaylist?[index].imageUrl?.toString() ?? '',
                                fit: BoxFit.cover,
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child;
                                  }
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value:
                                          loadingProgress.expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                    ),
                                  );
                                },
                                errorBuilder: (context, error, stackTrace) {
                                  return SizedBox(
                                    width: 40,
                                    height: 40,
                                    // color: colorScheme.secondary,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                            flex: 3,
                                            child: Icon(
                                              Icons.image,
                                              size: 36,
                                            )),
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            '(Image not found)',
                                            style: TextStyle(fontSize: 5),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        title: Text(
                          '${allPlaylist?[index].title}',
                          maxLines: 1,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis),
                        ),
                        subtitle: Text(
                          '${allPlaylist?[index].description}',
                          maxLines: 2,
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            overflow: TextOverflow.ellipsis,
                            color: Colors.black54,
                            fontSize: 14,
                          ),
                        ),
                        trailing: IconButton.filled(
                            style: ButtonStyle(
                              side: WidgetStatePropertyAll(
                                  BorderSide(color: Colors.grey)),
                              backgroundColor:
                                  WidgetStatePropertyAll(Colors.white),
                            ),
                            onPressed: () {
                              logWarning("play icon pressed");

                              Navigator.pushNamed(context, RouteName.musicView,
                                  arguments: {
                                    "playlist_id": allPlaylist?[index].id,
                                  });
                            },
                            icon: Icon(
                              Icons.play_arrow,
                              color: Colors.black54,
                            )),
                        contentPadding: EdgeInsets.all(8),
                      );
                    },
                  ),
                ],
              );
            }

            if (playlistState is PlaylistErrorState) {
              logError("error >>>");
              return Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: ErrorDisplay(
                        onRetry: () {
                          //* retry

                          context.read<PlaylistCubit>().getPlayList();
                        },
                      ),
                    ),
                  ],
                ),
              );
            }
            return Padding(
              padding: const EdgeInsets.all(18.0),
              child: Center(
                child: LinearProgressIndicator(
                  color: Colors.grey,
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(8),
        height: 70,
        child: ProgressSlider(
          position: Duration(seconds: 65),
          duration: Duration(seconds: 125),
          onChanged: (newPosition) {
            //todo
            // context.read<AudioBloc>().add(SeekAudioEvent(newPosition));
          },
        ),
      ),
    );
  }
}
