import "package:flutter/material.dart";
import "package:frivia/providers/game_page_provider.dart";
import "package:provider/provider.dart";

// ignore: must_be_immutable
class GamePage extends StatelessWidget {
  double? _deviceHeight, _deviceWidth;
  GamePageProvider? _pageProvider;
  String difficulty;
  GamePage({super.key, required String this.difficulty});

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return ChangeNotifierProvider(
      create: (_context) =>
          GamePageProvider(context: context, difficulty: difficulty),
      child: _buildUI(),
    );
  }

  Widget _buildUI() {
    return Builder(builder: (_context) {
      _pageProvider = _context.watch<GamePageProvider>();
      if (_pageProvider!.questions != null) {
        return Scaffold(
            body: SafeArea(
                child: Container(
          padding: EdgeInsets.symmetric(horizontal: _deviceHeight! * 0.05),
          child: _gameUI(),
        )));
      } else {
        return const Center(
            child: CircularProgressIndicator(
          color: Colors.white,
        ));
      }
    });
  }

  Widget _gameUI() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: [
        _questionText(),
        Column(
          children: [
            _trueButton(),
            SizedBox(
              height: _deviceHeight! * 0.01,
            ),
            _falseButton(),
          ],
        )
      ],
    );
  }

  Widget _questionText() {
    return Text(_pageProvider!.getCurrentQuestionText(),
        style: const TextStyle(
            color: Colors.white, fontSize: 25, fontWeight: FontWeight.w400));
  }

  Widget _trueButton() {
    return MaterialButton(
        onPressed: () {
          _pageProvider?.answerQuestion("True");
        },
        color: Colors.green,
        minWidth: _deviceWidth! * 0.8,
        height: _deviceHeight! * 0.1,
        child: const Text(
          "True",
          style: TextStyle(color: Colors.white, fontSize: 25),
        ));
  }

  Widget _falseButton() {
    return MaterialButton(
        onPressed: () {
          _pageProvider?.answerQuestion("False");
        },
        color: Colors.red,
        minWidth: _deviceWidth! * 0.8,
        height: _deviceHeight! * 0.1,
        child: const Text(
          "False",
          style: TextStyle(color: Colors.white, fontSize: 25),
        ));
  }
}
