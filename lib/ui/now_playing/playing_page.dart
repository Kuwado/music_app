import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_app/ui/now_playing/audio_player_manager.dart';
import 'package:music_app/ui/now_playing/media_buttons.dart';
import 'package:music_app/ui/now_playing/name_bar.dart';
import 'package:music_app/ui/now_playing/progress_bar.dart';
import 'package:music_app/ui/now_playing/rorating_music.dart';

import '../../data/model/song.dart';

class NowPlaying extends StatelessWidget {
  const NowPlaying({super.key, required this.songs, required this.playingSong});
  final Song playingSong;
  final List<Song> songs;

  @override
  Widget build(BuildContext context) {
    return NowPlayingPage(songs: songs, playingSong: playingSong);
  }
}

class NowPlayingPage extends StatefulWidget {
  const NowPlayingPage({
    super.key,
    required this.songs,
    required this.playingSong,
  });
  final Song playingSong;
  final List<Song> songs;

  @override
  State<NowPlayingPage> createState() => _NowPlayingPageState();
}

class _NowPlayingPageState extends State<NowPlayingPage> {
  late AudioPlayerManager _audioPlayerManager;

  @override
  void initState() {
    super.initState();
    _audioPlayerManager = AudioPlayerManager(
      songUrl: widget.playingSong.source,
    );
    _audioPlayerManager.init();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    const delta = 64;
    final radius = (screenWidth - delta) / 2;

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Now Playing'),
        trailing: IconButton(
          onPressed: () => {},
          icon: const Icon(Icons.more_horiz),
        ),
      ),

      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.playingSong.album,
                // style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 16),
              const Text('_ ___ _'),
              const SizedBox(height: 48),
              // Rotating Music Widget
              RotatingMusic(
                imageUrl: widget.playingSong.image,
                size: screenWidth - delta,
                radius: radius,
              ),

              // Name bar
              NameBar(
                title: widget.playingSong.title,
                artist: widget.playingSong.artist,
              ),

              // Progress bar
              AudioProgressBar(
                durationStateStream: _audioPlayerManager.durationState,
              ),

              // Media control buttons
              MediaButtons(
                onShuffle: () {},
                onPrevious: () {},
                onPlayPause: () {},
                onNext: () {},
                onRepeat: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
