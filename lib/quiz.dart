import 'package:flutter/material.dart';
import 'package:h2/data/questions.dart';
import 'package:h2/questions_screen.dart';
import 'package:h2/results_screen.dart';
import 'package:h2/start_screen.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});
  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}



class _QuizState extends State<Quiz> {
  List<String> _selectedAnswers = [];
  var _activeScreen = 'start-screen';
  void switchScreen() {
    setState(() {
      _activeScreen = 'questions-screen';
    });
  }
  
  void choseAnswer(String answer) {
    _selectedAnswers.add(answer);

    if (_selectedAnswers.length == questions.length) {
      setState(() {
        _activeScreen = 'result-screen';
      });
    }
  }
  void restartQuiz(){
 setState(() {
   _selectedAnswers=[];
   _activeScreen = 'questions-screen';
 });
  }



  @override
  Widget build(BuildContext context) {
    Widget screenWidget = StartScreen(switchScreen);

    if (_activeScreen == 'questions-screen') {
      screenWidget = QuestionsScreen(
        onSelectAnswer: choseAnswer,
      );
    }
    if(_activeScreen=='result-screen'){
      screenWidget = ResultScreen(chosenAnswers: _selectedAnswers,onRestart: restartQuiz,);
    }
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 44, 176, 39),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color.fromARGB(255, 98, 223, 251), Color.fromARGB(255, 43, 71, 91)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: screenWidget,
        ),
      ),
    );
  }
}