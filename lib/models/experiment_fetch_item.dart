class FetchItem {
  final String key;
  final Map<String, dynamic>? payload;

  FetchItem({required this.key, this.payload});

  factory FetchItem.fromMap(Map<String, dynamic> map) {
    return FetchItem(key: map['key'], payload: map['payload']);
  }
}
