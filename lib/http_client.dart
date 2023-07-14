import 'dart:convert';

import 'package:experiment_sdk_flutter/types/experiment_fetch_item.dart';
import 'package:http/http.dart' as http;

abstract class QueryParameters {
  Map<String, dynamic> toJson();
}

// HTTP Client Class
class HttpClient {
  final String _apiKey;
  final String _baseUri = 'api.lab.amplitude.com';
  final bool _shouldRetry;

  HttpClient({required apiKey, bool? shouldRetry})
      : _apiKey = apiKey,
        _shouldRetry = shouldRetry ?? true;

  bool _isRetry = false;
  Map<String, ExperimentFetchItem> fetchResult = {};

  /// Get function invoked on HTTP requests
  Future<void> get(QueryParameters queryParameters) async {
    final uri = Uri.https(_baseUri, '/v1/vardata', queryParameters.toJson());
    final response = await http.get(uri,
        headers: {'Authorization': 'Api-Key $_apiKey'});

    if (response.statusCode != 200) {
      String data = response.body;

      if (!_isRetry && _shouldRetry) {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception({
          'message': 'Failed to fetch through SDK!',
          'status': response.statusCode,
          'trace': data
        });
      }

      _isRetry = true;
      get(queryParameters);
    }

    Map<String, dynamic> data =
        jsonDecode(const Utf8Decoder().convert(response.bodyBytes));

    data.forEach((key, value) {
      fetchResult[key] = ExperimentFetchItem.fromMap(value);
    });

    _isRetry = false;
  }
}
