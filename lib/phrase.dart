class Phrase {
  final String english;
  final String hiligaynon;

  Phrase({required this.english, required this.hiligaynon});

  // Used to check if it's already in favorites
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Phrase &&
          runtimeType == other.runtimeType &&
          english == other.english &&
          hiligaynon == other.hiligaynon;

  @override
  int get hashCode => english.hashCode ^ hiligaynon.hashCode;
}
