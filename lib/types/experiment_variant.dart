class ExperimentVariant {
  String? value;
  Map<String, dynamic>? payload;

  ExperimentVariant({required this.value, this.payload});

  factory ExperimentVariant.fromMap(Map<String, dynamic> map) {
    return ExperimentVariant(value: map['value'], payload: map['payload']);
  }

  String toJsonAsString() {
    return {value: value, payload: payload}.toString();
  }
}
