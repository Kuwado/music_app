import 'package:flutter/material.dart';

class NameBar extends StatelessWidget {
  final String title;
  final String artist;
  final VoidCallback? onShare;
  final VoidCallback? onLike;

  const NameBar({
    super.key,
    required this.title,
    required this.artist,
    this.onShare,
    this.onLike,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 64, bottom: 16),
      child: SizedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: onShare,
              icon: const Icon(Icons.share_outlined),
              color: Theme.of(context).colorScheme.primary,
            ),
            Column(
              children: [
                Text(title, style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: 8),
                Text(
                  artist,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).textTheme.bodyMedium!.color!,
                  ),
                ),
              ],
            ),
            IconButton(
              onPressed: onLike,
              icon: const Icon(Icons.favorite_outline),
              color: Theme.of(context).colorScheme.primary,
            ),
          ],
        ),
      ),
    );
  }
}
