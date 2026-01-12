import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:slovingo/models/lesson_task.dart';
import 'package:slovingo/providers/app_provider.dart';

class QuizScreen extends StatefulWidget {
  final String levelId;
  const QuizScreen({super.key, required this.levelId});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentIndex = 0;
  int _correct = 0;
  int _score = 0;
  bool _isLoading = true;
  bool _showResult = false;
  bool _answered = false;
  bool _showExplanation = false;
  String _feedback = '';
  final TextEditingController _writeController = TextEditingController();

  List<LessonTask> _tasks = [];

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    final provider = Provider.of<AppProvider>(context, listen: false);
    final tasks = await provider.getTasksByLevel(widget.levelId);
    setState(() {
      _tasks = tasks;
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _writeController.dispose();
    super.dispose();
  }

  void _selectAnswer(String answer) {
    if (_answered) return;
    final current = _tasks[_currentIndex];
    final isCorrect = answer.trim().toLowerCase() ==
        current.correctAnswer.trim().toLowerCase();
    setState(() {
      _answered = true;
      _showExplanation = false;
      _feedback = isCorrect ? 'Correct!' : 'Incorrect.';
      if (isCorrect) _correct++;
      _score = ((_correct / _tasks.length) * 100).round();
    });
  }

  void _next() {
    if (_currentIndex < _tasks.length - 1) {
      setState(() {
        _currentIndex++;
        _answered = false;
        _showExplanation = false;
        _feedback = '';
        _writeController.clear();
      });
    } else {
      _finish();
    }
  }

  void _finish() {
    final provider = Provider.of<AppProvider>(context, listen: false);
    final finalScore = ((_correct / _tasks.length) * 100).round();
    provider.completeLevel(widget.levelId, finalScore);
    setState(() {
      _score = finalScore;
      _showResult = true;
    });
  }

  Widget _buildOptions(LessonTask task, ThemeData theme) {
    if (task.kind == LessonTaskKind.writeIn) {
      return Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
                width: 1,
              ),
            ),
            child: TextField(
              controller: _writeController,
              enabled: !_answered,
              style: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                hintText: 'Type your answer here...',
                hintStyle: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                filled: false,
              ),
              textInputAction: TextInputAction.done,
              onSubmitted: (_answered ? null : (value) => _selectAnswer(value)),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 54,
            child: FilledButton(
              onPressed: _answered ? null : () => _selectAnswer(_writeController.text),
              style: FilledButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 0,
              ),
              child: Text(
                'Submit Answer',
                style: theme.textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      );
    }

    return Column(
      children: task.options.map((option) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: InkWell(
            onTap: _answered ? null : () => _selectAnswer(option),
            borderRadius: BorderRadius.circular(16),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
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
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_tasks.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Quiz'),
        ),
        body: const Center(
          child: Text('No questions for this level.'),
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
                      ? theme.colorScheme.tertiary
                      : theme.colorScheme.error,
                ),
                const SizedBox(height: 24),
                Text(
                  _score >= 70 ? 'Great job!' : 'Try again',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  'Your score: $_score%',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: _score >= 70
                        ? theme.colorScheme.primary
                        : theme.colorScheme.error,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _score >= 70
                      ? 'You passed! Next level unlocked.'
                      : 'You need at least 70% to proceed. Try again!',
                  style: theme.textTheme.bodyLarge,
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
                      backgroundColor: theme.colorScheme.primary,
                      foregroundColor: theme.colorScheme.onPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      'Back to levels',
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: theme.colorScheme.onPrimary,
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
                          _currentIndex = 0;
                          _correct = 0;
                          _score = 0;
                          _answered = false;
                          _showExplanation = false;
                          _feedback = '';
                          _writeController.clear();
                          _showResult = false;
                        });
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                          color: theme.colorScheme.primary,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Text(
                        'Try again',
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: theme.colorScheme.primary,
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

    final currentTask = _tasks[_currentIndex];

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
                            value: (_currentIndex + 1) / _tasks.length,
                            minHeight: 8,
                            backgroundColor: theme.colorScheme.surfaceContainerHighest,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        '${_currentIndex + 1}/${_tasks.length}',
                        style: theme.textTheme.bodyLarge?.copyWith(
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
                    Text(
                      currentTask.question,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 32),
                    Expanded(
                      child: ListView(
                        padding: EdgeInsets.zero,
                        children: [
                          _buildOptions(currentTask, theme),
                          const SizedBox(height: 120),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _answered
          ? Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _feedback == 'Correct!'
                    ? theme.colorScheme.primary
                    : theme.colorScheme.error,
              ),
              child: SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _feedback,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: _feedback == 'Correct!'
                            ? theme.colorScheme.onPrimary
                            : theme.colorScheme.onError,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    if (_feedback != 'Correct!') ...[
                      const SizedBox(height: 6),
                      TextButton(
                        onPressed: () {
                          setState(() => _showExplanation = !_showExplanation);
                        },
                        child: Text(
                          _showExplanation ? 'Hide explanation' : 'Show explanation',
                          style: theme.textTheme.labelLarge?.copyWith(
                            color: _feedback == 'Correct!'
                                ? theme.colorScheme.onPrimary
                                : theme.colorScheme.onError,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      if (_showExplanation)
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            currentTask.explanation,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: _feedback == 'Correct!'
                                  ? theme.colorScheme.onPrimary
                                  : theme.colorScheme.onError,
                            ),
                          ),
                        ),
                    ],
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.colorScheme.onPrimary,
                          foregroundColor: theme.colorScheme.primary,
                        ),
                        onPressed: _next,
                        child: Text(
                          _currentIndex == _tasks.length - 1 ? 'Finish' : 'Next',
                          style: theme.textTheme.labelLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : null,
    );
  }
}
