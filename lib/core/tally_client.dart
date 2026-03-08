import 'dart:convert';
import 'package:http/http.dart' as http;
import 'xml_builder.dart';
import 'xml_parser.dart';

/// The primary client for communicating with a Tally ERP 9 or Tally Prime server.
class TallyClient {
  /// The Tally server address (e.g., http://192.168.1.10:9000).
  final String host;

  /// Timeout duration for the HTTP requests in seconds.
  final int timeoutSeconds;

  /// Creates a [TallyClient] pointing to the specified [host].
  TallyClient({
    required this.host,
    this.timeoutSeconds = 30,
  });

  /// Sends a raw XML request to the Tally ERP Server.
  Future<String> sendRequest(String xmlPayload) async {
    try {
      final response = await http
          .post(
            Uri.parse(host),
            headers: {'Content-Type': 'text/xml;charset=utf-8'},
            body: utf8.encode(xmlPayload),
          )
          .timeout(Duration(seconds: timeoutSeconds));

      if (response.statusCode == 200) {
        if (TallyXmlParser.hasError(response.body)) {
          throw Exception(TallyXmlParser.extractError(response.body));
        }
        return response.body;
      } else {
        throw Exception('Server returned status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Tally Connection Failed: $e');
    }
  }

  /// Example function: Get Companies
  Future<List<Map<String, String>>> getCompanies() async {
    final req = TallyXmlBuilder.buildCollectionRequest(
        collectionName: 'System',
        fetchList: ['Name']); // Placeholder logic for getting companies
    final res = await sendRequest(req);
    return TallyXmlParser.parseCollection(res, 'COMPANY');
  }

  /// Generic collection fetcher.
  Future<List<Map<String, String>>> fetchCollection({
    required String collectionName,
    List<String>? fetchList,
  }) async {
    final req = TallyXmlBuilder.buildCollectionRequest(
      collectionName: collectionName,
      fetchList: fetchList,
    );
    final res = await sendRequest(req);
    return TallyXmlParser.parseCollection(res, collectionName.toUpperCase());
  }
}
