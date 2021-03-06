import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'hvlov_config_model.dart';
import 'hvlov_entry.dart';

class HvlovFolderModel extends ChangeNotifier {
  List<HvlovEntry> _entries = [];
  Future? _updateEntriesFuture;
  late HvlovConfigModel _configModel;

  List<HvlovEntry> get entries => _entries;

  Future<List<HvlovEntry>> _getUpdatedEntries(String path) async {
    http.Response resp = await http.post(Uri.parse(_configModel.url), body: {
      "version": _configModel.version.toString(),
      "password": _configModel.password,
      "path": path
    });

    List entries = json.decode(resp.body);

    return entries.map((entry) {
      final String entryType = entry["type"];
      switch (entryType) {
        case "video":
          return HvlovEntry.video(entry["title"], entry["url"]);
        case "folder":
          return HvlovEntry.folder(entry["title"], entry["url"]);
        case "video_group":
          return HvlovEntry.videoGroup(
              entry["title"], entry["urls"].cast<String, String>());
        default:
          throw Exception("Wrong type $entryType.");
      }
    }).toList();
  }

  void requestUpdateEntries(String path) {
    if (_updateEntriesFuture == null) {
      _entries = [];
      notifyListeners();
      _updateEntriesFuture = _getUpdatedEntries(path)
        ..then((value) {
          _entries = value;
          notifyListeners();
        })
        ..whenComplete(() {
          _updateEntriesFuture = null;
        });
    }
  }

  void update(HvlovConfigModel newConfigModel) {
    _configModel = newConfigModel;
  }
}
