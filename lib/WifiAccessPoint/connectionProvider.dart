import 'package:flutter/material.dart';

class ConnectionProvider with ChangeNotifier {
  bool _connected = false;
  String _ip = '';

  bool get connected => _connected;
  String get ip => _ip;

  set ip(String newIp) {
    _ip = newIp;
    notifyListeners();
  }

  void connect() {
    _connected = true;
    notifyListeners();
  }

  void disconnect() {
    _connected = false;
    notifyListeners();
  }
}
