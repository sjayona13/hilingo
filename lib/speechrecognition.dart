import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'homepage.dart';

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

  Future<void> _loadDictionary() async {
    try {
      final String jsonString =
          await rootBundle.loadString('assets/dictionary.json');
      final Map<String, dynamic> jsonData = json.decode(jsonString);

      // Helper to match _normalize logic
      String normalize(String text) =>
          text.toLowerCase().replaceAll(RegExp(r"[^\w\s]"), "").trim();

      final engToHil = <String, String>{};
      final hilToEng = <String, String>{};

      if (jsonData['eng'] != null) {
        (jsonData['eng'] as Map<String, dynamic>).forEach((key, value) {
          final normKey = normalize(key);
          final normValue = normalize(value.toString());

          if (normKey.isNotEmpty && normValue.isNotEmpty) {
            engToHil[normKey] = normValue;
            // distinct reverse mapping
            hilToEng[normValue] = normKey;
          }
        });
      }

      // If there's a specific 'hil' section, process it too (overwriting if needed or adding)
      if (jsonData['hil'] != null) {
        (jsonData['hil'] as Map<String, dynamic>).forEach((key, value) {
          final normKey = normalize(key);
          final normValue = normalize(value.toString());

          if (normKey.isNotEmpty && normValue.isNotEmpty) {
            hilToEng[normKey] = normValue;
            engToHil[normValue] = normKey;
          }
        });
      }

      _dictionary = {'eng': engToHil, 'hil': hilToEng};

      setState(() {
        _dictionaryLoaded = true;
      });

      debugPrint(
          "✅ Dictionary loaded: ${engToHil.length} eng→hil, ${hilToEng.length} hil→eng");
    } catch (e) {
      debugPrint("❌ Error loading dictionary: $e");
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
      setState(
          () => _statusMessage = "Dictionary not loaded yet. Please wait...");
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

  // Levenshtein Distance Algorithm for Fuzzy Matching
  int _levenshteinDistance(String s1, String s2) {
    if (s1 == s2) return 0;
    if (s1.isEmpty) return s2.length;
    if (s2.isEmpty) return s1.length;

    List<int> v0 = List<int>.generate(s2.length + 1, (i) => i);
    List<int> v1 = List<int>.filled(s2.length + 1, 0);

    for (int i = 0; i < s1.length; i++) {
      v1[0] = i + 1;
      for (int j = 0; j < s2.length; j++) {
        int cost = (s1[i] == s2[j]) ? 0 : 1;
        v1[j + 1] = [
          v1[j] + 1, // deletion
          v0[j + 1] + 1, // insertion
          v0[j] + cost // substitution
        ].reduce((min, val) => val < min ? val : min);
      }
      for (int j = 0; j < v0.length; j++) v0[j] = v1[j];
    }
    return v1[s2.length];
  }

  String _translateFromDictionary(String input) {
    if (!_dictionaryLoaded) return "Dictionary not loaded yet.";

    String lowerInput = _normalize(input);
    final engToHil = _dictionary['eng'] as Map<String, dynamic>;
    final hilToEng = _dictionary['hil'] as Map<String, dynamic>;

    // 1. Try whole-sentence match first (Optimization)
    if (engToHil.containsKey(lowerInput)) return engToHil[lowerInput];
    if (hilToEng.containsKey(lowerInput)) return hilToEng[lowerInput];

    // 1.5 Fuzzy Match Whole Sentence (Simulated ML)
    // If exact match fails, check if we have a "very close" sentence in dictionary
    // Threshold: 2 edits or 20% of length, whichever is higher
    String? fuzzyMatchKey;
    String? fuzzyMatchTranslation;
    int bestDist = 1000;

    // Check English Keys
    engToHil.forEach((key, value) {
      int dist = _levenshteinDistance(lowerInput, key);
      if (dist < bestDist && dist <= (key.length * 0.2).ceil() + 1) {
        bestDist = dist;
        fuzzyMatchKey = key;
        fuzzyMatchTranslation = value;
      }
    });

    // Check Hiligaynon Keys (if no good English match found yet)
    if (fuzzyMatchKey == null) {
      hilToEng.forEach((key, value) {
        int dist = _levenshteinDistance(lowerInput, key);
        if (dist < bestDist && dist <= (key.length * 0.2).ceil() + 1) {
          bestDist = dist;
          fuzzyMatchKey = key;
          fuzzyMatchTranslation = value;
        }
      });
    }

    if (fuzzyMatchTranslation != null) {
      debugPrint(
          "🤖 Fuzzy Match: '$lowerInput' -> '$fuzzyMatchKey' ($bestDist edits)");
      setState(() {
        _statusMessage = 'Auto-detected (Smart Match): $fuzzyMatchKey';
      });
      return fuzzyMatchTranslation!;
    }

    bool likelyEnglish = false;
    bool likelyHiligaynon = false;

    // Detection logic
    for (String word in lowerInput.split(RegExp(r'\s+'))) {
      if (engToHil.containsKey(word)) likelyEnglish = true;
      if (hilToEng.containsKey(word)) likelyHiligaynon = true;
    }

    Map<String, dynamic> fromMap;
    Map<String, dynamic> toMap;

    // Prioritize detected language
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
      // Default / Mixed
      fromMap = engToHil;
      toMap = hilToEng;
    }

    List<String> words = lowerInput.split(RegExp(r'\s+'));
    List<String> translatedParts = [];

    int i = 0;
    while (i < words.length) {
      String? translated;
      int matchedLength = 0;

      // 2. Greedy Match: Try longest possible phrase starting at i
      int maxLen = words.length - i;

      for (int len = maxLen; len >= 1; len--) {
        String phrase = words.sublist(i, i + len).join(" ");
        if (fromMap.containsKey(phrase)) {
          translated = fromMap[phrase];
          matchedLength = len;
          break; // Found largest match, break inner loop
        }
      }

      // 3. Fallback: Try reverse map if primary map failed
      if (translated == null) {
        for (int len = maxLen; len >= 1; len--) {
          String phrase = words.sublist(i, i + len).join(" ");
          if (toMap.containsKey(phrase)) {
            translated = toMap[phrase];
            matchedLength = len;
            break;
          }
        }
      }

      // 4. Word-Level Fuzzy Fallback (Micro-ML)
      // If still no translation for a SINGLE word, try to find a close dictionary word
      if (translated == null && maxLen >= 1) {
        String currentWord = words[i];
        // Only do fuzzy search if word is long enough (>3 chars) to avoid false positives on 'a', 'to', etc.
        if (currentWord.length > 3) {
          String? bestWordMatch;
          int lowestWordDist = 100;

          // Scan current source map
          fromMap.forEach((key, value) {
            // Heuristic: key must be single word to replace single word
            if (!key.contains(' ')) {
              int dist = _levenshteinDistance(currentWord, key);
              if (dist < lowestWordDist && dist <= 2) {
                // Allow max 2 edits
                lowestWordDist = dist;
                bestWordMatch = value;
              }
            }
          });

          if (bestWordMatch != null) {
            translated = bestWordMatch;
            matchedLength = 1; // It was a 1-word substitution
          }
        }
      }

      if (translated != null) {
        translatedParts.add(translated);
        i += matchedLength;
      } else {
        translatedParts.add(words[i]); // No translation found, keep original
        i++;
      }
    }

    String output = translatedParts.join(" ");
    output = output.isNotEmpty
        ? output[0].toUpperCase() + output.substring(1)
        : "No translation found.";

    if (fuzzyMatchKey == null) {
      setState(() {
        _statusMessage = 'Auto-detected: $leftLanguage → $rightLanguage';
      });
    }

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
                            padding: const EdgeInsets.symmetric(horizontal: 16),
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
                            padding: const EdgeInsets.symmetric(horizontal: 16),
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
                    height: 180,
                    width: double.infinity,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(12),
                        border:
                            Border.all(color: Colors.blue.shade200, width: 2),
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
                              _translatedText.isEmpty
                                  ? _statusMessage
                                  : _translatedText,
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
