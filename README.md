# Music Playlist Flutter App

A Flutter music playlist application built using **Clean Architecture**.  
The app allows users to manage and play songs from playlists with **play** and **pause** functionality.

---

## Features

- **My Playlist Page**  
  View all playlists and select one to see the songs inside.

- **Playlist Detail / Player Page**  
  - View songs in the selected playlist  
  - Play and pause individual songs  
  - Stream song duration and position in real-time  

- **Clean Architecture**  
  Organized into `core` and `music` features, separating **domain**, **data**, **presentation**, and **use cases**.

---




### Screenshots
<table>
  <tr>
    <td>
<img src="https://github.com/panmegatech/music_playlist/blob/develop/images/playlist.png?raw=true" width="400" alt="My Playlist" >
      <p align="center">My Playlist</p>
    </td>
    <td>
<img src="https://github.com/panmegatech/music_playlist/blob/develop/images/play-music.png?raw=true" width="400" alt="Now Playing" >
      <p align="center">Now Playing</p>
    </td>
  </tr>
</table>


---

## Project Structure

```bash
lib/
├─ features/
│ ├─ core/
│ │ ├─ constants/
│ │ ├─ error/
│ │ ├─ routes/
│ │ └─ utils/
│ └─ music/
│ ├─ data/
│ ├─ domain/
│ │ ├─ entities/
│ │ ├─ infra/
│ │ ├─ repository/
│ │ │ └─ music_repository.dart
│ │ └─ usecases/
│ │ ├─ get_duration_stream_usecase.dart
│ │ ├─ get_playing_stream_usecase.dart
│ │ ├─ get_position_stream_usecase.dart
│ │ ├─ pause_music_usecase.dart
│ │ ├─ play_music_usecase.dart
│ │ ├─ playlist_usecase.dart
│ │ ├─ song_usecase.dart
│ │ ├─ stream_usecase.dart
│ │ └─ music_config_provider.dart
│ └─ presentation/
│ ├─ bloc/
│ │ ├─ audio/
│ │ ├─ player/
│ │ ├─ playlist/
│ │ └─ song/
│ ├─ pages/
│ │ ├─ page_not_found_screen.dart
│ │ ├─ playlist_screen.dart
│ │ └─ playlist_view_screen.dart
│ └─ widgets/
├─ main_app.dart
├─ main.dart
└─ setup_locator.dart


---




## Getting Started

### Prerequisites

- Flutter 3.x or higher
- Dart 3.x
- A device or emulator for iOS/Android

### Installation

```bash
git clone https://github.com/panmegatech/music_playlist.git
cd music_-_playlist
flutter pub get
flutter run


