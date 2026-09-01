import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Tracks which lessons the user has completed, persisted locally on-device.
class ProgressService extends ChangeNotifier {
  static const _prefsKey = 'completed_lesson_ids';

  Set<String> _completed = {};
  bool _loaded = false;

  bool get isLoaded => _loaded;

  bool isLessonComplete(String lessonId) => _completed.contains(lessonId);

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    _completed = (prefs.getStringList(_prefsKey) ?? []).toSet();
    _loaded = true;
    notifyListeners();
  }

  Future<void> markLessonComplete(String lessonId) async {
    if (_completed.contains(lessonId)) return;
    _completed.add(lessonId);
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_prefsKey, _completed.toList());
  }

  int completedInLevel(List<String> lessonIds) {
    return lessonIds.where(_completed.contains).length;
  }
}
