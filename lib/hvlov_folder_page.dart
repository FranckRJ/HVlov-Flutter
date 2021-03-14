import 'package:flutter/material.dart';
import 'package:hvlov_flutter/hvlov_config_model.dart';
import 'package:process_run/cmd_run.dart';
import 'package:provider/provider.dart';

import 'hvlov_folder_model.dart';
import 'hvlov_folder_widget.dart';

class HvlovFolderPage extends StatelessWidget {
  const HvlovFolderPage({Key? key}) : super(key: key);

  Future _launchVlc(String baseUrl, String path) async {
    final cmd =
        ProcessCmd(r"C:\Program Files\VideoLAN\VLC\vlc.exe", [baseUrl + path]);
    await runCmd(cmd);
  }

  String _formatPathToPrettyPath(String path) {
    return path.replaceAll('_', ' ').replaceAll('/', ' / ');
  }

  @override
  Widget build(BuildContext context) {
    final String path =
        ModalRoute.of(context)?.settings.arguments as String? ?? "";

    return ChangeNotifierProxyProvider<HvlovConfigModel, HvlovFolderModel>(
      update: (context, value, previous) => previous!
        ..update(value)
        ..requestUpdateEntries(path),
      create: (context) => HvlovFolderModel(),
      builder: (context, _) => Scaffold(
        appBar: AppBar(
          title: Text("HVlov" +
              (path.isEmpty ? "" : " : ${_formatPathToPrettyPath(path)}")),
        ),
        body: Center(
          child: HvlovFolderWidget(
            videoSelectedCallback: (path) =>
                _launchVlc(context.read<HvlovConfigModel>().url, path),
          ),
        ),
      ),
    );
  }
}
