class Condition {
  final String text;

  Condition({
    required this.text,
  });

  factory Condition.fromJson(Map<String, dynamic> json) {
    return Condition(
      text: json['text'],
    );
  }
}