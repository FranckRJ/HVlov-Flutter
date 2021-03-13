import 'package:flutter/material.dart';
import 'hvlov_folder_page.dart';

class HvlovApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "HVlov",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => HvlovFolderPage(),
      },
    );
  }
}
