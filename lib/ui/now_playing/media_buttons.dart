import 'package:flutter/material.dart';
import 'media_button_control.dart';

class MediaButtons extends StatelessWidget {
  const MediaButtons({
    super.key,
    required this.onShuffle,
    required this.onPrevious,
    required this.onPlayPause,
    required this.onNext,
    required this.onRepeat,
    this.isPlaying = false,
  });

  final VoidCallback onShuffle;
  final VoidCallback onPrevious;
  final VoidCallback onPlayPause;
  final VoidCallback onNext;
  final VoidCallback onRepeat;
  final bool isPlaying;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 32, left: 24, right: 24, bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          MediaButtonControl(
            function: onShuffle,
            icon: Icons.shuffle,
            color: Colors.deepPurple,
            size: 24,
          ),
          MediaButtonControl(
            function: onPrevious,
            icon: Icons.skip_previous,
            color: Colors.deepPurple,
            size: 36,
          ),
          MediaButtonControl(
            function: onPlayPause,
            icon: isPlaying
                ? Icons.pause_circle_filled
                : Icons.play_arrow_sharp,
            color: Colors.deepPurple,
            size: 48,
          ),
          MediaButtonControl(
            function: onNext,
            icon: Icons.skip_next,
            color: Colors.deepPurple,
            size: 36,
          ),
          MediaButtonControl(
            function: onRepeat,
            icon: Icons.repeat,
            color: Colors.deepPurple,
            size: 24,
          ),
        ],
      ),
    );
  }
}
