import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'hvlov_config_model.dart';
import 'hvlov_folder_page.dart';

class HvlovApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HvlovConfigModel(),
      child: MaterialApp(
        title: "HVlov",
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: "/",
        routes: {
          "/": (context) => HvlovFolderPage(),
        },
      ),
    );
  }
}
