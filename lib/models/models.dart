class DarijaCard {
  final String id;
  final String darijaLatin;
  final String darijaArabic;
  final String dutch;
  final String? note;
  final String? audioMale;
  final String? audioFemale;

  const DarijaCard({
    required this.id,
    required this.darijaLatin,
    required this.darijaArabic,
    required this.dutch,
    this.note,
    this.audioMale,
    this.audioFemale,
  });

  factory DarijaCard.fromJson(Map<String, dynamic> json) => DarijaCard(
        id: json['id'] as String,
        darijaLatin: json['darijaLatin'] as String,
        darijaArabic: json['darijaArabic'] as String,
        dutch: json['dutch'] as String,
        note: json['note'] as String?,
        audioMale: json['audioMale'] as String?,
        audioFemale: json['audioFemale'] as String?,
      );
}

class DialogueTurn {
  final String speaker;
  final String dutch;
  final String darijaLatin;
  final String darijaArabic;

  const DialogueTurn({
    required this.speaker,
    required this.dutch,
    required this.darijaLatin,
    required this.darijaArabic,
  });

  factory DialogueTurn.fromJson(Map<String, dynamic> json) => DialogueTurn(
        speaker: json['speaker'] as String,
        dutch: json['dutch'] as String,
        darijaLatin: json['darijaLatin'] as String,
        darijaArabic: json['darijaArabic'] as String,
      );
}

class Dialogue {
  final String id;
  final String title;
  final List<DialogueTurn> turns;

  const Dialogue({required this.id, required this.title, required this.turns});

  factory Dialogue.fromJson(Map<String, dynamic> json) => Dialogue(
        id: json['id'] as String,
        title: json['title'] as String,
        turns: (json['turns'] as List)
            .map((e) => DialogueTurn.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
}

enum ExerciseType { multipleChoice, translateToDarija, translateToDutch }

class LessonExercise {
  final String id;
  final ExerciseType type;
  final String prompt;
  final String? promptArabic;
  final String answer;
  final String? answerArabic;
  final List<String> options;

  const LessonExercise({
    required this.id,
    required this.type,
    required this.prompt,
    this.promptArabic,
    required this.answer,
    this.answerArabic,
    required this.options,
  });

  factory LessonExercise.fromJson(Map<String, dynamic> json) {
    final raw = json['type'] as String;
    return LessonExercise(
      id: json['id'] as String,
      type: ExerciseType.values.firstWhere((e) => e.name == raw),
      prompt: json['prompt'] as String,
      promptArabic: json['promptArabic'] as String?,
      answer: json['answer'] as String,
      answerArabic: json['answerArabic'] as String?,
      options: (json['options'] as List? ?? const []).cast<String>(),
    );
  }
}

class Lesson {
  final String id;
  final String title;
  final String subtitle;
  final String emoji;
  final List<DarijaCard> cards;
  final List<Dialogue> dialogues;
  final List<LessonExercise> exercises;

  const Lesson({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.emoji,
    required this.cards,
    required this.dialogues,
    required this.exercises,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) => Lesson(
        id: json['id'] as String,
        title: json['title'] as String,
        subtitle: json['subtitle'] as String,
        emoji: json['emoji'] as String,
        cards: (json['cards'] as List)
            .map((e) => DarijaCard.fromJson(e as Map<String, dynamic>))
            .toList(),
        dialogues: (json['dialogues'] as List)
            .map((e) => Dialogue.fromJson(e as Map<String, dynamic>))
            .toList(),
        exercises: (json['exercises'] as List)
            .map((e) => LessonExercise.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
}

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

  factory DarijaLevel.fromJson(Map<String, dynamic> json) => DarijaLevel(
        id: json['id'] as String,
        title: json['title'] as String,
        description: json['description'] as String,
        emoji: json['emoji'] as String,
        lessons: (json['lessons'] as List)
            .map((e) => Lesson.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  int get totalCards => lessons.fold(0, (sum, l) => sum + l.cards.length);
}
