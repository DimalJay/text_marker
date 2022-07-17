library text_marker;

import 'package:text_marker/text_match/enum.dart';
import 'package:text_marker/text_match/model.dart';

class TextMarker {
  final String text;
  // All Match
  static final allmatch = RegExp(r'(\*)(.*?)(\*)|(_)(.*?)(_)');

  // Bold Match
  static final boldMatch = RegExp(r'(\*)(.*?)(\*)');

  // Italic Match
  static final italicMatch = RegExp(r'(_)(.*?)(_)');

  TextMarker(this.text);

  Map<int, TextModel> parse() {
    Map<int, TextModel> retVal = {};
    int index = 0;
    for (var tag in parseAll(text)) {
      if (isBold(tag)) {
        final model = TextModel(
          text: boldMatch.firstMatch(tag)!.group(2)!,
          type: TextType.bold,
        );
        retVal[index] = model;
      } else if (isItalic(tag)) {
        final model = TextModel(
          text: italicMatch.firstMatch(tag)!.group(2)!,
          type: TextType.italic,
        );
        retVal[index] = model;
      } else {
        final model = TextModel(
          text: tag,
          type: TextType.normal,
        );
        retVal[index] = model;
      }
      index++;
    }
    return retVal;
  }

  List<String> parseAll(String text) {
    return text
        .splitMapJoin(
          allmatch,
          onMatch: (m) => '#${m[0]}#',
          onNonMatch: (m) => m,
        )
        .split("#");
  }

  bool isBold(String text) => boldMatch.hasMatch(text);

  bool isItalic(String text) => italicMatch.hasMatch(text);
}
