import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> updateData(Map<String, dynamic> data) async {
  final url =
      'https://example.com/api/endpoint'; // Replace with your server URL

  final headers = {'Content-Type': 'application/json'};
  final body = jsonEncode(data);
  await http.put(Uri.parse(url), headers: headers, body: body);
}
