import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'media_button_control.dart';

class PlayPauseButton extends StatelessWidget {
  const PlayPauseButton({super.key, required this.player});

  final AudioPlayer player;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PlayerState>(
      stream: player.playerStateStream,
      builder: (context, snapshot) {
        final playerState = snapshot.data;
        final processingState = playerState?.processingState;
        final playing = playerState?.playing;

        if (processingState == ProcessingState.loading ||
            processingState == ProcessingState.buffering) {
          return const SizedBox(
            width: 48,
            height: 48,
            child: CircularProgressIndicator(),
          );
        }

        if (playing != true) {
          return MediaButtonControl(
            function: () {
              player.play();
            },
            icon: Icons.play_arrow,
            color: null,
            size: 48,
          );
        }

        if (processingState != ProcessingState.completed) {
          return MediaButtonControl(
            function: player.pause,
            icon: Icons.pause,
            color: null,
            size: 48,
          );
        }

        return MediaButtonControl(
          function: () => player.seek(Duration.zero),
          icon: Icons.replay,
          color: null,
          size: 48,
        );
      },
    );
  }
}
