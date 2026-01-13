import '../model/song.dart';
import '../source/source.dart';

abstract interface class Repository {
  Future<List<Song>?> loadData();
}

class DefaultRepository implements Repository {
  final _localDataSource = LocalDataSource();
  final _remoteDataSource = RemoteDataSource();

  @override
  Future<List<Song>?> loadData() async {
    final remoteSongs = await _remoteDataSource.loadData();

    if (remoteSongs != null && remoteSongs.isNotEmpty) {
      return remoteSongs;
    }

    final localSongs = await _localDataSource.loadData();
    return localSongs ?? [];
  }
}
