import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz/data/questions.dart';
import 'package:quiz/questions_summary/questions_summary.dart';

class ResultsScreen extends StatelessWidget{
  const ResultsScreen({super.key, required this.chosenAnswer, required this.onRestart, required this.exist});

  final List<String> chosenAnswer;
  final void Function() onRestart;
  final void Function() exist;

  List <Map<String, Object>> getSummaryData(){
    final List<Map<String, Object>> summary =[];

    for (var i=0; i<chosenAnswer.length; i++){
      summary.add({
        'question_index':i,
        'question':questions[i].text,
        'correct_answer': questions[i].answers[0],
        'user_answer': chosenAnswer[i]
      });
    }
    return summary;
  }

  @override

  Widget build(BuildContext context){

    final summaryData= getSummaryData();
    final numTotalQuestions=questions.length;
    final numCorrectQuestions= summaryData.where((data){
      return data['user_answer']== data['correct_answer'];
    }).length;


    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           Text('You answer $numCorrectQuestions out of $numTotalQuestions questions correctly!',
           style: GoogleFonts.ubuntu(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
           ),
           ),
            const SizedBox(
              height: 30,
            ),
             const Text('List of answer and question....'),
             QuestionsSummary(summaryData: summaryData),
            const SizedBox(
              height: 30,
              ),
           OutlinedButton.icon(
            onPressed: onRestart, 
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
            ),
            icon: const Icon(Icons.refresh),
            label: const Text('Restart Quiz'),
          ),
          OutlinedButton.icon(
            onPressed: exist, 
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
            ),
            icon: const Icon(Icons.exit_to_app),
            label: const Text('Exit'),
          ),
          ],
        ),
      ),
    );
  }
}