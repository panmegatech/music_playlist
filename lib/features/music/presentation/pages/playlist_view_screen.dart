import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_playlist/features/core/utils/log_color.dart';
import 'package:music_playlist/features/music/domain/entities/song_model_songs_item_entity.dart';
import 'package:music_playlist/features/music/presentation/bloc/player/player_cubit.dart';
import 'package:music_playlist/features/music/presentation/bloc/song/song_cubit.dart';

class PlaylistViewScreen extends StatefulWidget {
  final String? playlistId;
  final String? songId;
  const PlaylistViewScreen({super.key, this.playlistId, this.songId});

  @override
  State<PlaylistViewScreen> createState() => _PlaylistViewScreenState();
}

class _PlaylistViewScreenState extends State<PlaylistViewScreen> {
  Random random = Random();
  //? fake songs by playlist id
  // static const allTrackByPlaylistId = [
  //   {
  //     "id": 101,
  //     "playlist_id": 1,
  //     "title": "Falling Through",
  //     "artist": "LUCKY",
  //     "duration": "3:23",
  //     "image_url": "https://i.ytimg.com/vi/GRdWGLMw8II/default.jpg",
  //     "track_url": "https://youtube.com/watch?v=GRdWGLMw8II"
  //   },
  //   {
  //     "id": 102,
  //     "playlist_id": 1,
  //     "title": "I’m Not Gonna Make That Jump For You",
  //     "artist": "Zenxith",
  //     "duration": "2:51",
  //     "image_url": "https://i.ytimg.com/vi/8mPKt6xMVYw/default.jpg",
  //     "track_url": "https://youtube.com/watch?v=8mPKt6xMVYw"
  //   },
  //   {
  //     "id": 103,
  //     "playlist_id": 1,
  //     "title": "I Ruined You",
  //     "artist": "Keuning",
  //     "duration": "3:47",
  //     "image_url": "https://i.ytimg.com/vi/IHApGhd3PSY/default.jpg",
  //     "track_url": "https://youtube.com/watch?v=IHApGhd3PSY"
  //   },
  //   {
  //     "id": 104,
  //     "playlist_id": 1,
  //     "title": "Blood Right Down",
  //     "artist": "Shadowgraphs",
  //     "duration": "4:02",
  //     "image_url": "https://i.ytimg.com/vi/vtfbdYB4Pyo/default.jpg",
  //     "track_url": "https://youtube.com/watch?v=vtfbdYB4Pyo"
  //   },
  //   {
  //     "id": 105,
  //     "playlist_id": 1,
  //     "title": "Pop Song",
  //     "artist": "Red Sleeping Beauty",
  //     "duration": "3:15",
  //     "image_url": "https://i.ytimg.com/vi/4pZ0j8b8R78/default.jpg",
  //     "track_url": "https://youtube.com/watch?v=4pZ0j8b8R78"
  //   },
  //   {
  //     "id": 106,
  //     "playlist_id": 1,
  //     "title": "Patterns",
  //     "artist": "adults",
  //     "duration": "2:59",
  //     "image_url": "https://i.ytimg.com/vi/k2MIY338NTE/default.jpg",
  //     "track_url": "https://youtube.com/watch?v=k2MIY338NTE"
  //   },
  //   {
  //     "id": 107,
  //     "playlist_id": 1,
  //     "title": "Midcentury Dream House",
  //     "artist": "The Specific Heats",
  //     "duration": "3:44",
  //     "image_url": "https://i.ytimg.com/vi/iEzmOK9OJ40/default.jpg",
  //     "track_url": "https://youtube.com/watch?v=iEzmOK9OJ40"
  //   },
  //   {
  //     "id": 108,
  //     "playlist_id": 1,
  //     "title": "Parts of Me (Live)",
  //     "artist": "Waves Crashing",
  //     "duration": "4:20",
  //     "image_url": "https://i.ytimg.com/vi/Rwsrle4HenE/default.jpg",
  //     "track_url": "https://youtube.com/watch?v=Rwsrle4HenE"
  //   },
  //   {
  //     "id": 201,
  //     "playlist_id": 2,
  //     "title": "Harpy Hare (Illustrated Song)",
  //     "artist": "Yaelokre",
  //     "duration": "3:30",
  //     "image_url": "https://i.ytimg.com/vi/5-I1lT6Jbdo/default.jpg",
  //     "track_url": "https://youtube.com/watch?v=5-I1lT6Jbdo"
  //   },
  //   {
  //     "id": 301,
  //     "playlist_id": 3,
  //     "title": "Virgin State of Mind",
  //     "artist": "K's Choice",
  //     "duration": "3:55",
  //     "image_url": "https://i.ytimg.com/vi/7kNzDk2CPHI/default.jpg",
  //     "track_url": "https://youtube.com/watch?v=7kNzDk2CPHI"
  //   },
  //   {
  //     "id": 401,
  //     "playlist_id": 4,
  //     "title": "I Believe in You",
  //     "artist": "Ladytron",
  //     "duration": "3:11",
  //     "image_url": "https://i.ytimg.com/vi/AoKrfZSTUXo/default.jpg",
  //     "track_url": "https://youtube.com/watch?v=AoKrfZSTUXo"
  //   },
  //   {
  //     "id": 402,
  //     "playlist_id": 4,
  //     "title": "The Passenger",
  //     "artist": "Metroland",
  //     "duration": "4:05",
  //     "image_url": "https://i.ytimg.com/vi/V6NsNM3HTW4/default.jpg",
  //     "track_url": "https://youtube.com/watch?v=V6NsNM3HTW4"
  //   },
  //   {
  //     "id": 501,
  //     "playlist_id": 5,
  //     "title": "Waterphile",
  //     "artist": "Longing Louisa",
  //     "duration": "2:51",
  //     "image_url": "https://i.ytimg.com/vi/AQs4ab99THE/default.jpg",
  //     "track_url": "https://youtube.com/watch?v=AQs4ab99THE"
  //   },
  //   {
  //     "id": 601,
  //     "playlist_id": 6,
  //     "title": "Your Solitude",
  //     "artist": "Blindness & Light",
  //     "duration": "3:17",
  //     "image_url": "https://i.ytimg.com/vi/roIaUb1TWYw/default.jpg",
  //     "track_url": "https://youtube.com/watch?v=roIaUb1TWYw"
  //   },
  //   {
  //     "id": 701,
  //     "playlist_id": 7,
  //     "title": "To Sir With Love",
  //     "artist": "Lulu",
  //     "duration": "2:52",
  //     "image_url": "https://i.ytimg.com/vi/JOVQ4vAmM7Y/default.jpg",
  //     "track_url": "https://youtube.com/watch?v=JOVQ4vAmM7Y"
  //   },
  //   {
  //     "id": 801,
  //     "playlist_id": 8,
  //     "title": "Seduce",
  //     "artist": "Reverend Beat-Man & Milan Slick",
  //     "duration": "3:28",
  //     "image_url": "https://i.ytimg.com/vi/CEQsFA-CX3c/default.jpg",
  //     "track_url": "https://youtube.com/watch?v=CEQsFA-CX3c"
  //   },
  //   {
  //     "id": 901,
  //     "playlist_id": 9,
  //     "title": "Soul Man",
  //     "artist": "Blues Brothers",
  //     "duration": "3:05",
  //     "image_url": "https://i.ytimg.com/vi/XM0TUtqddpg/default.jpg",
  //     "track_url": "https://youtube.com/watch?v=XM0TUtqddpg"
  //   },
  //   {
  //     "id": 1001,
  //     "playlist_id": 10,
  //     "title": "Song From The Edge Of The World",
  //     "artist": "Siouxsie And The Banshees",
  //     "duration": "4:00",
  //     "image_url": "https://i.ytimg.com/vi/_AX6cTDKRjw/default.jpg",
  //     "track_url": "https://youtube.com/watch?v=_AX6cTDKRjw"
  //   },
  //   {
  //     "id": 1101,
  //     "playlist_id": 11,
  //     "title": "Double Infinity (Official Lyric Video)",
  //     "artist": "Big Thief",
  //     "duration": "3:49",
  //     "image_url": "https://i.ytimg.com/vi/ZjqLmCpPyKM/default.jpg",
  //     "track_url": "https://youtube.com/watch?v=ZjqLmCpPyKM"
  //   }
  // ];

