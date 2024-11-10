import "dart:convert";

import "package:flutter/material.dart";
import "package:dio/dio.dart";

class GamePageProvider extends ChangeNotifier {
  final _dio = Dio();
  final int _maxQuestions = 10;
  List? questions;
  int _currentQuestionCount = 0;
  BuildContext? context;
  int _score = 0;
  String difficulty;

  GamePageProvider({required this.context, required this.difficulty}) {
    _dio.options.baseUrl = "https://opentdb.com/api.php";
    _getQuestionsFromAPI();
  }

  Future<void> _getQuestionsFromAPI() async {
    var _response = await _dio.get(
      '',
      queryParameters: {
        "amount": _maxQuestions,
        "type": "boolean",
        "difficulty": difficulty.toLowerCase(),
      },
    );
    var _data = jsonDecode(_response.toString());
    questions = _data["results"];
    notifyListeners();
  }

  String getCurrentQuestionText() {
    return questions![_currentQuestionCount]["question"];
  }

  void answerQuestion(String _ans) async {
    bool isCorrect =
        questions![_currentQuestionCount]["correct_answer"] == _ans;
    _currentQuestionCount++;
    if (isCorrect) {
      _score++;
    }
    showDialog(
        context: context!,
        builder: (BuildContext _context) {
          return AlertDialog(
            backgroundColor: isCorrect ? Colors.green : Colors.red,
            title: Icon(
              isCorrect ? Icons.check_circle : Icons.cancel_sharp,
              color: Colors.white,
            ),
          );
        });
    await Future.delayed(const Duration(seconds: 1));
    Navigator.pop(context!);
    if (_currentQuestionCount == _maxQuestions) {
      await endGame();
    } else {
      notifyListeners();
    }
  }

  Future<void> endGame() async {
    showDialog(
        context: context!,
        builder: (BuildContext _context) {
          return AlertDialog(
            backgroundColor: Colors.blue,
            title: const Text(
              "Game Over",
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            content: Text("Score: $_score/10"),
          );
        });
    await Future.delayed(const Duration(seconds: 3));
    Navigator.pop(context!);
    Navigator.pop(context!);
  }
}
