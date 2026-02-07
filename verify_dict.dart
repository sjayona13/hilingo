import 'dart:convert';
import 'dart:io';

void main() async {
  final file = File(
      'd:/hilingo/hilingoapp/flutter_application_1/assets/dictionary.json');
  if (!await file.exists()) {
    print('File not found');
    return;
  }

  try {
    final jsonString = await file.readAsString();
    final data = json.decode(jsonString);

    if (data['hil'] != null) {
      final hil = data['hil'] as Map<String, dynamic>;
      print('✅ "hil" section found.');

      // Check specific overrides
      final checks = [
        'gwapa ako',
        'mabuot ako',
        'pila na imo edad',
        'sin-o ka',
        'wala',
        'gwapa ako',
        'gwapo ako',
        'mabuot ako'
      ];
      for (var key in checks) {
        if (hil.containsKey(key)) {
          print('   "$key" -> "${hil[key]}"');
        } else {
          print('❌ Missing key: "$key"');
        }
      }
    } else {
      print('❌ "hil" section NOT found.');
    }
  } catch (e) {
    print('❌ Error parsing JSON: $e');
  }
}
