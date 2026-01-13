import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_app/ui/now_playing/play_pause_button.dart';
import 'media_button_control.dart';

class MediaButtons extends StatelessWidget {
  const MediaButtons({
    super.key,
    required this.player,
    required this.onShuffle,
    required this.onPrevious,
    required this.onNext,
    required this.onRepeat,
    this.isPlaying = false,
    this.isShuffled = false,
    required this.loopMode,
  });

  final AudioPlayer player;
  final VoidCallback onShuffle;
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final VoidCallback onRepeat;
  final bool isPlaying;
  final bool isShuffled;
  final LoopMode loopMode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0, left: 24, right: 24, bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          MediaButtonControl(
            function: onShuffle,
            icon: Icons.shuffle,
            color: _getShuffleColor(),
            size: 24,
          ),
          MediaButtonControl(
            function: onPrevious,
            icon: Icons.skip_previous,
            color: Colors.deepPurple,
            size: 36,
          ),
          PlayPauseButton(player: player),
          MediaButtonControl(
            function: onNext,
            icon: Icons.skip_next,
            color: Colors.deepPurple,
            size: 36,
          ),
          MediaButtonControl(
            function: onRepeat,
            icon: _repeatingIcon(),
            color: _getRepeatingColor(),
            size: 24,
          ),
        ],
      ),
    );
  }

  Color? _getShuffleColor() {
    if (isShuffled) {
      return Colors.deepPurple;
    } else {
      return Colors.grey;
    }
  }

  IconData _repeatingIcon() {
    return switch (loopMode) {
      LoopMode.all => Icons.repeat_on,
      LoopMode.one => Icons.repeat_one,
      _ => Icons.repeat,
    };
  }

  Color? _getRepeatingColor() {
    return loopMode == LoopMode.off ? Colors.grey : Colors.deepPurple;
  }
}
