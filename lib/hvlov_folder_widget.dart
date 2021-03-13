import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

import 'hvlov_entry_widget.dart';
import 'hvlov_folder_model.dart';

class HvlovFolderWidget extends HookWidget {
  final void Function(String) videoSelectedCallback;

  const HvlovFolderWidget({Key? key, required this.videoSelectedCallback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scrollController = useScrollController();
    final hvlovEntries = context
        .watch<HvlovFolderModel>()
        .entries
        .map((entry) => HvlovEntryWidget(
            videoSelectedCallback: videoSelectedCallback, entry: entry))
        .toList();

    return Scrollbar(
      controller: scrollController,
      isAlwaysShown: true,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Spacer(flex: 2),
          Expanded(
            flex: 8,
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  ...hvlovEntries,
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}