  int? currentMusicPlaying;
  int musicPlayingCount = 0;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        // logDebug("playlistId: ${widget.playlistId}");
        context
            .read<SongCubit>()
            .getSong(songId: widget.songId, playlistId: widget.playlistId);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocConsumer<SongCubit, SongState>(
      listener: (context, songState) {
        if (songState is SongHasDataState) {
          final songCount = songState.songEntity.songs?.length ?? 0;
          final randomIndex = random.nextInt(songCount);

          //? old version - using entity instead of url
          // String url = songState.songEntity.songs?[randomIndex].trackUrl ?? '';
          // if (currentMusicPlaying != null) {
          //   url = songState.songEntity.songs?[currentMusicPlaying!].trackUrl ??
          //       '';
          // }
          // logInfo("PlayerCubit > url : $url");
          SongModelSongsItemEntity? songModelSongsItemEntity =
              songState.songEntity.songs?[randomIndex];

          if (currentMusicPlaying != null) {
            songModelSongsItemEntity =
                songState.songEntity.songs?[currentMusicPlaying!];
          }

          logInfo(
              "PlayerCubit > songModelSongsItemEntity > url : ${songModelSongsItemEntity?.trackUrl}");
          context
              .read<PlayerCubit>()
              .playMusic(songModelSongsItemEntity: songModelSongsItemEntity);
        }
      },
      builder: (context, songState) {
        if (songState is SongHasDataState) {
          final allTrackByPlaylistId = songState.songEntity.songs;
          musicPlayingCount = allTrackByPlaylistId?.length ?? 0;
          return Scaffold(
            backgroundColor: colorScheme.secondary,
            appBar: AppBar(
              backgroundColor: colorScheme.primary,
              leading: Padding(
                padding: EdgeInsets.all(4),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Image.network(
                      allTrackByPlaylistId?[currentMusicPlaying ?? 0]
                              .imageUrl
                              ?.toString() ??
                          '',
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        }
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
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
                            mainAxisAlignment: MainAxisAlignment.center,
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
              automaticallyImplyLeading: true,
              title: ListTile(
                onTap: () {
                  logWarning("playlist pressed");
                  //* playlist pressed goTo Playlist
                },
                title: Text(
                  '${allTrackByPlaylistId?[currentMusicPlaying ?? 0].title}',
                  maxLines: 1,
                  style: TextStyle(
                      color: colorScheme.surface,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis),
                ),
                subtitle: Text(
                  '${allTrackByPlaylistId?[currentMusicPlaying ?? 0].artist} - ${allTrackByPlaylistId?[currentMusicPlaying ?? 0].duration}',
                  maxLines: 2,
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    overflow: TextOverflow.ellipsis,
                    color: colorScheme.surface.withValues(alpha: .5),
                    fontSize: 14,
                  ),
                ),
                trailing: BlocSelector<PlayerCubit, PlayerState, bool>(
                  selector: (isPlayingState) {
                    return isPlayingState.isPlaying;
                  },
                  builder: (context, isPlayingState) {
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        isPlayingState
                            ? IconButton(
                                onPressed: () {
                                  logWarning(
                                      "pause icon pressed / isplay: $isPlayingState");

                                  //* pause

                                  context.read<PlayerCubit>().pause();
                                },
                                icon: Icon(
                                  Icons.pause,
                                  color: colorScheme.surface,
                                ))
                            : IconButton(
                                onPressed: () {
                                  logWarning("play icon pressed");

                                  //* pause

                                  context.read<PlayerCubit>().playMusic();
                                },
                                icon: Icon(
                                  Icons.play_arrow,
                                  color: colorScheme.surface,
                                )),
                        IconButton(
                            onPressed: ((currentMusicPlaying ?? 0) >=
                                    (musicPlayingCount - 1))
                                ? null
                                : () {
                                    logWarning("skip_next icon pressed");

                                    //* skip_next

                                    //todo remove setState (refactor)
                                    if ((currentMusicPlaying ?? 0) <
                                        (musicPlayingCount - 1)) {
                                      setState(() {
                                        currentMusicPlaying =
                                            (currentMusicPlaying ?? 0) + 1;
                                      });

                                      logWarning(
                                          "playlist pressed: $currentMusicPlaying");

                                      final songModelSongsItemEntity = songState
                                          .songEntity
                                          .songs?[currentMusicPlaying ?? 0];
                                      context.read<PlayerCubit>().playMusic(
                                          songModelSongsItemEntity:
                                              songModelSongsItemEntity);
                                    }
                                  },
                            icon: Icon(
                              Icons.skip_next,
                              color: ((currentMusicPlaying ?? 0) >=
                                      (musicPlayingCount - 1))
                                  ? colorScheme.surface.withValues(alpha: .2)
                                  : colorScheme.surface,
                            )),
                      ],
                    );
                  },
                ),
                contentPadding: EdgeInsets.all(8),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  ...List.generate(
                    allTrackByPlaylistId?.length ?? 0,
                    (index) {
                      return ListTile(
                        onTap: () {
                          //* playlist
                          // _playMusicByIndex(index);
                          //todo remove setState (refactor)

                          setState(() {
                            currentMusicPlaying = index;
                          });

                          logWarning("playlist pressed: $currentMusicPlaying");

                          final songModelSongsItemEntity =
                              songState.songEntity.songs?[currentMusicPlaying!];
                          context.read<PlayerCubit>().playMusic(
                              songModelSongsItemEntity:
                                  songModelSongsItemEntity);
                        },
                        leading: SizedBox(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: Image.network(
                                allTrackByPlaylistId?[index]
                                        .imageUrl
                                        ?.toString() ??
                                    '',
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
                          '${allTrackByPlaylistId?[index].title}',
                          maxLines: 1,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis),
                        ),
                        subtitle: Text(
                          '${allTrackByPlaylistId?[index].artist} - ${allTrackByPlaylistId?[index].duration}',
                          maxLines: 2,
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            overflow: TextOverflow.ellipsis,
                            fontSize: 14,
                            color: colorScheme.surface.withValues(alpha: .5),
                          ),
                        ),
                        trailing: IconButton(
                            onPressed: () {
                              logWarning("moveable icon pressed");

                              //todo moveable
                            },
                            icon: Icon(
                              Icons.drag_handle,
                              color: colorScheme.surface.withValues(alpha: .5),
                            )),
                        contentPadding: EdgeInsets.all(8),
                        tileColor: colorScheme.secondary,
                        textColor: colorScheme.surface,
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        }
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  // void _playMusicByIndex(int index) {
  //   setState(() {
  //     currentMusicPlaying = index;
  //   });
  // }
}
