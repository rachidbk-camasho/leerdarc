import 'dart:math';
import 'package:flutter/material.dart';
import '../models/models.dart';
import '../services/audio_service.dart';
import '../theme/app_theme.dart';

class Flashcard extends StatefulWidget {
  final DarijaCard card;
  const Flashcard({super.key, required this.card});

  @override
  State<Flashcard> createState() => _FlashcardState();
}

class _FlashcardState extends State<Flashcard> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 380));
  bool _showFront = true;

  void _flip() {
    _showFront ? _controller.forward() : _controller.reverse();
    setState(() => _showFront = !_showFront);
  }

  @override
  void didUpdateWidget(covariant Flashcard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.card.id != widget.card.id) {
      _controller.value = 0;
      _showFront = true;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _flip,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final angle = _controller.value * pi;
          final isBack = angle > pi / 2;
          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()..setEntry(3, 2, 0.0012)..rotateY(angle),
            child: isBack
                ? Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()..rotateY(pi),
                    child: _CardFace(isFront: false, card: widget.card),
                  )
                : _CardFace(isFront: true, card: widget.card),
          );
        },
      ),
    );
  }
}

class _CardFace extends StatelessWidget {
  final bool isFront;
  final DarijaCard card;
  const _CardFace({required this.isFront, required this.card});

  @override
  Widget build(BuildContext context) {
    final title = isFront ? card.darijaLatin : card.dutch;
    final subtitle = isFront ? card.darijaArabic : 'Tik om terug te draaien';
    return Container(
      width: double.infinity,
      height: 320,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isFront ? [AppColors.terracotta, const Color(0xFFC24A2E)] : [AppColors.teal, AppColors.deepTeal],
        ),
        boxShadow: [BoxShadow(color: (isFront ? AppColors.terracotta : AppColors.teal).withOpacity(0.35), blurRadius: 24, offset: const Offset(0, 12))],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(isFront ? 'DARIJA' : 'NEDERLANDS', style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.w700, letterSpacing: 2, fontSize: 12)),
          const SizedBox(height: 14),
          Text(title, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w800, height: 1.2)),
          const SizedBox(height: 10),
          Text(subtitle, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500)),
          if (isFront) ...[
            const SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _AudioButton(label: 'Man', icon: Icons.man_rounded, onTap: () => AudioService.instance.speak(card.darijaArabic, VoiceGender.male)),
                const SizedBox(width: 10),
                _AudioButton(label: 'Vrouw', icon: Icons.woman_rounded, onTap: () => AudioService.instance.speak(card.darijaArabic, VoiceGender.female)),
              ],
            ),
          ],
          if (card.note != null) ...[
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.18), borderRadius: BorderRadius.circular(999)),
              child: Text(card.note!, style: const TextStyle(color: Colors.white, fontSize: 12)),
            ),
          ],
        ],
      ),
    );
  }
}

class _AudioButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  const _AudioButton({required this.label, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) => Material(
        color: Colors.white.withOpacity(0.18),
        borderRadius: BorderRadius.circular(999),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(999),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
            child: Row(children: [Icon(icon, size: 18, color: Colors.white), const SizedBox(width: 5), Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700))]),
          ),
        ),
      );
}
