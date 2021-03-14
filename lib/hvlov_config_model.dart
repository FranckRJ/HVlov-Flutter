import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

class HvlovConfigModel extends ChangeNotifier {
  static final _privateConfigFile = File("private.config.json");
  static final _configFile = File("config.json");
  static final _version = 2;

  late String _url;
  late String _password;

  String get url => _url;

  String get password => _password;

  int get version => _version;

  HvlovConfigModel() {
    _loadConfig();
  }

  void _loadConfig() {
    final configFile =
        _privateConfigFile.existsSync() ? _privateConfigFile : _configFile;
    final configJson = json.decode(configFile.readAsStringSync());

    _url = configJson["url"];
    _password = configJson["password"];
    notifyListeners();
  }
}
