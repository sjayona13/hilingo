import 'dart:math';
import 'package:flutter/material.dart';
import 'stats.dart';

enum QuizDifficulty { easy, intermediate, hard, assessment }

class TimedQuizPage extends StatefulWidget {
  final QuizDifficulty difficulty;
  final Duration? perQuestionDuration;

  const TimedQuizPage({
    Key? key,
    required this.difficulty,
    this.perQuestionDuration,
  }) : super(key: key);

  @override
  State<TimedQuizPage> createState() => _TimedQuizPageState();
}

class _TimedQuizPageState extends State<TimedQuizPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _timerController;
  int currentIndex = 0;
  int? selectedIndex;
  bool answered = false;

  int _score = 0;
  static int _easyScore = 0;
  static int _mediumScore = 0;
  static int _hardScore = 0;

  late final Duration questionDuration;
  late List<QuizCard> cards;

  final List<QuizCard> easyCards = [
  QuizCard(
      image: 'assets/moon.png',
      english: 'Moon',
      options: ['Bulan', 'Dagu-ob', 'Ulan', 'Adlaw'],
      correct: 'Bulan'),
  QuizCard(
      image: 'assets/rain.png',
      english: 'Rain',
      options: ['Hangin', 'Ulan', 'Duta', 'Tubig'],
      correct: 'Ulan'),
  QuizCard(
      image: 'assets/cloud.png',
      english: 'Cloud',
      options: ['Duta', 'Panganod', 'Pangpang', 'Pangpang'],
      correct: 'Panganod'),
  QuizCard(
      image: 'assets/star.png',
      english: 'Star',
      options: ['Bulak', 'Kahoy', 'Bituon', 'Balay'],
      correct: 'Bituon'),
  QuizCard(
      image: 'assets/wind.png',
      english: 'Wind',
      options: ['Hangin', 'Tubig', 'Kahoy', 'Ulan'],
      correct: 'Hangin'),
  QuizCard(
      image: 'assets/tree.png',
      english: 'Tree',
      options: ['Kahoy', 'Duta', 'Bato', 'Tubig'],
      correct: 'Kahoy'),
  QuizCard(
      image: 'assets/flower.png',
      english: 'Flower',
      options: [ 'Dahon','Bulak', 'Bunga', 'Kahoy'],
      correct: 'Bulak'),
  QuizCard(
      image: 'assets/river.png',
      english: 'River',
      options: ['Bungtod', 'Langit', 'Suba', 'Dalan'],
      correct: 'Suba'),
  QuizCard(
      image: 'assets/mountain.png',
      english: 'Mountain',
      options: ['Bukid', 'Tubig', 'Kahoy', 'Bituon'],
      correct: 'Bukid'),
  QuizCard(
      image: 'assets/fish.png',
      english: 'Fish',
      options: [ 'Manok', 'Iro', 'Ipis','Isda'],
      correct: 'Isda'),
  QuizCard(
      image: 'assets/bird.png',
      english: 'Bird',
      options: ['Pispis', 'Isda', 'Iro', 'Kanding'],
      correct: 'Pispis'),
  QuizCard(
      image: 'assets/dog.png',
      english: 'Dog',
      options: ['Man-og', 'Kanding', 'Ido', 'Isda'],
      correct: 'Ido'),
  QuizCard(
      image: 'assets/cat.png',
      english: 'Cat',
      options: ['Ido', 'Manok','Kuring',  'Kanding'],
      correct: 'Kuring'),
  QuizCard(
      image: 'assets/house.png',
      english: 'House',
      options: ['Balay', 'Kwarto', 'Eskwelahan', 'Simba'],
      correct: 'Balay'),
  QuizCard(
      image: 'assets/car.png',
      english: 'Car',
      options: ['Salakyan', 'Bangka', 'Motor', 'Traysikel'],
      correct: 'Salakyan'),
  QuizCard(
      image: 'assets/book.png',
      english: 'Book',
      options: [ 'Lapis', 'Libro','Papel', 'Lamesa'],
      correct: 'Libro'),
  QuizCard(
      image: 'assets/phone.png',
      english: 'Phone',
      options: ['Kompyuter', 'Radyo', 'Telepono', 'Telebisyon'],
      correct: 'Telepono'),
  QuizCard(
      image: 'assets/clock.png',
      english: 'Clock',
      options: ['Orasan', 'Kandila', 'Bintana', 'Pinto'],
      correct: 'Orasan'),
  QuizCard(
      image: 'assets/apple.png',
      english: 'Apple',
      options: ['Mansanas', 'Saging', 'Ubas', 'Mangga'],
      correct: 'Mansanas'),
  QuizCard(
      image: 'assets/banana.png',
      english: 'Banana',
      options: [ 'Mansanas', 'Ubas', 'Papaya','Saging'],
      correct: 'Saging'),
  QuizCard(
      image: 'assets/mango.png',
      english: 'Mango',
      options: ['Paho', 'Saging', 'Ubas', 'Lanzones'],
      correct: 'Paho'),
  QuizCard(
      image: 'assets/grape.png',
      english: 'Grape',
      options: ['Ubas', 'Mangga', 'Saging', 'Mansanas'],
      correct: 'Ubas'),
  QuizCard(
      image: 'assets/teacher.png',
      english: 'Teacher',
      options: ['Doktor', 'Pulis', 'Maestra', 'Manuglut'],
      correct: 'Maestra'),
  QuizCard(
      image: 'assets/doctor.png',
      english: 'Doctor',
      options: ['Doktor', 'Maestra', 'Manugtahi', 'Pulis'],
      correct: 'Doktor'),
  QuizCard(
      image: 'assets/police.png',
      english: 'Police',
      options: ['Sundalo','Pulis',  'Doktor', 'Tindera'],
      correct: 'Pulis'),
  QuizCard(
      image: 'assets/fireman.png',
      english: 'Fireman',
      options: ['Pulis', 'Doktor', 'Bombero', 'Limpyo'],
      correct: 'Bombero'),
      QuizCard(
    image: 'assets/sun.png',
    english: 'Sun',
    options: ['Adlaw', 'Bulan', 'Langit', 'Bituon'],
    correct: 'Adlaw'),
QuizCard(
    image: 'assets/road.png',
    english: 'Road',
    options: [ 'Suba','Dalan', 'Bukid', 'Baryo'],
    correct: 'Dalan'),
QuizCard(
    image: 'assets/leaf.png',
    english: 'Leaf',
    options: ['Bulak', 'Kahoy','Dahon',  'Bunga'],
    correct: 'Dahon'),
QuizCard(
    image: 'assets/beach.png',
    english: 'Beach',
    options: ['Suba', 'Baryo','Baybay',  'Bukid'],
    correct: 'Baybay'),
QuizCard(
    image: 'assets/hammer.png',
    english: 'Hammer',
    options: ['Kutsilyo', 'Lansang','Martilyo',  'Lamesa'],
    correct: 'Martilyo'),
QuizCard(
    image: 'assets/milk.png',
    english: 'Milk',
    options: [ 'Tubig','Gatas', 'Kape', 'Soda'],
    correct: 'Gatas'),
QuizCard(
    image: 'assets/shirt.png',
    english: 'Shirt',
    options: [ 'Pantalon', 'Sapatos', 'Bayo','Belo'],
    correct: 'Bayo'),
QuizCard(
    image: 'assets/fork.png',
    english: 'Fork',
    options: ['Kutsara','Tinidor',  'Kutsilyo', 'Plato'],
    correct: 'Tinidor'),
QuizCard(
    image: 'assets/knife.png',
    english: 'Knife',
    options: ['Tinidor', 'Basong','Kutsilyo',  'Kutsara'],
    correct: 'Kutsilyo'),
QuizCard(
    image: 'assets/chair.png',
    english: 'Chair',
    options: ['Katre', 'Lamesa', 'Bintana', 'Pulongkuan'],
    correct: 'Pulongkuan'),
QuizCard(
    image: 'assets/table.png',
    english: 'Table',
    options: ['Bintana', 'Pinto', 'Lamesa', 'Katre'],
    correct: 'Lamesa'),
QuizCard(
    image: 'assets/watch.png',
    english: 'Watch',
    options: ['Singsing', 'Kadena', 'Sapatos', 'Relo'],
    correct: 'Relo'),
QuizCard(
    image: 'assets/pen.png',
    english: 'Pen',
    options: ['Lapis', 'Bolpen', 'Papel', 'Kutsilyo'],
    correct: 'Bolpen'),
QuizCard(
    image: 'assets/paper.png',
    english: 'Paper',
    options: ['Bolpen', 'Papel', 'Mesa', 'Libro'],
    correct: 'Papel'),
QuizCard(
    image: 'assets/cup.png',
    english: 'Cup',
    options: ['Basó', 'Tinidor', 'Tasa', 'Pinggan'],
    correct: 'Tasa'),
QuizCard(
    image: 'assets/fork.png',
    english: 'Fork',
    options: ['Kutsara', 'Tinidor', 'Pinggan', 'Kutsilyo'],
    correct: 'Tinidor'),
QuizCard(
    image: 'assets/spoon.png',
    english: 'Spoon',
    options: ['Basó', 'Tinidor', 'Kutsara', 'Tasa'],
    correct: 'Kutsara'),
  ];


  final List<QuizCard> mediumCards = [
    QuizCard(
    image: 'assets/swim.png',
    english: 'Swim',
    options: ['Kaon', 'Langoy', 'Ambak', 'Dalagan'],
    correct: 'Langoy'),
QuizCard(
    image: 'assets/run.png',
    english: 'Run',
    options: ['Inom', 'Sayaw', 'Dalagan', 'Langoy'],
    correct: 'Dalagan'),
QuizCard(
    image: 'assets/sing.png',
    english: 'Sing',
    options: ['Ambak', 'Sayaw', 'Kanta', 'Tukar'],
    correct: 'Kanta'),
QuizCard(
    image: 'assets/dance.png',
    english: 'Dance',
    options: ['Saot', 'Ambak', 'Hampang', 'Kanta'],
    correct: 'Saot'),
QuizCard(
    image: 'assets/run.png',
    english: 'Run',
    options: ['Langoy', 'Dalagan', 'Ambak', 'Tindog'],
    correct: 'Dagan'),
QuizCard(
    image: 'assets/jump.png',
    english: 'Jump',
    options: ['Kaon', 'Lumpat', 'Sayaw', 'Tindog'],
    correct: 'Lumpat'),
QuizCard(
    image: 'assets/read.png',
    english: 'Read',
    options: ['Tan-aw', 'Sulat', 'Pamati', 'Basa'],
    correct: 'Basa'),
QuizCard(
    image: 'assets/write.png',
    english: 'Write',
    options: ['Pamati', 'Sulat', 'Tudlo', 'Basa'],
    correct: 'Sulat'),
QuizCard(
    image: 'assets/cook.png',
    english: 'Cook',
    options: ['Inom', 'Luto', 'Kaon', 'Tanom'],
    correct: 'Luto'),
    QuizCard(
    image: 'assets/milk.png',
    english: 'Milk',
    options: [ 'Tubig','Gatas', 'Kape', 'Soda'],
    correct: 'Gatas'),
QuizCard(
    image: 'assets/shirt.png',
    english: 'Shirt',
    options: [ 'Pantalon', 'Sapatos', 'Bayo','Belo'],
    correct: 'Bayo'),
QuizCard(
    image: 'assets/fork.png',
    english: 'Fork',
    options: ['Kutsara','Tinidor',  'Kutsilyo', 'Plato'],
    correct: 'Tinidor'),
QuizCard(
    image: 'assets/knife.png',
    english: 'Knife',
    options: ['Tinidor', 'Basong','Kutsilyo',  'Kutsara'],
    correct: 'Kutsilyo'),
  QuizCard(
      image: 'assets/truth.png',
      english: 'Truth',
      options: [ 'Buang', 'Kalayo', 'Kamatuoran','Tubig'],
      correct: 'Kamatuoran'),
  QuizCard(
      image: 'assets/justice.png',
      english: 'Justice',
      options: [ 'Kabuhi', 'Kagabhion','Hustisya', 'Kalipay'],
      correct: 'Hustisya'),
  QuizCard(
      image: 'assets/hope.png',
      english: 'Hope',
      options: ['Paglaum', 'Kahadlok','Kasubo', 'Kabuhi'],
      correct: 'Paglaum'),
  QuizCard(
      image: 'assets/faith.png',
      english: 'Faith',
      options: [ 'Pangamuyo', 'Kabuhi', 'Pagtuo','Kapasidad'],
      correct: 'Pagtuo'),
  QuizCard(
      image: 'assets/courage.png',
      english: 'Courage',
      options: [ 'Kahadlok', 'Kaisog','Paglaum', 'Kalinong'],
      correct: 'Kaisog'),
  QuizCard(
      image: 'assets/freedom.png',
      english: 'Freedom',
      options: ['Paglaum', 'Pagtuo', 'Kalayaan', 'Kahadlok'],
      correct: 'Kalayaan'),
  QuizCard(
      image: 'assets/peace.png',
      english: 'Peace',
      options: ['Kalinong', 'Giyera', 'Kalisod', 'Kasakit'],
      correct: 'Kalinong'),
  QuizCard(
      image: 'assets/love.png',
      english: 'Love',
      options: [ 'Kabuhi', 'Pagtuo', 'Gugma','Paglaum'],
      correct: 'Gugma'),
  QuizCard(
      image: 'assets/truth.png',
      english: 'Honesty',
      options: ['Pagpasaylo','Pagkamatuod',  'Kalipay', 'Pagtuo'],
      correct: 'Pagkamatuod'),
  QuizCard(
      image: 'assets/faith.png',
      english: 'Belief',
      options: ['Pagtoo', 'Paglaum', 'Pagbantay', 'Pagdula'],
      correct: 'Pagtoo'),
  QuizCard(
      image: 'assets/love.png',
      english: 'Heart',
      options: ['Tagipusuon', 'Palangga', 'Paglaum', 'Pagtuo'],
      correct: 'Tagipusuon'),
  QuizCard(
      image: 'assets/forgiveness.png',
      english: 'Mercy',
      options: [ 'Kaisog', 'Kahadlok', 'Kaluoy','Pagtuo'],
      correct: 'Kaluoy'),
  QuizCard(
      image: 'assets/wisdom.png',
      english: 'Wisdom',
      options: ['Kabuhi', 'Paglaum', 'Kaalam', 'Pagkatuod'],
      correct: 'Kaalam'),
  QuizCard(
      image: 'assets/truth.png',
      english: 'Reality',
      options: ['Kamatuoran', 'Handum', 'Paglaum', 'Kasubo'],
      correct: 'Kamatuoran'),
  QuizCard(
      image: 'assets/courage.png',
      english: 'Bravery',
      options: ['Kaisog', 'Kaluoy', 'Pagtuo', 'Kalipay'],
      correct: 'Kaisog'),
  QuizCard(
      image: 'assets/truth.png',
      english: 'Fact',
      options: ['Kamatuoran', 'Bunggo', 'Buhat', 'Balay'],
      correct: 'Kamatuoran'),
  QuizCard(
      image: 'assets/hope.png',
      english: 'Dream',
      options: ['Handum', 'Pagtuo', 'Paglaum', 'Kabuhi'],
      correct: 'Handum'),
  QuizCard(
      image: 'assets/justice.png',
      english: 'Right',
      options: ['Husto', 'Sayop', 'Tama', 'Peke'],
      correct: 'Husto'),
  QuizCard(
      image: 'assets/truth.png',
      english: 'Honesty',
      options: [ 'Kabuhi', 'Pagtuo','Pagkamatuod', 'Paglaum'],
      correct: 'Pagkamatuod'),
  QuizCard(
    image: 'assets/courage.png',
    english: 'Courage',
    options: ['Kaisog', 'Kusog', 'Kahadlok', 'Kalipay'],
    correct: 'Kaisog'),
QuizCard(
    image: 'assets/sacrifice.png',
    english: 'Sacrifice',
    options: [ 'Pagtuo', 'Pagrespeto', 'Sakripisyo','Pagbaton'],
    correct: 'Sakripisyo'),
QuizCard(
    image: 'assets/truth.png',
    english: 'Truth',
    options: ['Kamatuoran', 'Kabutigan', 'Kasadya', 'Kasubo'],
    correct: 'Kamatuoran'),
  ];


  final List<QuizCard> hardCards = [
QuizCard(
    image: 'assets/courage.png',
    english: 'Courage',
    options: ['Kaisog', 'Kusog', 'Kahadlok', 'Kalipay'],
    correct: 'Kaisog'),
QuizCard(
    image: 'assets/visitor.png',
    english: 'Visitor',
    options: [ 'Pagtuo', 'Pagrespeto', 'Bisita','Pagbaton'],
    correct: 'Bisita'),
QuizCard(
    image: 'assets/truth.png',
    english: 'Truth',
    options: ['Kamatuoran', 'Kabutigan', 'Kasadya', 'Kasubo'],
    correct: 'Kamatuoran'),
    QuizCard(
      image: 'assets/faith.png',
      english: 'Belief',
      options: ['Pagtoo', 'Paglaum', 'Pagbantay', 'Pagdula'],
      correct: 'Pagtoo'),
  QuizCard(
      image: 'assets/forgiveness.png',
      english: 'Mercy',
      options: [ 'Kaisog', 'Kahadlok', 'Kaluoy','Pagtuo'],
      correct: 'Kaluoy'),
QuizCard(
    image: 'assets/promise.png',
    english: 'Promise',
    options: [ 'Handum', 'Panumdum', 'Promiso','Pagtuon'],
    correct: 'Promiso'),
QuizCard(
    image: 'assets/patience.png',
    english: 'Patience',
    options: [ 'Paglaum', 'Palangga', 'Pagpugong','Pagtuo'],
    correct: 'Pagpugong'),
QuizCard(
    image: 'assets/truth.png',
    english: 'Trust',
    options: ['Pagtuo','Pagsalig',  'Pagbaton', 'Palangga'],
    correct: 'Pagsalig'),
QuizCard(
    image: 'assets/humility.png',
    english: 'Humility',
    options: [ 'Pagpasigarbo', 'Pagtuo','Pagpaubos', 'Pagbaton'],
    correct: 'Pagpaubos'),
QuizCard(
    image: 'assets/honesty.png',
    english: 'Honesty',
    options: ['Pagkamatuod', 'Pagtuo', 'Pagbaton', 'Pagsalig'],
    correct: 'Pagkamatuod'),
QuizCard(
    image: 'assets/forgiveness.png',
    english: 'Forgiveness',
    options: ['Paglaum', 'Palangga', 'Pagpaumod', 'Pagbaton'],
    correct: 'Pagpaumod'),
QuizCard(
    image: 'assets/gratitude.png',
    english: 'Gratitude',
    options: ['Pagpasalamat', 'Palangga', 'Pagtuon', 'Pagpugong'],
    correct: 'Pagpasalamat'),
QuizCard(
    image: 'assets/peace.png',
    english: 'Peace',
    options: ['Kalinong', 'Kagamo', 'Kasubo', 'Kahadlok'],
    correct: 'Kalinong'),
QuizCard(
    image: 'assets/faith.png',
    english: 'Faith',
    options: [ 'Paglaum', 'Palangga', 'Pagtuo','Pagbaton'],
    correct: 'Pagtuo'),
QuizCard(
    image: 'assets/hope.png',
    english: 'Hope',
    options: ['Paglaum', 'Pagtuo', 'Palangga', 'Pagbaton'],
    correct: 'Paglaum'),
QuizCard(
    image: 'assets/strength.png',
    english: 'Strength',
    options: ['Kaisog', 'Pagtuon','Kusog',  'Pagpugong'],
    correct: 'Kusog'),
QuizCard(
    image: 'assets/respect.png',
    english: 'Respect',
    options: [ 'Pagbaton', 'Palangga', 'Pagtuo','Pagrespeto'],
    correct: 'Pagrespeto'),
QuizCard(
    image: 'assets/charity.png',
    english: 'Charity',
    options: ['Paghatag', 'Palangga', 'Pagpasaylo', 'Pagpugong'],
    correct: 'Paghatag'),
QuizCard(
    image: 'assets/wisdom.png',
    english: 'Wisdom',
    options: ['Kaalam', 'Katarungan', 'Pagtuon', 'Kaisog'],
    correct: 'Kaalam'),
QuizCard(
    image: 'assets/discipline.png',
    english: 'Discipline',
    options: ['Disiplina', 'Pagpugong', 'Pagbaton', 'Pagtuon'],
    correct: 'Disiplina'),
QuizCard(
    image: 'assets/unity.png',
    english: 'Communal Unity',
    options: [ 'Kalinong', 'Bayanihan','Katarungan', 'Pagtuon'],
    correct: 'Bayanihan'),




    QuizCard(
    image: 'assets/resilience.png',
    english: 'Resilience',
    options: ['Pagtuo', 'Pagpangabudlay', 'Paglaum', 'Kaisog'],
    correct: 'Pagpangabudlay'),
QuizCard(
    image: 'assets/conscience.png',
    english: 'Conscience',
    options: ['Kalag', 'Kasingkasing', 'Konsensya', 'Hunahuna'],
    correct: 'Konsensya'),
QuizCard(
    image: 'assets/ambition.png',
    english: 'Ambition',
    options: ['Tinguha', 'Ambisyon', 'Pangandoy', 'Paglaum'],
    correct: 'Ambisyon'),
QuizCard(
    image: 'assets/betrayal.png',
    english: 'Betrayal',
    options: ['Pagtuo', 'Pagtraidor', 'Pagpangayo', 'Pagpasaylo'],
    correct: 'Pagtraidor'),
QuizCard(
    image: 'assets/eternity.png',
    english: 'Eternity',
    options: ['Tinguha', 'Tadhana', 'Wala Katapusan', 'Kabuhi'],
    correct: 'Wala Katapusan'),
QuizCard(
    image: 'assets/chaos.png',
    english: 'Chaos',
    options: ['Kasadya', 'Kagamo', 'Kahapsay', 'Kalinong'],
    correct: 'Kagamo'),
QuizCard(
    image: 'assets/mystery.png',
    english: 'Mystery',
    options: ['Kalibutan', 'Paglaum', 'Misteryo', 'Tinguha'],
    correct: 'Misteryo'),
  ];

  bool _showCountdown = false;
  int _countdown = 3;

  @override
  void initState() {
    super.initState();
    cards = _getCardsForDifficulty(widget.difficulty);
    questionDuration =
        widget.perQuestionDuration ?? _durationForDifficulty(widget.difficulty);

    // Shuffle the cards to randomize order each time
    cards.shuffle();

    _timerController = AnimationController(
      vsync: this,
      duration: questionDuration,
    )
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed && !answered) {
          setState(() {
            answered = true;
          });
        }
      })
      ..addListener(() {
        if (mounted) setState(() {});
      });
    _timerController.forward(from: 0);
  }

  @override
  void dispose() {
    _timerController.dispose();
    super.dispose();
  }

  List<QuizCard> _getCardsForDifficulty(QuizDifficulty difficulty) {
    switch (difficulty) {
      case QuizDifficulty.easy:
        return _pickRandom(easyCards, 25);
      case QuizDifficulty.intermediate:
        return _pickRandom(mediumCards, 15);
      case QuizDifficulty.hard:
        return _pickRandom(hardCards, 10);
      default:
        return [];
    }
  }

  // ✅ Prevents duplicates by sampling unique random questions
  List<QuizCard> _pickRandom(List<QuizCard> source, int count) {
    final random = Random();
    final result = <QuizCard>[];

    final shuffled = List<QuizCard>.from(source)..shuffle(random);
    final takeCount = count > shuffled.length ? shuffled.length : count;

    for (int i = 0; i < takeCount; i++) {
      // Also shuffle options for each question
      final options = List<String>.from(shuffled[i].options)..shuffle(random);
      result.add(QuizCard(
        image: shuffled[i].image,
        english: shuffled[i].english,
        options: options,
        correct: shuffled[i].correct,
      ));
    }
    return result;
  }

  Duration _durationForDifficulty(QuizDifficulty difficulty) {
    switch (difficulty) {
      case QuizDifficulty.easy:
        return const Duration(seconds: 10);
      case QuizDifficulty.intermediate:
        return const Duration(seconds: 8);
      case QuizDifficulty.hard:
        return const Duration(seconds: 6);
      case QuizDifficulty.assessment:
        return const Duration(seconds: 4);
    }
  }

  void checkAnswer(int index) {
    if (answered) return;
    setState(() {
      selectedIndex = index;
      answered = true;
      if (cards[currentIndex].options[index] == cards[currentIndex].correct) {
        _score++;
      }
      _timerController.stop();
    });
  }

  void nextCard() {
    setState(() {
      if (currentIndex < cards.length - 1) {
        currentIndex++;
        selectedIndex = null;
        answered = false;
        _timerController
          ..duration = questionDuration
          ..forward(from: 0);
      } else {
        _handleNextLevel();
      }
    });
  }

  void _startCountdown(VoidCallback onComplete) {
    setState(() {
      _showCountdown = true;
      _countdown = 3;
    });

    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
      if (_countdown > 1) {
        setState(() => _countdown--);
        return true;
      } else {
        setState(() {
          _showCountdown = false;
        });
        onComplete();
        return false;
      }
    });
  }

  void _handleNextLevel() {
    if (widget.difficulty == QuizDifficulty.easy) {
      _easyScore = _score;
      _startCountdown(() {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (_) =>
                  TimedQuizPage(difficulty: QuizDifficulty.intermediate)),
        );
      });
    } else if (widget.difficulty == QuizDifficulty.intermediate) {
      _mediumScore = _score;
      _startCountdown(() {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (_) =>
                  TimedQuizPage(difficulty: QuizDifficulty.hard)),
        );
      });
    } else if (widget.difficulty == QuizDifficulty.hard) {
      _hardScore = _score;
      _showFinalStats();
    }
  }

  void _showFinalStats() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => StatsPage(
          easyScore: _easyScore,
          easyTotal: 25,
          mediumScore: _mediumScore,
          mediumTotal: 15,
          hardScore: _hardScore,
          hardTotal: 10,
        ),
      ),
    );
  }

  String _titleForDifficulty() {
    switch (widget.difficulty) {
      case QuizDifficulty.easy:
        return 'Easy';
      case QuizDifficulty.intermediate:
        return 'Intermediate';
      case QuizDifficulty.hard:
        return 'Hard';
      case QuizDifficulty.assessment:
        return 'Assessment';
    }
  }

  @override
  Widget build(BuildContext context) {
    final card = cards[currentIndex];

    return Scaffold(
      body: Stack(
        children: [
          const AnimatedGradientBackground(),
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Text(
                      _titleForDifficulty(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: Text(
                        '${currentIndex + 1} / ${cards.length}',
                        style:
                            const TextStyle(color: Colors.white70, fontSize: 16),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  transitionBuilder: (child, animation) =>
                      ScaleTransition(scale: animation, child: child),
                  child: QuestionCard(card: card, key: ValueKey(currentIndex)),
                ),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  alignment: WrapAlignment.center,
                  children: List.generate(card.options.length, (index) {
                    final option = card.options[index];
                    final isSelected = selectedIndex == index;
                    final isRight = option == card.correct;

                    Color buttonColor = Colors.white70;
                    Color textColor = const Color.fromARGB(255, 8, 45, 76);
                    Border? borderGlow;

                    if (answered) {
                      if (isRight) {
                        borderGlow = Border.all(
                          color: Colors.greenAccent,
                          width: 3,
                        );
                      } else if (isSelected && !isRight) {
                        borderGlow = Border.all(
                          color: Colors.redAccent,
                          width: 3,
                        );
                      } else if (!isSelected && isRight) {
                        borderGlow = Border.all(
                          color: Colors.greenAccent,
                          width: 3,
                        );
                      }
                    }

                    return AnimatedScale(
                      scale: (answered && isSelected && !isRight)
                          ? 0.95
                          : (answered && isRight)
                              ? 1.05
                              : 1.0,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOutBack,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: borderGlow,
                        ),
                        child: SizedBox(
                          width: 160,
                          height: 60,
                          child: ElevatedButton(
                            onPressed: answered ? null : () => checkAnswer(index),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: buttonColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              option,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: textColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  height: 60,
                  width: 60,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CircularProgressIndicator(
                        value: _timerController.value,
                        strokeWidth: 6,
                        backgroundColor: Colors.white24,
                        valueColor:
                            const AlwaysStoppedAnimation<Color>(Colors.greenAccent),
                      ),
                      Text(
                        '${((1 - _timerController.value) * questionDuration.inSeconds).ceil()}',
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    onPressed: answered ? nextCard : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      padding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 100),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('Next',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  ),
                )
              ],
            ),
          ),
          if (_showCountdown)
            Container(
              color: Colors.black54,
              alignment: Alignment.center,
              child: Text(
                _countdown > 0 ? '$_countdown' : 'GO!',
                style: const TextStyle(
                    fontSize: 72,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
              ),
            ),
        ],
      ),
    );
  }
}

// Background
class AnimatedGradientBackground extends StatefulWidget {
  const AnimatedGradientBackground({super.key});

  @override
  State<AnimatedGradientBackground> createState() =>
      _AnimatedGradientBackgroundState();
}

class _AnimatedGradientBackgroundState
    extends State<AnimatedGradientBackground> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _color1;
  late Animation<Color?> _color2;
  late Animation<Color?> _color3;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 6))
          ..repeat(reverse: true);

    _color1 = ColorTween(begin: const Color(0xFF0D47A1), end: const Color(0xFF1565C0))
        .animate(_controller);
    _color2 = ColorTween(begin: const Color(0xFF1976D2), end: const Color(0xFF1E88E5))
        .animate(_controller);
    _color3 = ColorTween(begin: const Color(0xFF0B3D91), end: const Color(0xFF0D47A1))
        .animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [_color1.value!, _color2.value!, _color3.value!, Colors.black],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        );
      },
    );
  }
}

class QuestionCard extends StatelessWidget {
  final QuizCard card;

  const QuestionCard({Key? key, required this.card}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      key: key,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white12,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white38),
      ),
      child: Column(
        children: [
          Text(
            card.english,
            style: const TextStyle(
                fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 16),
          CircleAvatar(
            radius: 70,
            backgroundColor: Colors.white10,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(70),
              child: Image.asset(card.image,
                  height: 140, width: 140, fit: BoxFit.cover),
            ),
          ),
        ],
      ),
    );
  }
}

class QuizCard {
  final String image;
  final String english;
  final List<String> options;
  final String correct;

  QuizCard({
    required this.image,
    required this.english,
    required this.options,
    required this.correct,
  });
}
