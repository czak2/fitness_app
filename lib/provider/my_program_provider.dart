import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyProgramProvider extends ChangeNotifier {
  List<String> _myProgram = [];
  static const _myProgramKey = 'myPrograms';

  List<String> get myProgram => _myProgram;
  Future<void> loadMyProgram() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? videos = prefs.getStringList(_myProgramKey);
    if (videos != null) {
      _myProgram = videos;
      notifyListeners();
    }
  }

  Future<void> addMyProgram(String image) async {
    _myProgram.add(image);
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_myProgramKey, _myProgram);
  }
}
