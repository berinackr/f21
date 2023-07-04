import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

import '../../../core/custom_styles.dart';
import '../../../models/playlist_model.dart';

class PositionData {
  const PositionData(
    this.position,
    this.bufferedPosition,
    this.duration,
  );
  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;
}

/*sayfa initilize edilirken playlistIndex ile playlist atanır ve sayfa buna göre 
oluşturulur, bu sayede 1 sayfada birden çok playlist kullanılabilir.*/
class playListIndex {
  static late int playlistIndex;
  setPlayListIndex(int index) {
    playlistIndex = index;
  }
}

class AudioPlayerScreen extends StatefulWidget {
  const AudioPlayerScreen({super.key});

  @override
  State<AudioPlayerScreen> createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  late AudioPlayer _audioPlayer;
  static int currentSongIndex = 0;

  Stream<PositionData> get _positionDataStream => Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
      _audioPlayer.positionStream,
      _audioPlayer.bufferedPositionStream,
      _audioPlayer.durationStream,
      (position, bufferedPosition, duration) => PositionData(
            position,
            bufferedPosition,
            duration ?? Duration.zero,
          ));

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer()..setAsset(Playlist.playlists[playListIndex.playlistIndex].songs[0].url);
    _AudioPlayerScreenState.currentSongIndex = 0;
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Playlist playlist = Playlist.playlists[playListIndex.playlistIndex];
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: CustomStyles.primaryColor,
            image: const DecorationImage(image: AssetImage('assets/images/home-bg.png'), fit: BoxFit.cover),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 75),
              StreamBuilder<PositionData>(
                stream: _positionDataStream,
                builder: (context, snapshot) {
                  final positionData = snapshot.data;
                  return Column(
                    children: [
                      Text(
                        //üstteki playlist title'ı
                        playlist.title,
                        style: const TextStyle(fontSize: 25, color: Colors.white),
                      ),
                      const SizedBox(height: 15),
                      Image(
                        //playlist bannerı
                        image: AssetImage(playlist.imageUrl),
                        width: 200,
                        height: 200,
                      ),
                      const SizedBox(height: 30),
                      //progress bar ve renk ayarları
                      ProgressBar(
                        barHeight: 8,
                        baseBarColor: Colors.grey[600],
                        bufferedBarColor: Colors.grey,
                        progressBarColor: CustomStyles.backgroundColor,
                        thumbColor: CustomStyles.backgroundColor,
                        timeLabelTextStyle: TextStyle(
                          color: Colors.grey[300],
                          fontWeight: FontWeight.w600,
                        ),
                        progress: positionData?.position ?? Duration.zero,
                        buffered: positionData?.bufferedPosition ?? Duration.zero,
                        total: positionData?.duration ?? Duration.zero,
                        onSeek: _audioPlayer.seek,
                      ),
                    ],
                  );
                },
              ),
              //methodların kullanılabilmesi için audioplayer ve playlist initilize edilir.
              const SizedBox(height: 20),
              Controls(
                audioPlayer: _audioPlayer,
                playlist: playlist,
              ),
              _PlaylistSongs(
                playlist: playlist,
                audioPlayer: _audioPlayer,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PlaylistSongs extends StatefulWidget {
  const _PlaylistSongs({
    Key? key,
    required this.playlist,
    required this.audioPlayer,
  }) : super(key: key);

  final Playlist playlist;
  final AudioPlayer audioPlayer;
  @override
  _PlaylistSongsState createState() => _PlaylistSongsState();
}

class _PlaylistSongsState extends State<_PlaylistSongs> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //playlist modelları çekerek list oluşturur
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.playlist.songs.length,
          itemBuilder: (context, index) {
            return InkWell(
              //listeden bir şarkıya tıklandığında state ederek asseti çağırır
              onTap: () {
                setState(() {
                  _AudioPlayerScreenState.currentSongIndex = index;
                  widget.audioPlayer.setAsset(
                    widget.playlist.songs[_AudioPlayerScreenState.currentSongIndex].url,
                  );
                });
              },
              child: ListTile(
                leading: Text(
                  '${index + 1}',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
                ),
                title: Text(
                  widget.playlist.songs[index].title,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                ),
                subtitle: Text(
                  widget.playlist.songs[index].description,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class Controls extends StatefulWidget {
  const Controls({
    Key? key,
    required this.audioPlayer,
    required this.playlist,
  }) : super(key: key);

  final AudioPlayer audioPlayer;
  final Playlist playlist;

  @override
  _ControlsState createState() => _ControlsState();
}

class _ControlsState extends State<Controls> {
  bool loopEnabled = false;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PlayerState>(
      stream: widget.audioPlayer.playerStateStream,
      builder: (context, snapshot) {
        final playerState = snapshot.data;
        final processingState = playerState?.processingState;
        final playing = playerState?.playing;
        if (loopEnabled == true) {
          //loop butonu aktifleştirilmiş ise loop modunu açar
          widget.audioPlayer.setLoopMode(LoopMode.one);
        } else {
          //loop butonu aktif değil ise şarkılar playlist sırasınca devam eder
          widget.audioPlayer.setLoopMode(LoopMode.off);
          if (processingState == ProcessingState.completed) {
            if (_AudioPlayerScreenState.currentSongIndex < widget.playlist.songs.length - 1) {
              _AudioPlayerScreenState.currentSongIndex += 1;
              widget.audioPlayer.setAsset(
                widget.playlist.songs[_AudioPlayerScreenState.currentSongIndex].url,
              );
            }
          }
        }

        if (!(playing ?? false)) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      "${_AudioPlayerScreenState.currentSongIndex + 1}} ${widget.playlist.songs[_AudioPlayerScreenState.currentSongIndex].title}",
                      style: const TextStyle(fontSize: 20, color: Colors.white)),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        if (_AudioPlayerScreenState.currentSongIndex > 0) {
                          _AudioPlayerScreenState.currentSongIndex -= 1;
                          widget.audioPlayer.setAsset(
                            widget.playlist.songs[_AudioPlayerScreenState.currentSongIndex].url,
                          );
                        }
                      });
                    },
                    iconSize: 50,
                    color: Colors.grey[300],
                    icon: const Icon(Icons.skip_previous),
                  ),
                  IconButton(
                    onPressed: widget.audioPlayer.play,
                    iconSize: 50,
                    color: Colors.grey[300],
                    icon: const Icon(Icons.play_arrow_rounded),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        //algoritma ile taşma sorununu kontrol edip, butonlara basıldığında arttırma azaltma işlemlerini yapar
                        if (_AudioPlayerScreenState.currentSongIndex < widget.playlist.songs.length - 1) {
                          _AudioPlayerScreenState.currentSongIndex += 1;
                          widget.audioPlayer.setAsset(
                            widget.playlist.songs[_AudioPlayerScreenState.currentSongIndex].url,
                          );
                        }
                      });
                    },
                    iconSize: 50,
                    color: Colors.grey[300],
                    icon: const Icon(Icons.skip_next),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        //loop'u aktifleştirip deaktive edince renginin değişmesi için
                        loopEnabled = !loopEnabled;
                      });
                    },
                    iconSize: 30,
                    color: loopEnabled ? Colors.blue : Colors.grey[300],
                    icon: const Icon(Icons.loop),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        widget.audioPlayer.setAsset(
                          widget.playlist.songs[_AudioPlayerScreenState.currentSongIndex].url,
                        );
                      });
                    },
                    iconSize: 30,
                    color: Colors.grey[300],
                    icon: const Icon(Icons.refresh),
                  ),
                ],
              ),
            ],
          );
        } else if (processingState != ProcessingState.completed) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      "${_AudioPlayerScreenState.currentSongIndex + 1}} ${widget.playlist.songs[_AudioPlayerScreenState.currentSongIndex].title}",
                      style: const TextStyle(fontSize: 20, color: Colors.white)),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        if (_AudioPlayerScreenState.currentSongIndex > 0) {
                          _AudioPlayerScreenState.currentSongIndex -= 1;
                          widget.audioPlayer.setAsset(
                            widget.playlist.songs[_AudioPlayerScreenState.currentSongIndex].url,
                          );
                        }
                      });
                    },
                    iconSize: 50,
                    color: Colors.grey[300],
                    icon: const Icon(Icons.skip_previous),
                  ),
                  IconButton(
                    onPressed: widget.audioPlayer.pause,
                    iconSize: 50,
                    color: Colors.grey[300],
                    icon: const Icon(Icons.pause_rounded),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        if (_AudioPlayerScreenState.currentSongIndex < widget.playlist.songs.length - 1) {
                          _AudioPlayerScreenState.currentSongIndex += 1;
                          widget.audioPlayer.setAsset(
                            widget.playlist.songs[_AudioPlayerScreenState.currentSongIndex].url,
                          );
                        }
                      });
                    },
                    iconSize: 50,
                    color: Colors.grey[300],
                    icon: const Icon(Icons.skip_next),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        loopEnabled = !loopEnabled;
                      });
                    },
                    iconSize: 30,
                    color: loopEnabled ? Colors.blue : Colors.grey[300],
                    icon: const Icon(Icons.loop),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        widget.audioPlayer.setAsset(
                          widget.playlist.songs[_AudioPlayerScreenState.currentSongIndex].url,
                        );
                      });
                    },
                    iconSize: 30,
                    color: Colors.grey[300],
                    icon: const Icon(Icons.refresh),
                  ),
                ],
              ),
            ],
          );
        }

        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                    "${_AudioPlayerScreenState.currentSongIndex + 1}} ${widget.playlist.songs[_AudioPlayerScreenState.currentSongIndex].title}",
                    style: const TextStyle(fontSize: 20, color: Colors.white)),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      if (_AudioPlayerScreenState.currentSongIndex > 0) {
                        _AudioPlayerScreenState.currentSongIndex -= 1;
                        widget.audioPlayer.setAsset(
                          widget.playlist.songs[_AudioPlayerScreenState.currentSongIndex].url,
                        );
                      }
                    });
                  },
                  iconSize: 50,
                  color: Colors.grey[300],
                  icon: const Icon(Icons.skip_previous),
                ),
                IconButton(
                  onPressed: widget.audioPlayer.play,
                  iconSize: 50,
                  color: Colors.grey[300],
                  icon: const Icon(Icons.play_arrow_rounded),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      if (_AudioPlayerScreenState.currentSongIndex < widget.playlist.songs.length - 1) {
                        _AudioPlayerScreenState.currentSongIndex += 1;
                        widget.audioPlayer.setAsset(
                          widget.playlist.songs[_AudioPlayerScreenState.currentSongIndex].url,
                        );
                      }
                    });
                  },
                  iconSize: 50,
                  color: Colors.grey[300],
                  icon: const Icon(Icons.skip_next),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      loopEnabled = !loopEnabled;
                    });
                  },
                  iconSize: 30,
                  color: loopEnabled ? Colors.blue : Colors.grey[300],
                  icon: const Icon(Icons.loop),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      widget.audioPlayer.setAsset(
                        widget.playlist.songs[_AudioPlayerScreenState.currentSongIndex].url,
                      );
                    });
                  },
                  iconSize: 30,
                  color: Colors.grey[300],
                  icon: const Icon(Icons.refresh),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
