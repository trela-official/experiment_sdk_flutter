import 'package:experiment_sdk_flutter/http_client.dart';

class ExperimentFetchInput extends QueryParameters {
  final String? userId;
  final String? deviceId;
  final Map<String, dynamic>? userProperties;

  ExperimentFetchInput({this.userId, this.deviceId, this.userProperties});

  factory ExperimentFetchInput.fromMap(Map<String, dynamic> map) {
    return ExperimentFetchInput(
        userId: map['user_id'],
        deviceId: map['device_id'],
        userProperties: map['user_properies']);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'device_id': deviceId,
      'context': {'user_properties': userProperties.toString()}.toString()
    };
  }
}
