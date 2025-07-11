// import 'package:flutter/material.dart';
// import '../models/symptom_survey_result.dart';
// import '../services/storage_service.dart';
// import 'recommendation_screen.dart';

// class SurveyScreen extends StatefulWidget {
//   const SurveyScreen({Key? key}) : super(key: key);

//   @override
//   State<SurveyScreen> createState() => _SurveyScreenState();
// }

// class Question {
//   final String key;
//   final String label;
//   final bool isSlider;
//   Question({required this.key, required this.label, this.isSlider = true});
// }

// class _SurveyScreenState extends State<SurveyScreen> {
//   final List<Question> _questions = [
//     Question(key: 'abdominalPain', label: 'Abdominal Pain', isSlider: true),
//     Question(key: 'bloating', label: 'Bloating', isSlider: true),
//     Question(
//       key: 'stoolConsistency',
//       label: 'Stool Consistency',
//       isSlider: false,
//     ),
//     Question(key: 'bowelFrequency', label: 'Bowel Frequency', isSlider: false),
//     Question(
//       key: 'impactDailyLife',
//       label: 'Impact on Daily Life',
//       isSlider: false,
//     ),
//     Question(key: 'nausea', label: 'Nausea', isSlider: false),
//   ];

//   int _currentIndex = 0;
//   final Map<String, int?> _responses = {};
//   bool _showError = false;
//   bool _isLoading = false;

//   @override
//   void initState() {
//     super.initState();
//     _loadPrevious();
//   }

//   Future<void> _loadPrevious() async {
//     final last = await StorageService.loadLastResult();
//     if (last != null) {
//       setState(() {
//         for (var q in _questions) {
//           _responses[q.key] = last.responses[q.key];
//         }
//       });
//     }
//   }

//   void _onNext() {
//     final key = _questions[_currentIndex].key;
//     if (_responses[key] == null) {
//       setState(() => _showError = true);
//       return;
//     }
//     setState(() {
//       _currentIndex++;
//       _showError = false;
//     });
//   }

//   void _onPrevious() {
//     setState(() {
//       _currentIndex--;
//       _showError = false;
//     });
//   }

//   Future<void> _onSubmit() async {
//     // Check any unanswered
//     final firstNull = _questions.indexWhere((q) => _responses[q.key] == null);
//     if (firstNull != -1) {
//       setState(() {
//         _currentIndex = firstNull;
//         _showError = true;
//       });
//       return;
//     }

