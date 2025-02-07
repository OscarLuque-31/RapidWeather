/// Clase condition que contiene la condición del clima
class Condition {
  final String text;

  Condition({
    required this.text,
  });

  // Método que transforma el Json de la API a el objeto Condition y lo retorna
  factory Condition.fromJson(Map<String, dynamic> json) {
    return Condition(
      text: json['text'],
    );
  }
}