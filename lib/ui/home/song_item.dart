import 'package:flutter/material.dart';

import '../../data/model/song.dart';

class SongItem extends StatelessWidget {
  final Song song;
  final VoidCallback onMore;
  final VoidCallback onTap;

  const SongItem({
    super.key,
    required this.song,
    required this.onMore,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 24, right: 8),
      leading: ClipOval(
        child: FadeInImage.assetNetwork(
          placeholder: 'assets/music.png',
          image: song.image,
          width: 50,
          height: 50,
          imageErrorBuilder: (context, error, stackTrace) {
            return Image.asset('assets/music.png', width: 50, height: 50);
          },
        ),
      ),

      title: Text(song.title),
      subtitle: Text(song.artist),
      trailing: IconButton(
        icon: const Icon(Icons.more_horiz),
        onPressed: onMore,
      ),
      onTap: onTap,
    );
  }
}
