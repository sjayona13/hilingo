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
  final Trie _engToHilTrie = Trie();
  final Trie _hilToEngTrie = Trie();
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

            _engToHilTrie.insert(normKey, normValue);
            _hilToEngTrie.insert(normValue, normKey);
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

            _hilToEngTrie.insert(normKey, normValue);
            _engToHilTrie.insert(normValue, normKey);
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
      listenFor: const Duration(seconds: 60),
      pauseFor: const Duration(seconds: 5),
      partialResults: true,
      localeId: locale,
      listenMode: stt.ListenMode.dictation,
      onResult: (result) async {
        setState(() {
          _spokenText = result.recognizedWords;
          if (_spokenText.trim().isNotEmpty) {
            _translatedText = _translateFromDictionary(_spokenText);
            _statusMessage = result.finalResult ? 'Translation complete.' : 'Translating...';
          }
        });
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

  // === LAYER 2: PHRASE CHUNKING (TRIE OPTIMIZED) ===
  List<String> _extractPhraseChunks(String input, Trie primaryTrie) {
    List<String> words = input.split(RegExp(r'\s+'));
    List<String> translatedParts = [];
    int i = 0;

    while (i < words.length) {
      var result = primaryTrie.searchLongestPrefix(words, i);
      int matchedLength = result[0] as int;
      String? translated = result[1] as String?;

      if (translated != null && matchedLength > 0) {
        // Mark chunk so word processor doesn't break it later
        translatedParts.add("[[CHUNK:$translated]]");
        i += matchedLength;
      } else {
        translatedParts.add(words[i]); // Leave as raw word
        i++;
      }
    }
    return translatedParts;
  }

  // === MULTI-LAYER TRANSLATION ENGINE ===
  String _translateFromDictionary(String input) {
    if (!_dictionaryLoaded) return "Dictionary not loaded yet.";

    String lowerInput = _normalize(input);
    final engToHil = _dictionary['eng'] as Map<String, dynamic>;
    final hilToEng = _dictionary['hil'] as Map<String, dynamic>;

    // ------------------------------------------------------------------------
    // LAYER 1: EXACT OR FUZZY SENTENCE MATCH (Instant Perfect Translation)
    // ------------------------------------------------------------------------
    if (engToHil.containsKey(lowerInput)) {
      leftLanguage = "English"; rightLanguage = "Hiligaynon";
      return engToHil[lowerInput];
    }
    if (hilToEng.containsKey(lowerInput)) {
      leftLanguage = "Hiligaynon"; rightLanguage = "English";
      return hilToEng[lowerInput];
    }

    String? fuzzyMatchKey;
    String? fuzzyMatchTranslation;
    int bestDist = 1000;

    engToHil.forEach((key, value) {
      int dist = _levenshteinDistance(lowerInput, key);
      if (dist < bestDist && dist <= (key.length * 0.2).ceil() + 1) {
        bestDist = dist; fuzzyMatchKey = key; fuzzyMatchTranslation = value;
      }
    });

    if (fuzzyMatchKey == null) {
      hilToEng.forEach((key, value) {
        int dist = _levenshteinDistance(lowerInput, key);
        if (dist < bestDist && dist <= (key.length * 0.2).ceil() + 1) {
          bestDist = dist; fuzzyMatchKey = key; fuzzyMatchTranslation = value;
        }
      });
    }

    if (fuzzyMatchTranslation != null) {
      debugPrint("🤖 Layer 1 Fuzzy Match: '$lowerInput' -> '$fuzzyMatchKey'");
      setState(() => _statusMessage = 'Auto-detected (Smart Match): $fuzzyMatchKey');
      return fuzzyMatchTranslation!;
    }

    // Language Detection for remaining layers
    bool likelyEnglish = false;
    bool likelyHiligaynon = false;
    for (String word in lowerInput.split(RegExp(r'\s+'))) {
      if (engToHil.containsKey(word)) likelyEnglish = true;
      if (hilToEng.containsKey(word)) likelyHiligaynon = true;
    }

    Map<String, dynamic> fromMap = engToHil;
    Map<String, dynamic> toMap = hilToEng;
    Trie fromTrie = _engToHilTrie;

    if (likelyEnglish && !likelyHiligaynon) {
      fromMap = engToHil; toMap = hilToEng;
      fromTrie = _engToHilTrie;
      leftLanguage = "English"; rightLanguage = "Hiligaynon";
    } else if (likelyHiligaynon && !likelyEnglish) {
      fromMap = hilToEng; toMap = engToHil;
      fromTrie = _hilToEngTrie;
      leftLanguage = "Hiligaynon"; rightLanguage = "English";
    }

    // ------------------------------------------------------------------------
    // LAYER 2: PHRASE CHUNKING (TRIE OPTIMIZED)
    // ------------------------------------------------------------------------
    List<String> chunkedList = _extractPhraseChunks(lowerInput, fromTrie);

    // ------------------------------------------------------------------------
    // LAYER 3: WORD FALLBACK + GRAMMAR RULES
    // ------------------------------------------------------------------------
    List<String> finalTranslatedParts = [];

    for (String block in chunkedList) {
      if (block.startsWith("[[CHUNK:") && block.endsWith("]]")) {
        // It's a preserved phrase chunk from Layer 2! Strip the tags and add it.
        finalTranslatedParts.add(block.substring(8, block.length - 2));
      } else {
        // It's a leftover single word. Try direct translate, fallback translate, or fuzzy micro-match.
        String currentWord = block;
        String? wordTranslation;

        // Direct Word Match
        if (fromMap.containsKey(currentWord)) {
          wordTranslation = fromMap[currentWord];
        } else if (toMap.containsKey(currentWord)) {
          wordTranslation = toMap[currentWord];
        } else if (currentWord.length > 3) {
          // Word Level Fuzzy (Micro-ML)
          int lowestWordDist = 100;
          fromMap.forEach((key, value) {
            if (!key.contains(' ')) {
              int dist = _levenshteinDistance(currentWord, key);
              if (dist < lowestWordDist && dist <= 2) {
                lowestWordDist = dist; wordTranslation = value;
              }
            }
          });
        }

        finalTranslatedParts.add(wordTranslation ?? currentWord);
      }
    }

    // Apply the Hybrid Grammar Rules
    finalTranslatedParts = _applyGrammarRules(finalTranslatedParts, rightLanguage);

    String output = finalTranslatedParts.join(" ");
    output = output.isNotEmpty
        ? output[0].toUpperCase() + output.substring(1)
        : "No translation found.";

    setState(() => _statusMessage = 'Auto-detected: $leftLanguage → $rightLanguage');

    return output;
  }

  // === HYBRID GRAMMAR RULES ENGINE ===
  List<String> _applyGrammarRules(List<String> words, String targetLanguage) {
    if (words.isEmpty) return words;
    List<String> result = List.from(words);

    if (targetLanguage == "English") {
      // Hiligaynon to English Grammar Fixes (VSO to SVO + Adjective positioning)
      for (int i = 0; i < result.length - 1; i++) {
        String w1 = result[i].toLowerCase();
        String w2 = result[i + 1].toLowerCase();

        // Rule 1: Fix VSO (Verb-Subject) -> SVO (Subject-Verb)
        // Hiligaynon puts verbs first: "Kaon ako" -> "Eat I" -> Convert to "I eat"
        List<String> pronouns = ['i', 'you', 'he', 'she', 'it', 'we', 'they'];
        List<String> commonVerbs = [
          'eat', 'drink', 'walk', 'run', 'sleep', 'jump', 'talk', 'sing', 'dance',
          'write', 'read', 'see', 'look', 'go', 'come', 'want', 'like'
        ];
        
        if (commonVerbs.contains(w1) && pronouns.contains(w2)) {
          // Swap them
          String temp = result[i];
          result[i] = result[i + 1];
          result[i + 1] = temp;
          continue;
        }

        // Rule 2: Possessive Pronouns (Noun-Possessive -> Possessive-Noun)
        // Hiligaynon: "Balay ko" -> "House my" -> Convert to "My house"
        List<String> possessives = ['my', 'your', 'his', 'her', 'its', 'our', 'their'];
        if (!possessives.contains(w1) && possessives.contains(w2)) {
          String temp = result[i];
          result[i] = result[i + 1];
          result[i + 1] = temp;
          continue;
        }

        // Rule 3: Strip dangling Filipino ligatures accidentally translated literally
        if (w1 == "nga" || w1 == "ang") {
          result[i] = ""; // Remove it, English doesn't use these linkers this way
        }
      }
    } else if (targetLanguage == "Hiligaynon") {
      // English to Hiligaynon Grammar Fixes (SVO to VSO + Linkers)
      for (int i = 0; i < result.length - 1; i++) {
        String w1 = result[i].toLowerCase();
        String w2 = result[i + 1].toLowerCase();

        // Rule 1: Fix SVO (Subject-Verb) -> VSO (Verb-Subject)
        List<String> hilPronouns = ['ako', 'ikaw', 'ka', 'siya', 'kami', 'kita', 'sila'];
        List<String> hilVerbs = [
          'kaon', 'inom', 'lakat', 'dalagan', 'tulog', 'lumpat', 'hambal', 'kanta',
          'saot', 'sulat', 'basa', 'kita', 'tan-aw', 'kadto', 'kari', 'gusto', 'palangga'
        ];

        // If Pronoun is followed by Verb, swap them (SVO -> VSO)
        if (hilPronouns.contains(w1) && hilVerbs.contains(w2)) {
          String temp = result[i];
          result[i] = result[i + 1];
          result[i + 1] = temp;
          continue;
        }
        
        // Rule 2: Adjective-Noun linking
        // English: "Beautiful house" -> Hiligaynon: "Gwapa nga balay"
        List<String> hilAdjectives = ['gwapa', 'gwapo', 'dako', 'gamay', 'ta-as', 'lip-ot', 'mainit', 'matugnaw', 'manami', 'law-ay'];
        if (hilAdjectives.contains(w1) && !['nga', 'ang', 'sang'].contains(w2)) {
          // Insert 'nga' if we have an adjective directly before a noun
          // Let's just append it to the adjective string to avoid array shifting complexities
          result[i] = "${result[i]} nga"; 
        }
      }
    }

    // Clean up empty strings from removals
    result.removeWhere((item) => item.isEmpty);
    return result;
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

class TrieNode {
  final Map<String, TrieNode> children = {};
  bool isEndOfPhrase = false;
  String? translation;
}

class Trie {
  final TrieNode root = TrieNode();

  void insert(String phrase, String translation) {
    if (phrase.trim().isEmpty) return;
    List<String> words = phrase.toLowerCase().split(RegExp(r'\s+'));
    TrieNode current = root;
    for (String word in words) {
      if (!current.children.containsKey(word)) {
        current.children[word] = TrieNode();
      }
      current = current.children[word]!;
    }
    current.isEndOfPhrase = true;
    current.translation = translation;
  }

  // Returns [matchedLength, translation] or [0, null]
  List<dynamic> searchLongestPrefix(List<String> words, int startIndex) {
    TrieNode current = root;
    int longestMatchLength = 0;
    String? bestTranslation;
    int currentLength = 0;

    for (int i = startIndex; i < words.length; i++) {
      String word = words[i].toLowerCase();
      if (!current.children.containsKey(word)) {
        break; // Stop if prefix path breaks
      }
      current = current.children[word]!;
      currentLength++;
      if (current.isEndOfPhrase) {
        longestMatchLength = currentLength;
        bestTranslation = current.translation;
      }
    }
    return [longestMatchLength, bestTranslation];
  }
}

