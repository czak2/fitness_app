import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteVideosModel extends ChangeNotifier {
  List<String> _favoriteVideos = [];
  static const _key = 'favoriteVideos';

  List<String> get favoriteVideos => _favoriteVideos;
  List<String> video = [];
  List<String> desc = [];
  List<String> title = [];
  Future<void> loadFavoriteVideos() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? videos = prefs.getStringList(_key);
    if (videos != null) {
      _favoriteVideos = videos;
      notifyListeners();
    }
  }

  Future<void> addFavoriteVideo(
      String image, String titl, String des, String vide) async {
    _favoriteVideos.add(image);
    title.add(titl);
    desc.add(des);
    video.add(vide);
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_key, _favoriteVideos);
  }

  Future<void> removeFavoriteVideo(
    String video,
  ) async {
    _favoriteVideos.remove(video);
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_key, _favoriteVideos);
  }
}
