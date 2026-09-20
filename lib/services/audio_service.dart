import 'package:flutter_tts/flutter_tts.dart';

enum VoiceGender { male, female }

class AudioService {
  AudioService._();
  static final AudioService instance = AudioService._();

  final FlutterTts _tts = FlutterTts();
  List<dynamic>? _voices;

  Future<void> speak(String text, VoiceGender gender) async {
    await _tts.stop();
    await _tts.setLanguage('ar-MA');
    await _tts.setSpeechRate(0.42);
    await _tts.setPitch(gender == VoiceGender.female ? 1.05 : 0.9);

    _voices ??= (await _tts.getVoices) as List<dynamic>?;
    final voices = _voices ?? const [];
    Map<dynamic, dynamic>? selected;

    for (final voice in voices) {
      if (voice is! Map) continue;
      final locale = (voice['locale'] ?? '').toString().toLowerCase();
      final voiceGender = (voice['gender'] ?? '').toString().toLowerCase();
      final localeOk = locale.startsWith('ar-ma') || locale.startsWith('ar_') || locale == 'ar';
      final genderOk = gender == VoiceGender.female
          ? voiceGender.contains('female')
          : voiceGender.contains('male') && !voiceGender.contains('female');
      if (localeOk && genderOk) {
        selected = voice;
        break;
      }
    }

    if (selected != null && selected['name'] != null && selected['locale'] != null) {
      await _tts.setVoice({
        'name': selected['name'].toString(),
        'locale': selected['locale'].toString(),
      });
    }
    await _tts.speak(text);
  }
}
