import 'package:flutter/material.dart';
import '../models/symptom_survey_result.dart';

class RecommendationScreen extends StatelessWidget {
  final SymptomSurveyResult result;

  const RecommendationScreen({Key? key, required this.result})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pain = result.responses['abdominalPain'] ?? 0;
    final bool highPain = pain > 5;
    final title = highPain ? 'Low FODMAP Diet' : 'General Wellness Tip';
    final description = highPain
        ? 'Consider a low FODMAP diet to reduce fermentable carbs that can trigger IBS symptoms. Focus on vegetables like carrots, spinach, and proteins like chicken or fish.'
        : 'Maintain a balanced diet, stay hydrated, and manage stress through mindfulness or light exercise. These habits often help ease IBS discomfort.';

    return Scaffold(
      appBar: AppBar(title: const Text('Recommendation')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.headlineLarge),
                const SizedBox(height: 16),
                Text(description, style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
