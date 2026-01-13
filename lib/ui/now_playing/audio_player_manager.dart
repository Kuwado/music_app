import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

class AudioPlayerManager {
  AudioPlayerManager({required this.songUrl});
  String songUrl;

  final player = AudioPlayer();
  Stream<DurationState>? durationState;

  void init() {
    durationState = Rx.combineLatest2<Duration, PlaybackEvent, DurationState>(
      player.positionStream,
      player.playbackEventStream,
      (position, playbackEvent) => DurationState(
        progress: position,
        buffer: playbackEvent.bufferedPosition,
        total: playbackEvent.duration ?? Duration.zero,
      ),
    );
    player.setUrl(songUrl);
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
