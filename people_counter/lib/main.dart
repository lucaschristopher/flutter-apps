import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Counter people',
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _numPeople; // Hum... Initialize?
  String _infoText = "You can come in, welcome!";

  _changeNumPeople(int value) {
    setState(() {
      _numPeople += value;
      if (_numPeople < 0) {
        _infoText = "Inverted world!?";
      } else if (_numPeople <= 10) {
        _infoText = "You can come in, welcome!";
      } else {
        _infoText = "Sorry, we're full...";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.asset(
          "images/times_square.jpg",
          fit: BoxFit.cover,
          height: 1000.0, // check why this works only with this dimension...
        ),
        Column(
          mainAxisAlignment:
              MainAxisAlignment.center, // Why do not "Center()"!?
          children: <Widget>[
            Text(
              'Peoples: $_numPeople',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: FlatButton(
                    child: Text(
                      "+ 1",
                      style: TextStyle(fontSize: 40.0, color: Colors.white),
                    ),
                    // onPressed: () { function() ? },
                    onPressed: _changeNumPeople(1),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: FlatButton(
                    child: Text(
                      "- 1",
                      style: TextStyle(fontSize: 40.0, color: Colors.white),
                    ),
                    // onPressed: () { function() ? },
                    onPressed: _changeNumPeople(-1),
                  ),
                ),
              ],
            ),
            Text(
              _infoText,
              style: TextStyle(
                color: Colors.white,
                fontStyle: FontStyle.italic,
                fontSize: 30.0,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
