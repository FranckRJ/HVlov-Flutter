import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';

import 'hvlov_app.dart';

void main() {
  runApp(HvlovApp());

  doWhenWindowReady(() {
    appWindow.title = "HVlov";
    appWindow.show();
  });
}
