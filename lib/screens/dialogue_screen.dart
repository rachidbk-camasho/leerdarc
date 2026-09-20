import 'package:flutter/material.dart';
import '../models/models.dart';
import '../services/audio_service.dart';
import '../theme/app_theme.dart';

class DialogueScreen extends StatelessWidget {
  final Lesson lesson;
  const DialogueScreen({super.key, required this.lesson});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dialogen · ${lesson.title}')),
      body: ListView.separated(
        padding: const EdgeInsets.fromLTRB(18, 12, 18, 32),
        itemCount: lesson.dialogues.length,
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final dialogue = lesson.dialogues[index];
          return Card(
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('${index + 1}. ${dialogue.title}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                const SizedBox(height: 12),
                ...dialogue.turns.map((turn) => _Turn(turn: turn)),
              ]),
            ),
          );
        },
      ),
    );
  }
}

class _Turn extends StatelessWidget {
  final DialogueTurn turn;
  const _Turn({required this.turn});

  @override
  Widget build(BuildContext context) {
    final isA = turn.speaker == 'A';
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isA ? AppColors.terracotta.withOpacity(.08) : AppColors.teal.withOpacity(.08),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('${turn.speaker} · ${turn.darijaLatin}', style: const TextStyle(fontWeight: FontWeight.w800)),
        const SizedBox(height: 3),
        Text(turn.darijaArabic, textDirection: TextDirection.rtl, style: const TextStyle(fontSize: 18)),
        const SizedBox(height: 4),
        Text(turn.dutch, style: TextStyle(color: AppColors.softGrey)),
        const SizedBox(height: 7),
        Wrap(spacing: 8, children: [
          TextButton.icon(onPressed: () => AudioService.instance.speak(turn.darijaArabic, VoiceGender.male), icon: const Icon(Icons.man_rounded), label: const Text('Man')),
          TextButton.icon(onPressed: () => AudioService.instance.speak(turn.darijaArabic, VoiceGender.female), icon: const Icon(Icons.woman_rounded), label: const Text('Vrouw')),
        ]),
      ]),
    );
  }
}
