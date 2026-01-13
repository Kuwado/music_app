import 'package:flutter/cupertino.dart';

class RotatingMusic extends StatefulWidget {
  final String imageUrl;
  final double size;
  final double radius;

  const RotatingMusic({
    super.key,
    required this.imageUrl,
    required this.size,
    required this.radius,
  });

  @override
  State<RotatingMusic> createState() => _RotatingMusicState();
}

class _RotatingMusicState extends State<RotatingMusic>
    with SingleTickerProviderStateMixin {
  late AnimationController _imageAnimationController;

  @override
  void initState() {
    super.initState();
    _imageAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    );
  }

  @override
  void dispose() {
    _imageAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: Tween(begin: 0.0, end: 1.0).animate(_imageAnimationController),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widget.radius),
        child: FadeInImage.assetNetwork(
          placeholder: 'assets/music.png',
          image: widget.imageUrl,
          width: widget.size,
          height: widget.size,
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
