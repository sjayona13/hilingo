import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class VoicePage extends StatefulWidget {
  const VoicePage({super.key});

  @override
  _VoicePageState createState() => _VoicePageState();
}

class _VoicePageState extends State<VoicePage> {
  String leftLanguage = "English";
  String rightLanguage = "Hiligaynon";

  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _spokenText = '';
  String _translatedText = '';
  String _statusMessage = 'Tap and hold the microphone to start speaking.';

  late Map<String, dynamic> _dictionary;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _initSpeech();
    _loadDictionary();
  }

  Future<void> _requestMicPermission() async {
    var status = await Permission.microphone.status;
    if (!status.isGranted) {
      await Permission.microphone.request();
    }
  }

  Future<void> _initSpeech() async {
    await _requestMicPermission();
    await _speech.initialize(
      onStatus: (status) => debugPrint('Speech status: $status'),
      onError: (error) => debugPrint('Speech initialization error: $error'),
    );
  }

  Future<void> _loadDictionary() async {
    final jsonString = await rootBundle.loadString('assets/dictionary.json');
    _dictionary = jsonDecode(jsonString);
    debugPrint("Loaded dictionary with languages: ${_dictionary.keys}");
  }

  void _swapLanguages() {
    setState(() {
      final temp = leftLanguage;
      leftLanguage = rightLanguage;
      rightLanguage = temp;
      _spokenText = '';
      _translatedText = '';
      _statusMessage =
          'Swapped to $leftLanguage → $rightLanguage. Hold to speak.';
    });
  }

  void _listen() async {
    bool available = await _speech.initialize(
      onStatus: (status) {
        debugPrint('Speech status: $status');
        if (status == 'done' || status == 'notListening') {
          _stopListening();
        }
      },
      onError: (error) {
        debugPrint('Speech error: $error');
        setState(() => _statusMessage = 'Speech error: $error');
      },
    );

    if (!available) {
      setState(() => _statusMessage = "Speech recognition unavailable.");
      return;
    }

    final locale = leftLanguage == "English" ? "en_US" : "tl_PH";

    setState(() {
      _isListening = true;
      _spokenText = '';
      _translatedText = '';
      _statusMessage = 'Listening in $locale...';
    });

    await _speech.listen(
      localeId: locale,
      listenFor: const Duration(seconds: 10),
      pauseFor: const Duration(seconds: 3),
      onResult: (result) async {
        setState(() {
          _spokenText = result.recognizedWords;
        });

        if (result.finalResult) {
          await _stopListening();
        }
      },
    );
  }

  Future<void> _stopListening() async {
    if (_isListening) {
      await _speech.stop();
    }

    setState(() => _isListening = false);

    if (_spokenText.trim().isEmpty) {
      setState(() {
        _statusMessage = "No speech detected. Try again.";
      });
      return;
    }

    setState(() {
      _statusMessage = "Translating...";
    });

    final translation = await _translateText(_spokenText);
    setState(() {
      _translatedText = translation;
      _statusMessage = "Translation complete.";
    });
  }

  Future<String> _translateText(String input) async {
    if (input.trim().isEmpty) return "No input detected.";

    final sourceLang = leftLanguage == "English" ? "eng" : "hil";
    final sourceDict = _dictionary[sourceLang] ?? {};

    String text = input.toLowerCase().trim();
    List<String> words = text.split(' ');
    List<String> translated = [];
    int i = 0;

    while (i < words.length) {
      bool matchFound = false;

      // Try longest phrases first
      for (int j = words.length; j > i; j--) {
        String phrase = words.sublist(i, j).join(' ');
        if (sourceDict.containsKey(phrase)) {
          translated.add(sourceDict[phrase]);
          i = j;
          matchFound = true;
          break;
        }
      }

      if (!matchFound) {
        translated.add(words[i]); // keep word as-is if not found
        i++;
      }
    }

    return translated.join(' ');
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
                    color: Colors.black),
              ),
              const SizedBox(height: 30),

              // Language Selector
              Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  border: Border.all(color: Colors.blue.shade200),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          leftLanguage,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.blue.shade800),
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: Colors.blue.shade200, width: 1.5),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.swap_horiz,
                              color: Colors.blue, size: 24),
                          onPressed: _swapLanguages,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          rightLanguage,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.blue.shade800),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),

              // Recognized Speech Box
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
                    Text(_spokenText.isEmpty ? "..." : _spokenText,
                        style: const TextStyle(
                            fontSize: 18, color: Colors.black)),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Translation Box
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border:
                      Border.all(color: Colors.blue.shade200.withOpacity(0.8)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.shade100,
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
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
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 60),

              // Mic Button
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
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
