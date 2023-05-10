import 'dart:convert';

class ExperimentVariant {
  String value;
  Map<String, dynamic>? payload;

  ExperimentVariant({required this.value, this.payload});

  factory ExperimentVariant.fromMap(Map<String, dynamic> map) {
    final payloadOnMap = map['payload'];

    return ExperimentVariant(
        value: map['value'], payload: payloadOnMap['value']);
  }

  String toJsonAsString() {
    final toEncode = {};

    toEncode['value'] = value;
    toEncode['payload'] = payload ?? {};

    return jsonEncode(toEncode);
  }
}
