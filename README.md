# IBS Symptom Tracker

A simple Flutter proof-of-concept app to track IBS symptoms via a 6-question survey, persist your last responses locally, and get a basic dietary or wellness recommendation.

## Features

1. **Survey UI**
   - 6 questions:  
     - Abdominal Pain (0–10 slider)  
     - Bloating (0–10 slider)  
     - Stool Consistency (0–10 toggle buttons)  
     - Bowel Frequency (0–10 toggle buttons)  
     - Impact on Daily Life (0–10 toggle buttons)  
     - Nausea (0–10 toggle buttons)  
   - “Next”/“Previous” navigation  
   - Validates each question before progressing, with inline errors  
   - “Submit” on final page, disabled until all answered  
   - Brief loading spinner on submit  

2. **Data & Storage**
   - `SymptomSurveyResult` model (timestamp + responses)  
   - Persists latest result in `shared_preferences`  
   - On app start, loads and pre-fills the last survey  

3. **Recommendation Screen**
   - If Abdominal Pain > 5 → **Low FODMAP Diet** suggestion  
   - Otherwise → **General Wellness Tip**  
   - Title + description  

4. **UX Details**
   - Responsive layout for different screen sizes  
   - Visual feedback on selection and button states  

## Getting Started

### Prerequisites

- Flutter >=3.0.0
- Dart SDK compatible
- An IDE or editor with Flutter support (e.g. Android Studio, VS Code)

### Installation

```bash
git clone https://github.com/yourusername/ibs_symptom_tracker.git
cd ibs_symptom_tracker
flutter pub get
flutter run
