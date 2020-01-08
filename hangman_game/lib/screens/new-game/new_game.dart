import 'package:flutter/material.dart';
import 'package:jogo_forca/screens/game/game.dart';

class NewGame extends StatelessWidget {
  final TextEditingController _textEditingController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  void startNewGame(BuildContext context) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => Game(answer: _textEditingController.text),
        ),
        (Route<dynamic> route) => false);
  }

  void _toggleFocus(BuildContext context) {
    if (_focusNode.hasFocus) {
      _focusNode.unfocus();
    } else {
      FocusScope.of(context).requestFocus(_focusNode);
    }
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      'Digite a palavra da vez: ',
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.title,
    );
  }

  Widget _buildTextField(BuildContext context) {
    return Container(
      child: TextField(
        controller: _textEditingController,
        decoration: InputDecoration(border: InputBorder.none),
        // style: Theme.of(context).textTheme.title.copyWith(fontSize: 35.0),
        style: TextStyle(fontSize: 30),
        textAlign: TextAlign.center,
        focusNode: _focusNode,
        onSubmitted: (String value) {
          startNewGame(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jogo da Forca'),
      ),
      body: InkWell(
        splashColor: Colors.blue[100],
        highlightColor: Colors.blue[100],
        onTap: () {
          _toggleFocus(context);
        },
        child: Container(
          color: Colors.white30,
          padding: EdgeInsets.all(20.0),
          child: Container(
            alignment: Alignment.center,
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                _buildTitle(context),
                _buildTextField(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
