import 'package:flutter/material.dart';

class MyModel extends ChangeNotifier {
  int _counter;

  int get counter => _counter;
  String _name;

  String get name => _name;

  MyModel(this._counter, this._name);

  void increment() {
    _counter++;
    notifyListeners();
  }

  void changeName(String val) {
    _name = val;
    notifyListeners();
  }
}
