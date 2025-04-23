import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ApiClient {
  final String baseUrl;
  final http.Client client;

  ApiClient({required this.baseUrl, http.Client? client})
      : client = client ?? http.Client();

  Future<dynamic> get(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    return client
        .get(Uri.http(baseUrl, endpoint, queryParameters), headers: headers)
        .timeout(const Duration(seconds: 7), onTimeout: () {
      if (kDebugMode) print('Timeout!');
      return http.Response(
        jsonEncode({
          "error": "Timeout",
          "message":
              "The HTTP GET request to the specified path ($endpoint) timed out."
        }),
        408,
      );
    });
  }

  Future<dynamic> post(
    String endpoint, {
    Map<String, String>? headers,
    required Map<String, dynamic> body,
  }) async {
    return client
        .post(Uri.parse('$baseUrl$endpoint'), headers: headers, body: body)
        .timeout(
      const Duration(seconds: 7),
      onTimeout: () {
        if (kDebugMode) print('Timeout!');
        return http.Response(
          jsonEncode({
            "error": "Timeout",
            "message":
                "The HTTP GET request to the specified path ($endpoint) timed out."
          }),
          408,
        );
      },
    );
  }
}
