from flask import Flask, request, jsonify
from flask_cors import CORS
import json
import os
import re

app = Flask(__name__)
CORS(app)

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
DICT_PATH = os.path.join(BASE_DIR, "dictionary.json")

# Load dictionary
try:
    with open(DICT_PATH, "r", encoding="utf-8") as f:
        dictionary = json.load(f)
        print(f"Loaded dictionary with {len(dictionary.get('eng', {}))} English entries.")
except FileNotFoundError:
    print(f"dictionary.json not found in {BASE_DIR}")
    dictionary = {}

def translate_text(text, source_dict):
    text = text.lower().strip()
    words = text.split()
    translated = []
    i = 0

    while i < len(words):
        match_found = False
        # Try longest phrases first (from remaining words)
        for j in range(len(words), i, -1):
            phrase = ' '.join(words[i:j])
            if phrase in source_dict:
                translated.append(source_dict[phrase])
                i = j
                match_found = True
                break
        if not match_found:
            # Fallback: copy untranslated word as-is
            translated.append(words[i])
            i += 1

    return ' '.join(translated)

@app.route("/translate", methods=["POST"])
def translate():
    data = request.get_json(force=True)
    text = data.get("text", "").strip()
    source_lang = data.get("source_lang", "eng")
    target_lang = data.get("target_lang", "hil")

    if not text:
        return jsonify({"translation": "No text provided"}), 400
    if source_lang not in dictionary:
        return jsonify({"translation": f"Source language '{source_lang}' not found"}), 400

    source_dict = dictionary[source_lang]
    translation = translate_text(text, source_dict)
    return jsonify({"translation": translation})

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)
