library experiment_sdk_flutter;

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:experiment_sdk_flutter/models/experiment_fetch_input.dart';
import 'package:experiment_sdk_flutter/models/experiment_fetch_item.dart';
import 'package:http/http.dart' as http;

/// A Calculator.
class AmplitudeExperiment {
  final String apiKey;

  final _baseUri = "api.lab.amplitude.com";
  final Map<String, FetchItem> _fetchResult = {};

  /// Initialize SDK
  AmplitudeExperiment({required this.apiKey});

  Future<void> fetch(
      {String? userId,
      String? deviceId,
      Map<String, dynamic>? userProperties}) async {
    final input = FetchInput(
        userId: userId, deviceId: deviceId, userProperties: userProperties);

    final uri = Uri.https(_baseUri, '/v1/vardata', input.toJson());

    final response = await http.get(uri,
        headers: {HttpHeaders.authorizationHeader: 'Api-Key $apiKey'});

    if (response.statusCode == 200) {
      Map<String, dynamic> data =
          jsonDecode(const Utf8Decoder().convert(response.bodyBytes));

      data.forEach((key, value) {
        _fetchResult[key] = FetchItem.fromMap(value);
      });
    } else {
      String data = response.body;

      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception({
        'message': 'Failed to fetch through SDK!',
        'status': response.statusCode,
        'trace': data
      });
    }
  }

  FetchItem? variant(String flagKey) {
    return _fetchResult[flagKey];
  }
}
