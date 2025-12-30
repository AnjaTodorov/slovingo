import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:slovingo/providers/app_provider.dart';
import 'package:slovingo/models/quiz.dart';
import 'package:go_router/go_router.dart';

class QuizScreen extends StatefulWidget {
  final String levelId;

  const QuizScreen({super.key, required this.levelId});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0;
  final List<String> _userAnswers = [];
  List<Quiz> _quizzes = [];
  bool _isLoading = true;
  bool _showResult = false;
  int _score = 0;

  @override
  void initState() {
    super.initState();
    _loadQuizzes();
  }

  Future<void> _loadQuizzes() async {
    final provider = Provider.of<AppProvider>(context, listen: false);
    final quizzes = await provider.getQuizzesByLevel(widget.levelId);
    setState(() {
      _quizzes = quizzes;
      _isLoading = false;
    });
  }

  void _selectAnswer(String answer) {
    setState(() {
      _userAnswers.add(answer);
      if (_currentQuestionIndex < _quizzes.length - 1) {
        _currentQuestionIndex++;
      } else {
        _finishQuiz();
      }
    });
  }

  void _finishQuiz() {
    final provider = Provider.of<AppProvider>(context, listen: false);
    final score = provider.calculateQuizScore(_userAnswers, _quizzes);
    
    provider.completeLevel(widget.levelId, score);
    
    setState(() {
      _score = score;
      _showResult = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_quizzes.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Kviz'),
        ),
        body: const Center(
          child: Text('Ni vprašanj za ta nivo.'),
        ),
      );
    }

    if (_showResult) {
      return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  _score >= 70 ? Icons.emoji_events : Icons.error_outline,
                  size: 100,
                  color: _score >= 70 
                      ? Theme.of(context).colorScheme.tertiary 
                      : Theme.of(context).colorScheme.error,
                ),
                const SizedBox(height: 24),
                Text(
                  _score >= 70 ? 'Čestitamo! 🎉' : 'Poskusite znova',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  'Vaš rezultat: $_score%',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: _score >= 70 
                        ? Theme.of(context).colorScheme.primary 
                        : Theme.of(context).colorScheme.error,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _score >= 70
                      ? 'Odlično ste opravili kviz! Naslednji nivo je odklenjen.'
                      : 'Za napredovanje potrebujete vsaj 70%. Poskusite znova!',
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    onPressed: () {
                      context.pop();
                      context.pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      'Nazaj na nivoje',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                if (_score < 70) ...[
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: OutlinedButton(
                      onPressed: () {
                        setState(() {
                          _currentQuestionIndex = 0;
                          _userAnswers.clear();
                          _showResult = false;
                        });
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Text(
                        'Poskusi znova',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      );
    }

    final currentQuiz = _quizzes[_currentQuestionIndex];
    
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => context.pop(),
                        icon: const Icon(Icons.close),
                      ),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: LinearProgressIndicator(
                            value: (_currentQuestionIndex + 1) / _quizzes.length,
                            minHeight: 8,
                            backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        '${_currentQuestionIndex + 1}/${_quizzes.length}',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            currentQuiz.type == QuizType.multipleChoice
                                ? Icons.check_circle_outline
                                : currentQuiz.type == QuizType.fillBlank
                                    ? Icons.edit_outlined
                                    : Icons.translate,
                            size: 16,
                            color: Theme.of(context).colorScheme.onPrimaryContainer,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            currentQuiz.type == QuizType.multipleChoice
                                ? 'Izberi odgovor'
                                : currentQuiz.type == QuizType.fillBlank
                                    ? 'Dopolni stavek'
                                    : 'Prevedi',
                            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                              color: Theme.of(context).colorScheme.onPrimaryContainer,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    Text(
                      currentQuiz.question,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 32),
                    Expanded(
                      child: ListView(
                        children: currentQuiz.options.map((option) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: InkWell(
                              onTap: () => _selectAnswer(option),
                              borderRadius: BorderRadius.circular(16),
                              child: Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.surface,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
                                    width: 2,
                                  ),
                                ),
                                child: Text(
                                  option,
                                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
