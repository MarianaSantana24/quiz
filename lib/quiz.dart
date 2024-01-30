import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  int currentQuestionIndex = 0; //Indice da pergunta atual
  String? selectedAnswer;
  bool? isCorrect;
  final List<Map<String, dynamic>> questions = [
    {
      'question':
          'Qual dester animais é conhecido por suas impressionante capacidade de mudar de cor?',
      'answers': ['Baleia', 'Tubarão', 'Polvo', 'Golfinho'],
      'correctAnswer': 'Polvo'
    },
    {
      'question':
          'Qual animal marinho é famoso por sua carapuça dura e longa vida?',
      'answers': [
        'Baleia azul',
        'Carangueijo',
        'Tartaruga Marinha',
        'Estrela do mar'
      ],
      'correctAnswer': 'Tartaruga Marinha'
    },
    //Adicione mais perguntas aqui
  ];
  void nextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    } else {
      //fim do quiz, fazer algo aqui
    }
  }

  void handleAnswer(String answer) {
    setState(() {
      selectedAnswer = answer;
      isCorrect = answer == questions[currentQuestionIndex]['correctAnswer'];
    });
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        selectedAnswer = null;
        isCorrect = null;
        if (currentQuestionIndex < questions.length - 1) {
          currentQuestionIndex++;
        } else {
          //fim
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var currentQuestion = questions[currentQuestionIndex];
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.deepPurple[50],
          title: Text('Quiz marítimo!',
              style: GoogleFonts.roboto(fontWeight: FontWeight.bold))),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            color: Colors.deepPurple[50],
            width: double.infinity,
            height: 400,
            child: Center(
              child: Text(
                currentQuestion['question'],
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
          ),
          Wrap(
              children: currentQuestion['answers'].map<Widget>((resposta) {
            bool isSelected = selectedAnswer == resposta;
            Color? buttonColor;
            if (isSelected) {
              buttonColor = isCorrect! ? Colors.green : Colors.red;
            }

            return meuBtn(
              resposta, () => handleAnswer(resposta), buttonColor);
          }).toList(),
          ),
        ],
      ),
    );
  }
}

Widget meuBtn(String resposta, VoidCallback onPressed, Color? color) =>
    Container(
      margin: const EdgeInsets.all(16),
      width: 160,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
        ),
        child: Text(resposta),
      ),
    );
