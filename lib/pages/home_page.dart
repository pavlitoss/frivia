import "package:flutter/material.dart";
import "package:frivia/pages/game_page.dart";

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _currentDifficulty = "Easy";
  double difficulty = 0;
  double? _deviceHeight, _deviceWidth;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SafeArea(
            child: Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(children: [
            Text("Frivia", style: TextStyle(color: Colors.white, fontSize: 35)),
            Text(
              _currentDifficulty,
              style: TextStyle(color: Colors.white),
            ),
          ]),
          _difficultySlider(),
          _startButton() // ADD ELEMENTS HERE
        ],
      ),
    )));
  }

  Widget _startButton() {
    return Container(
        width: _deviceWidth! * 0.6,
        height: _deviceHeight! * 0.08,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.blue),
        child: MaterialButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          GamePage(difficulty: _currentDifficulty)));
            },
            child: const Text('Start',
                style: TextStyle(color: Colors.white, fontSize: 20))));
  }

  Widget _difficultySlider() {
    return Slider(
      activeColor: Colors.blue,
      value: difficulty,
      divisions: 2,
      onChanged: (newValue) {
        setState(() {
          difficulty = newValue;
          if (difficulty == 0)
            _currentDifficulty = "Easy";
          else if (difficulty == 1)
            _currentDifficulty = "Hard";
          else
            _currentDifficulty = "Medium";
        });
      },
    );
  }
}
