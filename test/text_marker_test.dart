import 'package:flutter_test/flutter_test.dart';
import 'package:text_marker/text_marker.dart';

void main() {
  group("Text Marker Test", () {
    String text = "my *name* is *Jhone*. im 10 _years old_";
    final testMatch = TextMarker(text);
    test('Bold Validation', () {
      expect(testMatch.isBold("My *name*"), true);
      expect(testMatch.isBold("My _name_"), false);
      expect(testMatch.isBold("*_My_ name*"), true);
    });
    test('Italic Validation', () {
      expect(testMatch.isItalic("My *name*"), false);
      expect(testMatch.isItalic("My _name_"), true);
      expect(testMatch.isItalic("*_My_ name*"), true);
    });

    test("Parse All Test", () {
      expect(testMatch.parseAll(text).join(), text);
    });

    test("Parse Body test", () {
      expect(testMatch.parse().isNotEmpty, true);
    });
  });
}
