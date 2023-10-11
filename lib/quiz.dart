import 'package:flutter/material.dart';
import 'package:quiz/data/questions.dart';
import 'package:quiz/questions_screen.dart';
import 'package:quiz/results_screen.dart';
import 'package:quiz/start_screen.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
   List<String> selectedAnswer=[];
  var activeScreen = 'start-screen';

  void switchScreen() {
    setState(() {
      activeScreen = 'questions-screen';
    });
  }

  void chooseAnswer(String answer){
    selectedAnswer.add(answer);

    if (selectedAnswer.length == questions.length){
      setState(() {
        //selectedAnswer=[];
        activeScreen='results-screen';
      });
    }
  }

  void restartQuiz (){
    setState(() {
      selectedAnswer=[];
      activeScreen='questions-screen';
    });
  }
  
  void exitQuiz (){
    setState(() {
      selectedAnswer=[];
      activeScreen='start-screen';
    });
  }

  @override
  Widget build(BuildContext context) {

    // final screenWidget = activeScreen == 'start-screen'
    //   ? StartScreen(switchScreen)
    //   : const QuestionScreen();

    Widget screenWidget = StartScreen(switchScreen);
    if (activeScreen == 'questions-screen') {
      screenWidget = QuestionScreen(
        onSelectAnswer: chooseAnswer,
      );
    }

    if (activeScreen == 'results-screen'){
      screenWidget = ResultsScreen(
        chosenAnswer: selectedAnswer,
        onRestart: restartQuiz,
       exist: exitQuiz,
      );
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 78, 13, 151),
              Color.fromARGB(255, 107, 15, 168),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )),
          child: screenWidget,
        ),
      ),
    );
  }
}
