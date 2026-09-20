import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';
import '../services/progress_service.dart';
import '../theme/app_theme.dart';

class QuizScreen extends StatefulWidget {
  final Lesson lesson;
  const QuizScreen({super.key, required this.lesson});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _index = 0;
  int _score = 0;
  String? _selected;
  bool _answered = false;
  bool _finished = false;

  void _select(String option) {
    if (_answered) return;
    final ex = widget.lesson.exercises[_index];
    setState(() {
      _selected = option;
      _answered = true;
      if (option == ex.answer) _score++;
    });
  }

  void _reveal() {
    if (_answered) return;
    setState(() => _answered = true);
  }

  void _next() {
    if (_index == widget.lesson.exercises.length - 1) {
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
      return _ResultView(lesson: widget.lesson, score: _score, total: widget.lesson.exercises.length);
    }
    final ex = widget.lesson.exercises[_index];
    return Scaffold(
      appBar: AppBar(title: Text('Oefenen · ${widget.lesson.title}')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            ClipRRect(borderRadius: BorderRadius.circular(999), child: LinearProgressIndicator(value: (_index + 1) / widget.lesson.exercises.length, minHeight: 8)),
            const SizedBox(height: 26),
            Text(_instruction(ex.type), style: TextStyle(color: AppColors.softGrey, fontWeight: FontWeight.w600, fontSize: 14)),
            const SizedBox(height: 10),
            Text(ex.prompt, style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w800)),
            if (ex.promptArabic != null) ...[
              const SizedBox(height: 4),
              Text(ex.promptArabic!, textDirection: TextDirection.rtl, style: TextStyle(fontSize: 20, color: AppColors.softGrey)),
            ],
            const SizedBox(height: 26),
            if (ex.type == ExerciseType.multipleChoice)
              ...ex.options.map((option) {
                final correct = option == ex.answer;
                Color? bg;
                Color border = Colors.transparent;
                if (_answered) {
                  if (correct) {
                    bg = AppColors.teal.withOpacity(.12);
                    border = AppColors.teal;
                  } else if (_selected == option) {
                    bg = AppColors.terracotta.withOpacity(.12);
                    border = AppColors.terracotta;
                  }
                }
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () => _select(option),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                      decoration: BoxDecoration(color: bg ?? Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: border, width: 1.5)),
                      child: Text(option, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                    ),
                  ),
                );
              })
            else ...[
              if (!_answered)
                ElevatedButton.icon(onPressed: _reveal, icon: const Icon(Icons.visibility_outlined), label: const Text('Toon antwoord')),
              if (_answered)
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(color: AppColors.teal.withOpacity(.1), borderRadius: BorderRadius.circular(18), border: Border.all(color: AppColors.teal.withOpacity(.35))),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    const Text('Antwoord', style: TextStyle(fontWeight: FontWeight.w800, color: AppColors.teal)),
                    const SizedBox(height: 6),
                    Text(ex.answer, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
                    if (ex.answerArabic != null) Text(ex.answerArabic!, textDirection: TextDirection.rtl, style: const TextStyle(fontSize: 20)),
                  ]),
                ),
            ],
            const Spacer(),
            if (_answered) ElevatedButton(onPressed: _next, child: Text(_index == widget.lesson.exercises.length - 1 ? 'Bekijk resultaat' : 'Volgende oefening')),
          ]),
        ),
      ),
    );
  }

  String _instruction(ExerciseType type) {
    switch (type) {
      case ExerciseType.multipleChoice:
        return 'Wat betekent dit in het Nederlands?';
      case ExerciseType.translateToDarija:
        return 'Vertaal dit naar Darija.';
      case ExerciseType.translateToDutch:
        return 'Vertaal dit naar het Nederlands.';
    }
  }
}

class _ResultView extends StatelessWidget {
  final Lesson lesson;
  final int score;
  final int total;
  const _ResultView({required this.lesson, required this.score, required this.total});

  @override
  Widget build(BuildContext context) {
    final ratio = total == 0 ? 0.0 : score / total;
    final good = ratio >= 0.6;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(good ? '🎉' : '💪', style: const TextStyle(fontSize: 64)),
            const SizedBox(height: 16),
            Text(good ? 'Mabrouk! Goed gedaan!' : 'Mooi geoefend!', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800), textAlign: TextAlign.center),
            const SizedBox(height: 8),
            Text('Meerkeuzescore: $score · ${lesson.exercises.length} oefeningen afgerond', style: TextStyle(fontSize: 15, color: AppColors.softGrey, fontWeight: FontWeight.w500), textAlign: TextAlign.center),
            const SizedBox(height: 32),
            ElevatedButton(onPressed: () => Navigator.of(context).popUntil((r) => r.isFirst), child: const Text('Terug naar overzicht')),
          ]),
        ),
      ),
    );
  }
}
