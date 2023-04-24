class FetchInput {
  final String? userId;
  final String? deviceId;
  final Map<String, dynamic>? userProperties;

  FetchInput({this.userId, this.deviceId, this.userProperties});

  factory FetchInput.fromMap(Map<String, dynamic> map) {
    return FetchInput(
        userId: map['user_id'],
        deviceId: map['device_id'],
        userProperties: map['user_properies']);
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'device_id': deviceId,
      'context': {'user_properties': userProperties.toString()}.toString()
    };
  }
}
