import 'package:flutter/material.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';
import '../widgets/flashcard.dart';
import 'dialogue_screen.dart';
import 'quiz_screen.dart';

class LessonScreen extends StatefulWidget {
  final Lesson lesson;
  const LessonScreen({super.key, required this.lesson});

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  final _pageController = PageController();
  int _index = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _next() {
    final last = _index == widget.lesson.cards.length - 1;
    if (last) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => QuizScreen(lesson: widget.lesson)),
      );
      return;
    }
    _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
  }

  void _prev() {
    if (_index == 0) return;
    _pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
  }

  @override
  Widget build(BuildContext context) {
    final total = widget.lesson.cards.length;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.lesson.title),
        actions: [
          IconButton(
            tooltip: 'Dialogen',
            icon: const Icon(Icons.forum_outlined),
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => DialogueScreen(lesson: widget.lesson))),
          ),
          IconButton(
            tooltip: 'Oefeningen',
            icon: const Icon(Icons.quiz_outlined),
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => QuizScreen(lesson: widget.lesson))),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 8),
              Row(children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(999),
                    child: LinearProgressIndicator(value: (_index + 1) / total, minHeight: 8),
                  ),
                ),
                const SizedBox(width: 10),
                Text('${_index + 1}/$total', style: TextStyle(color: AppColors.softGrey, fontWeight: FontWeight.w700)),
              ]),
              const SizedBox(height: 8),
              Text('Tik op de kaart om te draaien · luister met man/vrouw-audio', style: TextStyle(color: AppColors.softGrey, fontWeight: FontWeight.w600, fontSize: 12), textAlign: TextAlign.center),
              const SizedBox(height: 18),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: total,
                  onPageChanged: (i) => setState(() => _index = i),
                  itemBuilder: (context, i) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Flashcard(card: widget.lesson.cards[i]),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => DialogueScreen(lesson: widget.lesson))),
                      icon: const Icon(Icons.forum_outlined),
                      label: Text('${widget.lesson.dialogues.length} dialogen'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => QuizScreen(lesson: widget.lesson))),
                      icon: const Icon(Icons.quiz_outlined),
                      label: Text('${widget.lesson.exercises.length} oefeningen'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  if (_index > 0)
                    Expanded(
                      child: OutlinedButton(onPressed: _prev, child: const Text('Vorige')),
                    ),
                  if (_index > 0) const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(onPressed: _next, child: Text(_index == total - 1 ? 'Naar oefeningen' : 'Volgende')),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
