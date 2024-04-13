import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:developer' as dev;

class CommonHttp {
  final String baseUrl;
  final String authToken;

  CommonHttp(this.baseUrl, this.authToken);

  Future<dynamic> get(String endpoint, Map<String, String> data) async {
    final response = await http.get(
      Uri.parse(endpoint).replace(queryParameters: data),
      headers: {
        "Content-Type": "application/json",
        "Access-Control-Allow-Origin": "*",
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<dynamic> post(String endpoint, Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse(endpoint),
      body: jsonEncode(data),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $authToken",
      },
    );

    if (response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      return response.body;
    }
  }
}
