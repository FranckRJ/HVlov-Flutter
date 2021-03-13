import 'package:flutter/material.dart';

class VideoGroupSelectorDialog extends StatelessWidget {
  final void Function(String) tagSelectedCallback;
  final Map<String, String> videoTags;

  const VideoGroupSelectorDialog(
      {Key? key, required this.tagSelectedCallback, required this.videoTags})
      : super(key: key);

  String _mapTagToHumanReadableName(String tag) {
    switch (tag) {
      case "uhd":
        return "Ultra haute définition";
      case "hd":
        return "Haute définition";
      case "md":
        return "Définition normale";
      case "sd":
        return "Basse définition";
      case "usd":
        return "Ultra basse définition";
      default:
        return tag;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text("Sélectionner la version de la vidéo à regarder"),
      children: [
        for (final videoTag in videoTags.entries)
          SimpleDialogOption(
            onPressed: () {
              tagSelectedCallback(videoTag.value);
              Navigator.of(context).pop();
            },
            child: Text("${_mapTagToHumanReadableName(videoTag.key)}"),
          )
      ],
    );
  }
}
