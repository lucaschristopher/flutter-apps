import 'package:flutter/material.dart';
import 'package:jogo_forca/screens/game/widgets/header.dart';
import 'package:jogo_forca/screens/game/widgets/puzzle.dart';
import 'package:jogo_forca/screens/new-game/new_game.dart';
import 'game_controller.dart';

class Game extends StatefulWidget {
  final String answer;

  @override
  _GameState createState() => _GameState();

  Game({@required this.answer});
}

class _GameState extends State<Game> {
  GameController gameController;
  String letter;
  Header _header;
  Puzzle _puzzle;
  TextEditingController _textEditingController;

  @override
  void initState() {
    _textEditingController = TextEditingController(text: letter);
    gameController = GameController(answer: widget.answer);
    _header = Header(wrongLetters: []);
    _puzzle = Puzzle(
      answerLength: gameController.answerLength,
      puzzleLetters: gameController.puzzleLetters,
    );
    gameController.onSomething.stream.listen((String data) {
      dealWithGameEvents(data);
    });
    super.initState();
  }

  dealWithGameEvents(String event) {
    setState(() {
      gameController.updateImagePath();
      _puzzle = Puzzle(
        answerLength: gameController.answerLength,
        puzzleLetters: gameController.puzzleLetters,
      );
      _header = Header(
        wrongLetters: gameController.wrongLetters,
      );
    });
  }

  _limitTextToOne(String value) {
    setState(() {
      letter = value[value.length - 1];
      _textEditingController.text = letter;
      _textEditingController.selection =
          TextSelection.fromPosition(TextPosition(offset: value.length - 1));
    });
  }

  void submit(String letter) {
    gameController.takeShot(letter);
    letter = '';
    _textEditingController.text = '';
    FocusScope.of(context).requestFocus(new FocusNode());
  }

  _startNewGame(BuildContext context) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => NewGame(),
        ),
        (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildTextField(BuildContext context) {
      return Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 4),
          width: 230.0,
          child: TextField(
            controller: _textEditingController,
            onChanged: (String value) {
              _limitTextToOne(value);
            },
            // style: Theme.of(context).textTheme.title.copyWith(fontSize: 35.0),
            style: TextStyle(fontSize: 25),
            decoration: InputDecoration(
              hintText: 'Próxima letra...',
              border: InputBorder.none,
            ),
            onSubmitted: submit,
          ),
        ),
      );
    }

    final answeredPuzzle = Puzzle(
      answerLength: gameController.answerLength,
      puzzleLetters: gameController.answer.split(''),
    );

    Widget _buildPuzzle(bool alreadyLost) {
      if (alreadyLost) {
        return Column(
          children: <Widget>[
            Text(
              'Resposta',
              style: Theme.of(context).textTheme.subhead,
            ),
            answeredPuzzle,
          ],
        );
      } else {
        return _puzzle;
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        actions: <Widget>[
          IconButton(
            tooltip: "Novo jogo",
            padding: EdgeInsets.only(right: 10),
            icon: Icon(Icons.refresh),
            onPressed: () {
              _startNewGame(context);
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            _header,
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Image.asset(
                '${gameController.imagePath}',
                width: double.infinity,
                height: 350.0,
              ),
            ),
            _buildPuzzle(gameController.alreadyLost()),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: gameController.alreadyWon()
                  ? []
                  : gameController.alreadyLost()
                      ? []
                      : <Widget>[
                          _buildTextField(context),
                        ],
            )
          ],
        ),
      ),
    );
  }
}
