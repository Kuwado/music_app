import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:music_app/ui/now_playing/audio_player_manager.dart';

class AudioProgressBar extends StatelessWidget {
  final Stream<DurationState>? durationStateStream;

  const AudioProgressBar({super.key, required this.durationStateStream});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 32, left: 24, right: 24, bottom: 16),
      child: StreamBuilder<DurationState>(
        stream: durationStateStream,
        builder: (context, snapshot) {
          final durationState = snapshot.data;
          final progress = durationState?.progress ?? Duration.zero;
          final buffered = durationState?.buffer ?? Duration.zero;
          final total = durationState?.total ?? Duration.zero;
          return ProgressBar(
            progress: progress,
            buffered: buffered,
            total: total,
          );
        },
      ),
    );
  }
}
