import 'package:flutter/material.dart';
import '../models/symptom_survey_result.dart';
import 'survey_screen.dart';

class RecommendationScreen extends StatelessWidget {
  final SymptomSurveyResult result;

  const RecommendationScreen({Key? key, required this.result})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pain = result.responses['abdominalPain'] ?? 0;
    final bool highPain = pain > 5;

    // Define your recommendation content
    final String title = highPain ? 'Low FODMAP Diet' : 'General Wellness Tip';
    final String description = highPain
        ? 'Consider a low FODMAP diet to reduce fermentable carbs that can trigger IBS symptoms. '
              'Focus on veggies like carrots, spinach, and lean proteins such as chicken or fish. '
              'Also keep a food diary to track personal triggers.'
        : 'Maintain a balanced diet, stay hydrated, and manage stress through mindfulness or light exercise. '
              'Regular sleep patterns and gentle yoga can also help ease IBS discomfort.';

    // Choose an icon based on recommendation
    final IconData iconData = highPain
        ? Icons.restaurant_menu
        : Icons.self_improvement;

    return Scaffold(
      backgroundColor: Colors.teal[50],
      appBar: AppBar(
        title: Text('Your Recommendation', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
        
        backgroundColor: Colors.teal,
        centerTitle: true,
        elevation: 2,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            children: [
              // Icon header
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.teal.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(iconData, size: 48, color: Colors.teal[700]),
              ),
              const SizedBox(height: 24),

              // Card with recommendation
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(
                              color: Colors.teal[800],
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        description,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[700],
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),

              // Retake survey button
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  icon: const Icon(Icons.refresh),
                  label: const Text('Retake Survey'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.teal[700],
                    side: BorderSide(color: Colors.teal[300]!),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => const SurveyScreen()),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


