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

  void _createDefaultConfigFile(File configFile) {
    final jsonConfig = {"url": "", "password": ""};
    configFile.writeAsString(json.encode(jsonConfig));
  }

  void _loadConfig() {
    final configFile = _getConfigFile();

    if (!configFile.existsSync()) {
      _createDefaultConfigFile(configFile);
    }

    final jsonConfig = json.decode(configFile.readAsStringSync());

    _url = jsonConfig["url"];
    _password = jsonConfig["password"];
    notifyListeners();
  }

  void saveConfig(String url, String password) {
    final configFile = _getConfigFile();

    _url = url;
    _password = password;

    final jsonConfig = {"url": _url, "password": _password};
    configFile.writeAsString(json.encode(jsonConfig));

    notifyListeners();
  }
}
