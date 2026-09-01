import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';
import '../services/progress_service.dart';
import '../theme/app_theme.dart';

class _Question {
  final DarijaCard correct;
  final List<DarijaCard> options;
  _Question({required this.correct, required this.options});
}

class QuizScreen extends StatefulWidget {
  final Lesson lesson;
  const QuizScreen({super.key, required this.lesson});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late final List<_Question> _questions = _buildQuestions();
  int _index = 0;
  int _score = 0;
  int? _selected;
  bool _answered = false;
  bool _finished = false;

  List<_Question> _buildQuestions() {
    final rnd = Random();
    final cards = List<DarijaCard>.from(widget.lesson.cards)..shuffle(rnd);
    return cards.map((card) {
      final distractors = List<DarijaCard>.from(widget.lesson.cards)
        ..remove(card)
        ..shuffle(rnd);
      final options = [card, ...distractors.take(min(3, distractors.length))]
        ..shuffle(rnd);
      return _Question(correct: card, options: options);
    }).toList();
  }

  void _select(int i) {
    if (_answered) return;
    final correct = _questions[_index].options[i] == _questions[_index].correct;
    setState(() {
      _selected = i;
      _answered = true;
      if (correct) _score++;
    });
  }

  void _next() {
    if (_index == _questions.length - 1) {
      setState(() => _finished = true);
      context.read<ProgressService>().markLessonComplete(widget.lesson.id);
      return;
    }
    setState(() {
      _index++;
      _selected = null;
      _answered = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_finished) {
      return _ResultView(
        lesson: widget.lesson,
        score: _score,
        total: _questions.length,
      );
    }

    final q = _questions[_index];

    return Scaffold(
      appBar: AppBar(title: Text('Quiz · ${widget.lesson.title}')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(999),
                child: LinearProgressIndicator(
                  value: (_index + 1) / _questions.length,
                  minHeight: 8,
                ),
              ),
              const SizedBox(height: 28),
              Text(
                'Wat betekent dit in het Nederlands?',
                style: TextStyle(
                  color: AppColors.softGrey,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                q.correct.darijaLatin,
                style: const TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                q.correct.darijaArabic,
                style: TextStyle(fontSize: 18, color: AppColors.softGrey),
              ),
              const SizedBox(height: 32),
              ...List.generate(q.options.length, (i) {
                final option = q.options[i];
                final isCorrectOption = option == q.correct;
                Color? bg;
                Color border = Colors.transparent;
                if (_answered) {
                  if (isCorrectOption) {
                    bg = AppColors.teal.withOpacity(0.12);
                    border = AppColors.teal;
                  } else if (i == _selected) {
                    bg = AppColors.terracotta.withOpacity(0.12);
                    border = AppColors.terracotta;
                  }
                }
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () => _select(i),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 16),
                      decoration: BoxDecoration(
                        color: bg ?? Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: border, width: 1.5),
                        boxShadow: bg == null
                            ? [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.03),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ]
                            : null,
                      ),
                      child: Text(
                        option.dutch,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                );
              }),
              const Spacer(),
              if (_answered)
                ElevatedButton(
                  onPressed: _next,
                  child: Text(
                    _index == _questions.length - 1
                        ? 'Bekijk resultaat'
                        : 'Volgende vraag',
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ResultView extends StatelessWidget {
  final Lesson lesson;
  final int score;
  final int total;

  const _ResultView({
    required this.lesson,
    required this.score,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    final ratio = total == 0 ? 0.0 : score / total;
    final good = ratio >= 0.7;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(good ? '🎉' : '💪', style: const TextStyle(fontSize: 64)),
              const SizedBox(height: 16),
              Text(
                good ? 'Mabrouk! Goed gedaan!' : 'Mooi geprobeerd!',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Je scoorde $score van de $total in "${lesson.title}"',
                style: TextStyle(
                  fontSize: 15,
                  color: AppColors.softGrey,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () =>
                    Navigator.of(context).popUntil((r) => r.isFirst),
                child: const Text('Terug naar overzicht'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
