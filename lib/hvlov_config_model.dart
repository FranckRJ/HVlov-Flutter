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

  File _getConfigFile() {
    return _privateConfigFile.existsSync() ? _privateConfigFile : _configFile;
  }

  dynamic _loadJsonConfig() {
    final configFile = _getConfigFile();
    return json.decode(configFile.readAsStringSync());
  }

  void _saveJsonConfig(Object jsonConfig) {
    final configFile = _getConfigFile();
    configFile.writeAsString(json.encode(jsonConfig));
  }

  void _loadConfig() {
    final jsonConfig = _loadJsonConfig();

    _url = jsonConfig["url"];
    _password = jsonConfig["password"];
    notifyListeners();
  }

  void saveConfig(String url, String password) {
    _url = url;
    _password = password;

    final jsonConfig = {"url": _url, "password": _password};
    _saveJsonConfig(jsonConfig);

    notifyListeners();
  }
}
