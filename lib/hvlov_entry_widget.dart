import 'package:flutter/material.dart';

import 'hvlov_entry.dart';
import 'video_group_selector_dialog.dart';

class HvlovEntryWidget extends StatelessWidget {
  final HvlovEntry entry;
  final void Function(String) videoSelectedCallback;

  const HvlovEntryWidget(
      {Key? key, required this.videoSelectedCallback, required this.entry})
      : super(key: key);

  void _entryClicked(BuildContext context) {
    entry.when(
      video: (_, url) => videoSelectedCallback(url),
      folder: (_, url) => Navigator.of(context).pushNamed("/", arguments: url),
      videoGroup: (_, videoTags) => showDialog(
        context: context,
        builder: (_) => VideoGroupSelectorDialog(
          tagSelectedCallback: videoSelectedCallback,
          videoTags: videoTags,
        ),
      ),
    );
  }

  IconData _mapEntryTagToIcon() {
    return entry.when(
      video: (_, __) => Icons.movie,
      folder: (_, __) => Icons.folder,
      videoGroup: (_, __) => Icons.auto_awesome_motion,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        margin: EdgeInsets.all(4),
        child: InkWell(
          onTap: () => _entryClicked(context),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                Icon(_mapEntryTagToIcon()),
                SizedBox(width: 4),
                Text(entry.title),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
