import 'package:flutter/cupertino.dart';

class RotatingMusic extends StatefulWidget {
  final String imageUrl;
  final double size;
  final double radius;
  final bool isPlaying;

  const RotatingMusic({
    super.key,
    required this.imageUrl,
    required this.size,
    required this.radius,
    required this.isPlaying,
  });

  @override
  State<RotatingMusic> createState() => _RotatingMusicState();
}

class _RotatingMusicState extends State<RotatingMusic>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    );

    if (widget.isPlaying) {
      _controller.repeat();
    }
  }

  @override
  void didUpdateWidget(covariant RotatingMusic oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isPlaying && !_controller.isAnimating) {
      _controller.repeat();
    } else if (!widget.isPlaying && _controller.isAnimating) {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widget.radius),
        child: FadeInImage.assetNetwork(
          placeholder: 'assets/music.png',
          image: widget.imageUrl,
          width: widget.size,
          height: widget.size,
          fit: BoxFit.cover,
          imageErrorBuilder: (context, error, stackTrace) {
            return Image.asset(
              'assets/music.png',
              width: widget.size,
              height: widget.size,
              fit: BoxFit.cover,
            );
          },
        ),
      ),
    );
  }
}
