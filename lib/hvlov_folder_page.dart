import 'package:flutter/material.dart';
import 'package:process_run/cmd_run.dart';
import 'package:provider/provider.dart';

import 'hvlov_folder_model.dart';
import 'hvlov_folder_widget.dart';
import 'private.conf.dart' as conf;

class HvlovFolderPage extends StatelessWidget {
  const HvlovFolderPage({Key? key}) : super(key: key);

  Future _launchVlc(String path) async {
    final cmd =
    ProcessCmd(r"C:\Program Files\VideoLAN\VLC\vlc.exe", [conf.url + path]);
    await runCmd(cmd);
  }

  String _formatPathToPrettyPath(String path) {
    return path.replaceAll('_', ' ').replaceAll('/', ' / ');
  }

  @override
  Widget build(BuildContext context) {
    final String path =
        ModalRoute.of(context)?.settings.arguments as String? ?? "";

    return ChangeNotifierProvider(
      create: (context) => HvlovFolderModel()..requestUpdateEntries(path),
      builder: (context, _) => Scaffold(
        appBar: AppBar(
          title: Text("HVlov" +
              (path.isEmpty ? "" : " : ${_formatPathToPrettyPath(path)}")),
        ),
        body: Center(
          child: HvlovFolderWidget(
            videoSelectedCallback: _launchVlc,
          ),
        ),
      ),
    );
  }
}
