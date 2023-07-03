import 'song_model.dart';

class Playlist {
  final String title;
  final List<Song> songs;
  final String imageUrl;

  Playlist({
    required this.title,
    required this.songs,
    required this.imageUrl,
  });

  static List<Playlist> playlists = [
    Playlist(
      title: 'Playlist - Uyku',
      songs: Song.songs1,
      imageUrl: 'assets/images/sleep_theme.png',
    ),
    Playlist(
      title: 'Playlist - Sakinleş',
      songs: Song.songs2,
      imageUrl: 'assets/images/relaxing_theme.png',
    ),
    Playlist(
      title: 'Playlist - Piyano',
      songs: Song.songs3,
      imageUrl: 'assets/images/piano_theme.png',
    ),
    Playlist(
      title: 'Playlist - Neşelen',
      songs: Song.songs4,
      imageUrl: 'assets/images/happy_theme.png',
    )
  ];
}
