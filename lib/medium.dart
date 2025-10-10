import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'score.dart';

class MediumPage extends StatefulWidget {
  const MediumPage({Key? key}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class Question {
  final String phrase;
  final List<String> options;
  final String correct;

  Question({required this.phrase, required this.options, required this.correct});
}

class _QuizPageState extends State<MediumPage> {
  int _currentIndex = 0;
  int? _selectedIndex;
  bool _answered = false;
  int _score = 0;

  late ConfettiController _confettiController;

  final List<Question> _allQuestions = [
    Question(
        phrase: 'I will return later',
        options: ['Mabalik ko karon', 'Maghalin ko karon', 'Maghulat ko diri'],
        correct: 'Mabalik ko karon'),
    Question(
        phrase: 'Where can I find water?',
        options: ['San-o ko makit-an ang tubig?', 'Diin ko makakita sang tubig?', 'Pila ang tubig?'],
        correct: 'Diin ko makakita sang tubig?'),
    Question(
        phrase: 'I do not understand',
        options: [ 'Gusto ko intindihon', 'Hibaloon ko ini','Indi ko kaintindi'],
        correct: 'Indi ko kaintindi'),
    Question(
        phrase: 'Can you speak slowly?',
        options: ['Dali ka maghambal?', 'Pwede ka kahambal hinay?','Maghambal ka sing maayo?'],
        correct: 'Pwede ka kahambal hinay?'),
    Question(
        phrase: 'I am looking for the market',
        options: ['Gina pangita ko ang merkado', 'Ginahalinan ko ang merkado', 'Ara ko sa merkado'],
        correct: 'Gina pangita ko ang merkado'),
    Question(
        phrase: 'How much does it cost?',
        options: ['Tagpila ini?', 'Pila ka oras?', 'Pila ka adlaw?'],
        correct: 'Tagpila ini?'),
    Question(
        phrase: 'I need help immediately',
        options: ['Kinahanglan ko bulig subong', 'Magabulig ako sa imo', 'Buligi ko anay'],
        correct: 'Kinahanglan ko bulig subong'),
    Question(
        phrase: 'Where is the comfort room?',
        options: ['Diin ang kasilyas?', 'Pila ang kasilyas?', 'May ara ka kasilyas?'],
        correct: 'Diin ang kasilyas?'),
    Question(
        phrase: 'I lost my bag',
        options: [ 'Ara ang akong bag','Nadula ang akon bag', 'Dal-a ang akong bag'],
        correct: 'Nadula ang akon bag'),
    Question(
        phrase: 'I will call you tomorrow',
        options: ['Tawgan taka bwas', 'Tawgon ta ikaw subong', 'Ginatawag ta ikaw kada adlaw'],
        correct: 'Tawgan taka bwas'),
          Question(
      phrase: 'Where are you going?',
      options: ['Diin ka makadto?','San-o ka makadto?','Paano ka makadto?',],
      correct: 'Diin ka makadto?'),
  Question(
      phrase: 'I will meet you there',
      options: ['Makita ta ikaw didto.','Kitaay ta didto','Makita ko ikaw karon.',],
      correct: 'MKitaay ta didto'),
  Question(
      phrase: 'What time is it?',
      options: ['Ano oras na?','Paano oras na?','San-o ang oras?',],
      correct: 'Ano oras na?'),
  Question(
      phrase: 'I am not feeling well.',
      options: ['Kapoy ako','Indi maayo pamatyag ko','Wala ko gana'],
      correct: 'Indi maayo pamatyag ko'),
  Question(
      phrase: 'Where did you come from?',
      options: ['Diin ka halin?','Paano ka naghalin?','Diin ka nagaistar?'],
      correct: 'Diin ka halin?'),
  Question(
      phrase: 'I forgot my wallet',
      options: ['Nalimtan ko ang pitaka ko','Nabilin ang pitaka ko','Nadula ang pitaka ko',],
      correct: 'Nalimtan ko ang pitaka ko'),
  Question(
      phrase: 'Can you help me with this?',
      options: ['Palihog, buligi ko ini.','Mahimo mo ko buligan sini?','Pwede mo ni?'],
      correct: 'Mahimo mo ko buligan sini?'),
  Question(
      phrase: 'What is your favorite food?',
      options: ['Ano gusto mo kaunon?','Paborito mo ini?','Ano paborito mo nga pagkaon?' ],
      correct: 'Ano paborito mo nga pagkaon?'),
  Question(
      phrase: 'I am very tired',
      options: ['Wala ko tulog','Gusto ko magpahuway','Kapoy gid ako'],
      correct: 'Kapoy gid ako.'),
  Question(
      phrase: 'Where can I buy tickets?',
      options: ['Diin ko mabakal tiket?','San-o ko mabakal tiket?','Diin may ara tiket?',],
      correct: 'Diin ko mabakal tiket?'),
  Question(
      phrase: 'I am going to the store',
      options: ['Magaadto ako sa merkado','Makadto ako sa tyangge','Ara ko sa tindahan', ],
      correct: 'Makadto ako sa tyangge'),
  Question(
      phrase: 'What happened?',
      options: ['Ano ang natabo?','Paano ini natabo?','San-o natabo?',],
      correct: 'Ano ang natabo?'),
  Question(
      phrase: 'I think it will rain',
      options: ['Daw ma-ulan na','Mag-ulan subong','Mag-ulan karon',],
      correct: 'Daw mag-ulan na.'),
  Question(
      phrase: 'How far is the market?',
      options: ['Layo pa ang merkado?','Diin ang merkado?','Ano kadugay ang merkado?',],
      correct: 'Layo pa ang merkado?'),
  Question(
      phrase: 'I need to charge my phone.',
      options: ['Indi na ako makagamit phone','Kinahanglan ko i-charge ang Cellphone ko','Gusto ko mag-charge'],
      correct: 'Kinahanglan ko i-charge ang Cellphone ko'),
  Question(
      phrase: 'Can you show me the way?',
      options: ['Ipakita mo sa akon.','Pwede mo ipakita sa akon ang dalan?','Diin ang dalan?'],
      correct: 'Pwede mo ipakita sa akon ang dalan?'),
  Question(
      phrase: 'I will come back tomorrow',
      options: ['Mabalik ako buwas','Mabalik ako subong','Mabalik ako sa sunod semana' ],
      correct: 'Mabalik ako buwas'),
  Question(
      phrase: 'What are you doing?',
      options: ['Ano imo pangalan?','Ano ginahimo mo?','Ano imo plano?'],
      correct: 'Ano ginahimo mo?'),
  ];

  late List<Question> _questions;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 2));
    _loadNewSet();
  }

  void _loadNewSet() {
    setState(() {
      _questions = List.from(_allQuestions)..shuffle();
      _questions = _questions.take(10).toList();
      _currentIndex = 0;
      _score = 0;
      _answered = false;
      _selectedIndex = null;
    });
  }

  void _nextQuestion() {
    if (_currentIndex < _questions.length - 1) {
      setState(() {
        _currentIndex++;
        _selectedIndex = null;
        _answered = false;
      });
    } else {
      
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ScorePage(score: _score, total: _questions.length),
        ),
      );
    }
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final question = _questions[_currentIndex];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Color(0xFF2A7BE6)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16, top: 12),
            child: Text(
              '${_currentIndex + 1}/${_questions.length}',
              style: const TextStyle(
                color: Color(0xFF878282),
                fontFamily: 'Kumbh',
                fontWeight: FontWeight.w400,
                fontSize: 18,
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 8),
            const Center(
              child: Text(
                'Choose the correct translation',
                style: TextStyle(
                  fontFamily: 'Kumbh',
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                  color: Color(0xFF878282),
                ),
              ),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 155,
                  height: 188,
                  child: Image.asset('assets/boy.png', fit: BoxFit.contain),
                ),
                const SizedBox(width: 16),
                Container(
                  width: 153,
                  height: 115,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFF878282)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    question.phrase,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: 'Kumbh',
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Color(0xFF878282),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            ...List.generate(question.options.length, (index) {
              final option = question.options[index];
              Color borderColor = const Color(0xFF878282);
              Color textColor = const Color(0xFF878282);
              if (_answered) {
                if (option == question.correct) {
                  borderColor = Colors.green;
                  textColor = Colors.green;
                } else if (_selectedIndex == index) {
                  borderColor = Colors.red;
                  textColor = Colors.red;
                }
              }
              return Container(
                width: 258,
                height: 46,
                margin: const EdgeInsets.only(bottom: 12),
                child: OutlinedButton(
                  onPressed: _answered
                      ? null
                      : () {
                          setState(() {
                            _selectedIndex = index;
                            _answered = true;
                            if (option == question.correct) _score++;
                          });
                        },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: borderColor),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Text(
                    option,
                    style: TextStyle(
                      color: textColor,
                      fontFamily: 'Kumbh',
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                ),
              );
            }),
          const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 120),
              child: SizedBox(
                width: 300,
                height: 50,
                child: ElevatedButton(
                  onPressed: _answered ? _nextQuestion : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2A7BE6),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Kumbh',
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
