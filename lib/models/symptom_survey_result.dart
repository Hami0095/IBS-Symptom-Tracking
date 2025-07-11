import 'dart:convert';

class SymptomSurveyResult {
  final DateTime timestamp;
  final Map<String, int> responses;

  SymptomSurveyResult({required this.timestamp, required this.responses});

  Map<String, dynamic> toJson() => {
    'timestamp': timestamp.toIso8601String(),
    'responses': responses,
  };

  factory SymptomSurveyResult.fromJson(Map<String, dynamic> json) {
    final raw = json['responses'] as Map<String, dynamic>;
    return SymptomSurveyResult(
      timestamp: DateTime.parse(json['timestamp'] as String),
      responses: raw.map((k, v) => MapEntry(k, v as int)),
    );
  }

  static SymptomSurveyResult? fromJsonString(String? jsonString) {
    if (jsonString == null) return null;
    final Map<String, dynamic> data = json.decode(jsonString);
    return SymptomSurveyResult.fromJson(data);
  }

  String toJsonString() => json.encode(toJson());
}
