import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'homepage.dart'; 

class VoicePage extends StatefulWidget {
  const VoicePage({super.key});

  @override
  _SpeechPageState createState() => _SpeechPageState();
}

class _SpeechPageState extends State<VoicePage> {
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

Future<void> _loadDictionary() async {
  try {
    final String jsonString =
        await rootBundle.loadString('assets/dictionary.json');
    final Map<String, dynamic> jsonData = json.decode(jsonString);

    
    final engToHil = {
      for (var e in (jsonData['eng'] as Map<String, dynamic>).entries)
        e.key.toLowerCase(): e.value.toString().toLowerCase()
    };

    final hilToEng = {
      for (var e in engToHil.entries)
        e.value: e.key 
    };

    _dictionary = {'eng': engToHil, 'hil': hilToEng};

    setState(() {
      _dictionaryLoaded = true;
    });

    debugPrint(
        "Dictionary loaded: ${engToHil.length} eng→hil, ${hilToEng.length} hil→eng");
  } catch (e) {
    debugPrint("Error loading dictionary: $e");
    setState(() {
      _statusMessage = "Dictionary not loaded. Check assets setup.";
    });
  }
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

  String _normalize(String text) {
    return text.toLowerCase().replaceAll(RegExp(r"[^\w\s]"), "").trim();
  }

 String _translateFromDictionary(String input) {
  if (!_dictionaryLoaded) return "Dictionary not loaded yet.";

  String lowerInput = _normalize(input);
  final engToHil = _dictionary['eng'] as Map<String, dynamic>;
  final hilToEng = _dictionary['hil'] as Map<String, dynamic>;

  bool likelyEnglish = false;
  bool likelyHiligaynon = false;

  if (engToHil.containsKey(lowerInput)) {
    likelyEnglish = true;
  } else if (hilToEng.containsKey(lowerInput)) {
    likelyHiligaynon = true;
  } else {
    for (String word in lowerInput.split(RegExp(r'\s+'))) {
      if (engToHil.containsKey(word)) likelyEnglish = true;
      if (hilToEng.containsKey(word)) likelyHiligaynon = true;
    }
  }

  Map<String, dynamic> fromMap;
  Map<String, dynamic> toMap;
  if (likelyEnglish && !likelyHiligaynon) {
    fromMap = engToHil;
    toMap = hilToEng;
    leftLanguage = "English";
    rightLanguage = "Hiligaynon";
  } else if (likelyHiligaynon && !likelyEnglish) {
    fromMap = hilToEng;
    toMap = engToHil;
    leftLanguage = "Hiligaynon";
    rightLanguage = "English";
  } else {
    fromMap = engToHil;
    toMap = hilToEng;
    leftLanguage = "English";
    rightLanguage = "Hiligaynon";
  }

  List<String> words = lowerInput.split(RegExp(r'\s+'));
  List<String> translatedParts = [];

  int i = 0;
  while (i < words.length) {
    String? translated;
    int matchedLength = 0;

    for (int len = 6; len >= 1; len--) {
      if (i + len > words.length) continue;
      String phrase = words.sublist(i, i + len).join(" ");
      if (fromMap.containsKey(phrase)) {
        translated = fromMap[phrase];
        matchedLength = len;
        break;
      }
    }

    if (translated == null) {
      for (int len = 6; len >= 1; len--) {
        if (i + len > words.length) continue;
        String phrase = words.sublist(i, i + len).join(" ");
        if (toMap.containsKey(phrase)) {
          translated = toMap[phrase];
          matchedLength = len;
          break;
        }
      }
    }

    if (translated != null) {
      translatedParts.add(translated);
      i += matchedLength;
    } else {
      translatedParts.add(words[i]);
      i++;
    }
  }

  String output = translatedParts.join(" ");
  output = output.isNotEmpty
      ? output[0].toUpperCase() + output.substring(1)
      : "No translation found.";

  setState(() {
    _statusMessage = 'Auto-detected: $leftLanguage → $rightLanguage';
  });

  return output;
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios_new,
                            color: Colors.black),
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HilingoApp()),
                          );
                        },
                      ),
                      const Spacer(),
                      Center(
                          child: Image.asset('assets/iconh.png', height: 40)),
                      const Spacer(flex: 2),
                    ],
                  ),
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              leftLanguage,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.blue.shade800,
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: IconButton(
                            icon: const Icon(Icons.swap_horiz,
                                color: Colors.blue),
                            onPressed: _swapLanguages,
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              rightLanguage,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.blue.shade800,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),

                  
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
                        Text(
                          'Recognized Speech ($leftLanguage):',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          _spokenText.isEmpty ? "..." : _spokenText,
                          style: const TextStyle(
                              fontSize: 18, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  
                SizedBox(
  height: 100, 
  width: double.infinity,
  child: Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.blue.shade50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.blue.shade200, width: 2),
    ),
    child: SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Translation ($rightLanguage):',
            style: TextStyle(
              fontSize: 12,
              color: Colors.blue.shade700,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            _translatedText.isEmpty ? _statusMessage : _translatedText,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    ),
  ),
),


                  const SizedBox(height: 150), 
                ],
              ),
            ),

            
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 100),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onLongPressStart: (_) => _listen(),
                      onLongPressEnd: (_) => _stopListening(),
                      child: Container(
                        width: 100,
                        height: 100,
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
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
