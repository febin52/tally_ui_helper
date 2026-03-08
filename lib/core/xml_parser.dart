import 'package:xml/xml.dart';

class TallyXmlParser {
  /// Parses the Tally XML response and extracts items of [nodeName].
  static List<Map<String, String>> parseCollection(
      String xmlString, String nodeName) {
    final document = XmlDocument.parse(xmlString);
    final elements = document.findAllElements(nodeName);

    List<Map<String, String>> result = [];

    for (var element in elements) {
      Map<String, String> item = {};
      for (var child in element.children) {
        if (child is XmlElement) {
          item[child.name.local] = child.innerText.trim();
        }
      }
      result.add(item);
    }

    return result;
  }

  /// Checks if the response contains an error or failure message.
  static bool hasError(String xmlString) {
    return xmlString.contains('<LINEERROR>') || xmlString.contains('Errors:');
  }

  /// Extracts the error message.
  static String extractError(String xmlString) {
    try {
      final document = XmlDocument.parse(xmlString);
      final errors = document.findAllElements('LINEERROR');
      if (errors.isNotEmpty) {
        return errors.first.innerText;
      }
    } catch (e) {
      // Ignored
    }
    return 'Unknown Tally Error';
  }
}
