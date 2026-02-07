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

  final outFile = File('collisions.txt');
  final sink = outFile.openWrite();

  sink.writeln('--- COLLISIONS START ---');
  int count = 0;
  int printed = 0;

  // Sort reverseMap keys by length (shortest first) to prioritize common words
  var sortedKeys = reverseMap.keys.toList()
    ..sort((a, b) => a.length.compareTo(b.length));

  for (var k in sortedKeys) {
    var v = reverseMap[k]!;
    if (v.length > 1) {
      v.sort((a, b) => a.length.compareTo(b.length));
      if (printed < 100) {
        // Limit to 100
        sink.writeln('$k -> ${v.join(", ")}');
        printed++;
      }
      count++;
    }
  }
  sink.writeln('--- Found $count collisions (showing first $printed) ---');
  await sink.close();
  print('Collisions written to collisions.txt');
}
