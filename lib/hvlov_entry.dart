import 'package:freezed_annotation/freezed_annotation.dart';

part 'hvlov_entry.freezed.dart';

@freezed
class HvlovEntry with _$HvlovEntry {
  const factory HvlovEntry.video(String title, String url) = HvlovVideo;

  const factory HvlovEntry.folder(String title, String url) = HvlovFolder;

  const factory HvlovEntry.videoGroup(
      String title, Map<String, String> videoTags) = HvlovVideoGroup;
}
