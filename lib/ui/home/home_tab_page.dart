import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_app/data/model/song.dart';
import 'package:music_app/ui/home/bottom_sheet.dart';
import 'package:music_app/ui/home/song_item.dart';
import 'package:music_app/ui/home/viewmodel.dart';
import 'package:music_app/ui/now_playing/playing.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeTabPage();
  }
}

// Placeholder for HomeTabPage
class HomeTabPage extends StatefulWidget {
  const HomeTabPage({super.key});

  @override
  State<HomeTabPage> createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> {
  List<Song> songs = [];
  late MusicAppViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = MusicAppViewModel();
    _viewModel.loadSongs();
    observeData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: getBody());
  }

  @override
  void dispose() {
    _viewModel.songStream.close();
    super.dispose();
  }

  Widget getBody() {
    bool showLoading = songs.isEmpty;
    if (showLoading) {
      return getProgressBar();
    } else {
      return getListView();
    }
  }

  Widget getProgressBar() {
    return const Center(child: CircularProgressIndicator());
  }

  ListView getListView() {
    return ListView.separated(
      itemBuilder: (context, position) {
        return SongItem(
          song: songs[position],
          onMore: () => showMoreOptions(context),
          onTap: () => navigate(songs[position]),
        );
      },
      separatorBuilder: (context, index) {
        return const Divider(
          color: Colors.grey,
          thickness: 1,
          indent: 24,
          endIndent: 24,
        );
      },
      itemCount: songs.length,
      shrinkWrap: true,
    );
  }

  void observeData() {
    _viewModel.songStream.stream.listen((songList) {
      setState(() {
        songs.addAll(songList);
      });
    });
  }

  void navigate(Song song) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) {
          return NowPlaying(songs: songs, playingSong: song);
        },
      ),
    );
  }
}
