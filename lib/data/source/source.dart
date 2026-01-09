import 'dart:convert';

import '../model/song.dart';
import 'package:http/http.dart' as http;

abstract interface class Source {
  Future<List<Song>?> loadData();
}

class RemoteDataSource implements Source {
  @override
  Future<List<Song>?> loadData() async {
    const url = 'https://thantrieu.com/resources/braniumapis/songs.json';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final bodyContent = utf8.decode(response.bodyBytes);
      var songWrapper = jsonDecode(bodyContent) as Map;
      var songList = songWrapper['songs'];
      List<Song> songs = songList
          .map<Song>((songMap) => Song.fromJson(songMap))
          .toList();
      return songs;
    } else {
      return null;
    }
  }
}

class LocalDataSource implements Source {
  @override
  Future<List<Song>?> loadData() {
    // Implementation here
    throw UnimplementedError();
  }
}
