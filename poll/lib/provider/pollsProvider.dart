import 'package:flutter/material.dart';

class PollsProvider extends ChangeNotifier {
  List<dynamic> _pollsName = [];

//getter
  List<dynamic> get pollsName => _pollsName.reversed.toList();

  //setter
  void updateList(var data) {
    print("list updated in provider");

    _pollsName = data;
    notifyListeners();
  }
}