//     setState(() => _isLoading = true);
//     final result = SymptomSurveyResult(
//       timestamp: DateTime.now(),
//       responses: _responses.map((k, v) => MapEntry(k, v!)),
//     );
//     await StorageService.saveResult(result);
//     if (!mounted) return;
//     Navigator.of(context).pushReplacement(
//       MaterialPageRoute(builder: (_) => RecommendationScreen(result: result)),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final question = _questions[_currentIndex];
//     final resp = _responses[question.key];
//     return Scaffold(
//       appBar: AppBar(title: const Text('IBS Symptom Tracker')),
//       body: LayoutBuilder(
//         builder: (ctx, bc) => Padding(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             children: [
//               Text(
//                 question.label,
//                 style: Theme.of(context).textTheme.headlineMedium,
//               ),
//               const SizedBox(height: 24),
//               if (question.isSlider)
//                 Column(
//                   children: [
//                     Slider(
//                       value: (resp ?? 0).toDouble(),
//                       min: 0,
//                       max: 10,
//                       divisions: 10,
//                       label: (resp ?? 0).toString(),
//                       onChanged: (v) {
//                         setState(() {
//                           _responses[question.key] = v.toInt();
//                         });
//                       },
//                     ),
//                     Text('Selected: ${resp ?? 0}'),
//                   ],
//                 )
//               else
//                 SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: ToggleButtons(
//                     isSelected: List.generate(11, (i) => resp == i),
//                     onPressed: (i) {
//                       setState(() {
//                         _responses[question.key] = i;
//                       });
//                     },
//                     children: List.generate(
//                       11,
//                       (i) => Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 12),
//                         child: Text(i.toString()),
//                       ),
//                     ),
//                   ),
//                 ),
//               if (_showError && resp == null)
//                 Padding(
//                   padding: const EdgeInsets.only(top: 12),
//                   child: Text(
//                     'Please answer this question before continuing.',
//                     style: TextStyle(color: Colors.red[700], fontSize: 16),
//                   ),
//                 ),
//               const Spacer(),
//               if (_isLoading)
//                 const CircularProgressIndicator()
//               else
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     ElevatedButton(
//                       onPressed: _currentIndex == 0 ? null : _onPrevious,
//                       child: const Text('Previous'),
//                     ),
//                     if (_currentIndex < _questions.length - 1)
//                       ElevatedButton(
//                         onPressed: _onNext,
//                         child: const Text('Next'),
//                       )
//                     else
//                       ElevatedButton(
//                         onPressed: _onSubmit,
//                         child: const Text('Submit'),
//                       ),
//                   ],
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import '../models/symptom_survey_result.dart';
import '../services/storage_service.dart';
import 'recommendation_screen.dart';

class SurveyScreen extends StatefulWidget {
  const SurveyScreen({Key? key}) : super(key: key);

  @override
  State<SurveyScreen> createState() => _SurveyScreenState();
}

class Question {
  final String key;
  final String label;
  final bool isSlider;
  Question({required this.key, required this.label, this.isSlider = true});
}

class _SurveyScreenState extends State<SurveyScreen> {
  final PageController _pageController = PageController();
  final List<Question> _questions = [
    Question(key: 'abdominalPain', label: 'Abdominal Pain', isSlider: true),
    Question(key: 'bloating', label: 'Bloating', isSlider: true),
    Question(
      key: 'stoolConsistency',
      label: 'Stool Consistency',
      isSlider: false,
    ),
    Question(key: 'bowelFrequency', label: 'Bowel Frequency', isSlider: false),
    Question(
      key: 'impactDailyLife',
      label: 'Impact on Daily Life',
      isSlider: false,
    ),
    Question(key: 'nausea', label: 'Nausea', isSlider: false),
  ];

  int _currentIndex = 0;
  final Map<String, int?> _responses = {};
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadPrevious();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _loadPrevious() async {
    final last = await StorageService.loadLastResult();
    if (last != null) {
      setState(() {
        for (var q in _questions) {
          _responses[q.key] = last.responses[q.key];
        }
      });
    }
  }

  bool _questionAnswered(int index) {
    final q = _questions[index];
    if (q.isSlider) return true; // slider always has a value
    return _responses[q.key] != null;
  }

  void _onPageChanged(int idx) {
    setState(() => _currentIndex = idx);
  }

  void _nextPage() {
    if (!_questionAnswered(_currentIndex)) return;
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _previousPage() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Future<void> _submit() async {
    // ensure all answered
    final firstEmpty = _questions.indexWhere(
      (q) => !_questionAnswered(_questions.indexOf(q)),
    );
    if (firstEmpty != -1) {
      _pageController.jumpToPage(firstEmpty);
      return;
    }

    setState(() => _isLoading = true);
    final result = SymptomSurveyResult(
      timestamp: DateTime.now(),
      responses: _responses.map((k, v) => MapEntry(k, v!)),
    );
    await StorageService.saveResult(result);
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => RecommendationScreen(result: result)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('IBS Symptom Tracker'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                // --- Progress bar & indicator ---
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: LinearProgressIndicator(
                    value: (_currentIndex + 1) / _questions.length,
                    minHeight: 6,
                    color: Colors.teal,
                    backgroundColor: Colors.grey[300],
                  ),
                ),
                Text(
                  'Question ${_currentIndex + 1} of ${_questions.length}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,),  
                ),
                const SizedBox(height: 12),

                // --- PageView for questions ---
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: _questions.length,
                    onPageChanged: _onPageChanged,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (ctx, idx) {
                      final q = _questions[idx];
                      final resp = _responses[q.key];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              q.label,
                              style: Theme.of(context).textTheme.headlineSmall,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 24),
                            if (q.isSlider)
                              Column(
                                children: [
                                  Slider(
                                    value: (resp ?? 0).toDouble(),
                                    min: 0,
                                    max: 10,
                                    divisions: 10,
                                    label: '${resp ?? 0}',
                                    activeColor: Colors.teal,
                                    inactiveColor: Colors.grey[300],
                                    onChanged: (v) {
                                      setState(
                                        () => _responses[q.key] = v.toInt(),
                                      );
                                    },
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    '${resp ?? 0}',
                                    style: const TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              )
                            else
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: List.generate(11, (i) {
                                  final selected = resp == i;
                                  return ChoiceChip(
                                    label: Text(i.toString()),
                                    selected: selected,
                                    color: MaterialStateColor.resolveWith(
                                      (states) => selected
                                          ? Colors.teal.withOpacity(0.8)
                                          : Colors.grey[300]!,
                                    ),
                                    // selectedColor: Colors.teal,
                                    onSelected: (_) {
                                      setState(() => _responses[q.key] = i);
                                    },
                                  );
                                }),
                              ),
                            if (!_questionAnswered(idx))
                              Padding(
                                padding: const EdgeInsets.only(top: 16),
                                child: Text(
                                  'Please select a rating to continue',
                                  style: TextStyle(
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                // --- Navigation buttons ---
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: _currentIndex == 0 ? null : _previousPage,
                          child: const Text('Previous'),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _questionAnswered(_currentIndex)
                              ? (_currentIndex == _questions.length - 1
                                    ? _submit
                                    : _nextPage)
                              : null,
                          child: Text(
                            _currentIndex == _questions.length - 1
                                ? 'Submit'
                                : 'Next',
                                style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold)
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // --- Loading overlay ---
          if (_isLoading)
            Container(
              color: Colors.black45,
              child: const Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }
}
