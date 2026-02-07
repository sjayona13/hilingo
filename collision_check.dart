import 'dart:convert';
import 'dart:io';

void main() async {
  final file = File(
      'd:/hilingo/hilingoapp/flutter_application_1/assets/dictionary.json');
  if (!await file.exists()) {
    print('File not found');
    return;
  }

  final jsonString = await file.readAsString();
  final data = json.decode(jsonString);
  final eng = data['eng'] as Map<String, dynamic>;

  // Normalize key and value
  String normalize(String s) =>
      s.toLowerCase().replaceAll(RegExp(r"[^\w\s]"), "").trim();

  final reverseMap = <String, List<String>>{};

  eng.forEach((key, value) {
    final normVal = normalize(value.toString());
    final normKey = normalize(key);

    if (normVal.isNotEmpty && normKey.isNotEmpty) {
      if (!reverseMap.containsKey(normVal)) {
        reverseMap[normVal] = [];
      }
      reverseMap[normVal]!.add(normKey);
    }
  });

  print('--- COLLISIONS START ---');
  reverseMap.forEach((k, v) {
    if (v.length > 1) {
      // Sort by length to see potential "shortest key" candidates
      v.sort((a, b) => a.length.compareTo(b.length));
      print('$k: $v');
    }
  });
  print('--- COLLISIONS END ---');
}
