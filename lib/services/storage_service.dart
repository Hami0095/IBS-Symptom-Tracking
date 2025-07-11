import 'package:shared_preferences/shared_preferences.dart';
import '../models/symptom_survey_result.dart';

class StorageService {
  static const _key = 'survey_result';

  /// Save the latest [result] locally as JSON.
  static Future<void> saveResult(SymptomSurveyResult result) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, result.toJsonString());
  }

  /// Load the last saved result, or null if none.
  static Future<SymptomSurveyResult?> loadLastResult() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_key);
    return SymptomSurveyResult.fromJsonString(jsonString);
  }
}
