import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
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
  late int _selectedItemIndex;
  late Song _song;
  bool _isPlaying = false;
  bool _isShuffled = false;
  late LoopMode _loopMode;

  @override
  void initState() {
    super.initState();
    _song = widget.playingSong;
    _audioPlayerManager = AudioPlayerManager();
    if (_audioPlayerManager.songUrl.compareTo(_song.source) != 0) {
      _audioPlayerManager.songUrl = _song.source;
      _audioPlayerManager.init(isNewSong: true);
    } else {
      _audioPlayerManager.init();
    }
    _selectedItemIndex = widget.songs.indexOf(widget.playingSong);
    _audioPlayerManager.player.playingStream.listen((playing) {
      setState(() {
        _isPlaying = playing;
      });
    });
    _loopMode = LoopMode.off;
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
                _song.album,
                // style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 16),
              const Text('_ ___ _'),
              const SizedBox(height: 48),
              // Rotating Music Widget
              RotatingMusic(
                imageUrl: _song.image,
                size: screenWidth - delta,
                radius: radius,
                // player: _audioPlayerManager.player,
                isPlaying: _isPlaying,
                key: ValueKey(_song.id),
              ),

              // Name bar
              NameBar(title: _song.title, artist: _song.artist),

              // Progress bar
              AudioProgressBar(
                durationStateStream: _audioPlayerManager.durationState,
                player: _audioPlayerManager.player,
              ),

              // Media control buttons
              MediaButtons(
                player: _audioPlayerManager.player,
                onShuffle: () => _setSuffle(),
                onPrevious: () => _setPrevSong(),
                onNext: () => _setNextSong(),
                onRepeat: () => _setRepeatOption(),
                isShuffled: _isShuffled,
                loopMode: _loopMode,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // _audioPlayerManager.dispose();
    super.dispose();
  }

  void _setNextSong() {
    if (_isShuffled) {
      var random = Random();
      _selectedItemIndex = random.nextInt(widget.songs.length);
    } else if (_selectedItemIndex < widget.songs.length - 1) {
      ++_selectedItemIndex;
    } else if (_loopMode == LoopMode.all &&
        _selectedItemIndex == widget.songs.length - 1) {
      _selectedItemIndex = 0;
    }

    if (_selectedItemIndex >= widget.songs.length) {
      _selectedItemIndex = _selectedItemIndex % widget.songs.length;
    }
    final nextSong = widget.songs[_selectedItemIndex];
    _audioPlayerManager.updateSong(nextSong.source);
    setState(() {
      _song = nextSong;
    });
  }

  void _setPrevSong() {
    if (_isShuffled) {
      var random = Random();
      _selectedItemIndex = random.nextInt(widget.songs.length);
    } else if (_selectedItemIndex > 0) {
      --_selectedItemIndex;
    } else if (_loopMode == LoopMode.all && _selectedItemIndex == 0) {
      _selectedItemIndex = widget.songs.length - 1;
    }

    if (_selectedItemIndex < 0) {
      _selectedItemIndex = -1 * _selectedItemIndex % widget.songs.length;
    }
    final nextSong = widget.songs[_selectedItemIndex];
    _audioPlayerManager.updateSong(nextSong.source);
    setState(() {
      _song = nextSong;
    });
  }

  void _setSuffle() {
    setState(() {
      _isShuffled = !_isShuffled;
    });
    _audioPlayerManager.player.setShuffleModeEnabled(_isShuffled);
  }

  void _setRepeatOption() {
    if (_loopMode == LoopMode.off) {
      _loopMode = LoopMode.one;
    } else if (_loopMode == LoopMode.one) {
      _loopMode = LoopMode.all;
    } else {
      _loopMode = LoopMode.off;
    }
    setState(() {
      _audioPlayerManager.player.setLoopMode(_loopMode);
    });
  }
}
