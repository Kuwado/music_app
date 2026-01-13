import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

class AudioPlayerManager {
  AudioPlayerManager._internal();
  static final AudioPlayerManager _instance = AudioPlayerManager._internal();
  factory AudioPlayerManager() => _instance;

  // AudioPlayerManager({required this.songUrl});
  String songUrl = '';

  final player = AudioPlayer();
  Stream<DurationState>? durationState;

  Future<void> init({bool isNewSong = false}) async {
    durationState = Rx.combineLatest2<Duration, PlaybackEvent, DurationState>(
      player.positionStream,
      player.playbackEventStream,
      (position, playbackEvent) => DurationState(
        progress: position,
        buffer: playbackEvent.bufferedPosition,
        total: playbackEvent.duration ?? Duration.zero,
      ),
    );

    if (isNewSong) {
      await player.setUrl(songUrl);
    }

    // await player.play();
  }

  void updateSong(String url) async {
    songUrl = url;
    await player.stop();
    await player.setUrl(songUrl);
    await player.play();
  }

  void dispose() {
    player.dispose();
  }
}

class DurationState {
  final Duration progress;
  final Duration buffer;
  final Duration total;

  DurationState({
    required this.progress,
    required this.buffer,
    required this.total,
  });
}
