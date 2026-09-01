/// A single Darija <-> Nederlands vocabulary or phrase card.
class DarijaCard {
  final String darijaLatin; // e.g. "Salam"
  final String darijaArabic; // e.g. "سلام"
  final String dutch; // e.g. "Hallo"
  final String? note; // extra usage tip, optional

  const DarijaCard({
    required this.darijaLatin,
    required this.darijaArabic,
    required this.dutch,
    this.note,
  });
}

/// A themed lesson (e.g. "Groeten") containing a set of cards.
class Lesson {
  final String id;
  final String title;
  final String subtitle;
  final String emoji;
  final List<DarijaCard> cards;

  const Lesson({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.emoji,
    required this.cards,
  });
}

/// One of the three learning levels: Basis, A1, A2.
class DarijaLevel {
  final String id;
  final String title;
  final String description;
  final String emoji;
  final List<Lesson> lessons;

  const DarijaLevel({
    required this.id,
    required this.title,
    required this.description,
    required this.emoji,
    required this.lessons,
  });

  int get totalCards => lessons.fold(0, (sum, l) => sum + l.cards.length);
}
