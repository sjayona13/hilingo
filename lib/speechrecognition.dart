import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SpeechPage extends StatefulWidget {
  const SpeechPage({super.key});

  @override
  _SpeechPageState createState() => _SpeechPageState();
}

class _SpeechPageState extends State<SpeechPage> {
  String leftLanguage = "English";
  String rightLanguage = "Hiligaynon";

  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _spokenText = '';
  String _translatedText = '';
  String _statusMessage = 'Tap and hold the microphone to start speaking.';

  Map<String, dynamic> _dictionary = {};
  bool _dictionaryLoaded = false;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _initSpeech();
    _loadDictionary();
  }

  /// ✅ Load nested dictionary { "en": {...}, "hil": {...} }
  Future<void> _loadDictionary() async {
    try {
      final String jsonString =
          await rootBundle.loadString('assets/dictionary.json');
      final Map<String, dynamic> jsonData = json.decode(jsonString);

      setState(() {
        _dictionary = jsonData;
        _dictionaryLoaded = true;
      });

      debugPrint(
          "✅ Dictionary loaded successfully with ${_dictionary['eng']?.length ?? 0} English and ${_dictionary['hil']?.length ?? 0} Hiligaynon entries");
    } catch (e) {
      debugPrint("❌ Error loading dictionary: $e");
      setState(() {
        _statusMessage = "Dictionary not loaded. Check assets setup.";
      });
    }
  }

  /// ✅ Microphone permission
  Future<void> _requestMicPermission() async {
    var status = await Permission.microphone.status;
    if (!status.isGranted) {
      await Permission.microphone.request();
    }
  }

  /// ✅ Initialize speech recognition
  Future<void> _initSpeech() async {
    await _requestMicPermission();
    await _speech.initialize(
      onStatus: (status) {
        if (status == 'done' || status == 'notListening') {
          _stopListening();
        }
      },
      onError: (error) {
        debugPrint('Speech error: $error');
        setState(() {
          _statusMessage = 'Speech initialization failed: $error';
        });
      },
    );
  }

  /// ✅ Swap translation direction
  void _swapLanguages() {
    setState(() {
      final temp = leftLanguage;
      leftLanguage = rightLanguage;
      rightLanguage = temp;
      _spokenText = '';
      _translatedText = '';
      _statusMessage = 'Swapped to $leftLanguage → $rightLanguage.';
    });
  }

  /// 🎙️ Start listening
  void _listen() async {
    if (!_dictionaryLoaded) {
      setState(() =>
          _statusMessage = "Dictionary not loaded yet. Please wait...");
      return;
    }

    bool available = await _speech.initialize();

    if (!available) {
      setState(() => _statusMessage = "Speech recognition unavailable.");
      return;
    }

    final locale = leftLanguage == "English" ? "en_US" : "fil_PH";

    setState(() {
      _isListening = true;
      _spokenText = '';
      _translatedText = '';
      _statusMessage = 'Listening...';
    });

    await _speech.listen(
      listenFor: const Duration(seconds: 10),
      pauseFor: const Duration(seconds: 3),
      localeId: locale,
      onResult: (result) async {
        setState(() {
          _spokenText = result.recognizedWords;
        });

        if (result.finalResult && _spokenText.isNotEmpty) {
          setState(() => _statusMessage = 'Translating...');
          final translation = _translateFromDictionary(_spokenText);
          setState(() {
            _translatedText = translation;
            _statusMessage = 'Translation complete.';
          });
        }
      },
    );
  }

  /// 🛑 Stop listening
  void _stopListening() async {
    if (_isListening) {
      await _speech.stop();
    }
    setState(() {
      _isListening = false;
      if (_spokenText.trim().isEmpty) {
        _statusMessage = "No speech detected. Try again.";
      }
    });
  }

  /// 🧠 Clean text for better matching
  String _normalize(String text) {
    return text
        .toLowerCase()
        .replaceAll(RegExp(r"[^\w\s]"), "") // remove punctuation
        .trim();
  }

  /// 🧠 Translate using flexible dictionary matching
  String _translateFromDictionary(String input) {
    if (!_dictionaryLoaded) return "Dictionary not loaded yet.";

    String lowerInput = _normalize(input);
    Map<String, dynamic>? engMap = _dictionary['eng'];
    Map<String, dynamic>? hilMap = _dictionary['hil'];

    String? translated;

    // ✅ English → Hiligaynon
    if (leftLanguage == "English") {
      translated = engMap?[lowerInput];
      if (translated == null) {
        for (var key in engMap!.keys) {
          if (_normalize(key) == lowerInput) {
            translated = engMap[key];
            break;
          }
        }
      }
    }

    // ✅ Hiligaynon → English
    else if (leftLanguage == "Hiligaynon") {
      translated = hilMap?[lowerInput];
      if (translated == null) {
        for (var key in hilMap!.keys) {
          if (_normalize(key) == lowerInput) {
            translated = hilMap[key];
            break;
          }
        }
      }
    }

    return translated ?? "No translation found for \"$input\".";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Center(child: Image.asset('assets/iconh.png', height: 40)),
              const SizedBox(height: 10),
              const Text(
                "HILIGAYNON SPEECH TRANSLATOR",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 30),

              // 🌍 Language Selector
              Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  border: Border.all(color: Colors.blue.shade200),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(leftLanguage,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.blue.shade800)),
                      ),
                    ),
                    Center(
                      child: IconButton(
                        icon: const Icon(Icons.swap_horiz, color: Colors.blue),
                        onPressed: _swapLanguages,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(rightLanguage,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.blue.shade800)),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),

              // 🎙️ Recognized Speech
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Recognized Speech ($leftLanguage):',
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text(
                      _spokenText.isEmpty ? "..." : _spokenText,
                      style: const TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // 🗣️ Translation Output
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue.shade200, width: 2),
                ),
                child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Translation ($rightLanguage):',
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.blue.shade700,
                                fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text(
                          _translatedText.isEmpty
                              ? _statusMessage
                              : _translatedText,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ]),
                ),
              ),
              const SizedBox(height: 60),

              // 🎤 Microphone Button
              GestureDetector(
                onLongPressStart: (_) => _listen(),
                onLongPressEnd: (_) => _stopListening(),
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _isListening
                        ? Colors.red.shade600
                        : Colors.blue.shade600,
                    boxShadow: [
                      BoxShadow(
                        color: _isListening
                            ? Colors.red.shade200
                            : Colors.blue.shade200,
                        spreadRadius: 8,
                        blurRadius: 15,
                      ),
                    ],
                  ),
                  child: Icon(
                    _isListening ? Icons.mic_off : Icons.mic,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                _isListening ? 'RELEASE TO STOP' : 'HOLD TO TALK',
                style: TextStyle(
                  color: _isListening
                      ? Colors.red.shade600
                      : Colors.blue.shade600,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
