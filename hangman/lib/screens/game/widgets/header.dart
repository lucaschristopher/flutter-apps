import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final List<String> wrongLetters;

  Header({@required this.wrongLetters});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35.0,
      margin: EdgeInsets.only(bottom: 15.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: List.generate(
            wrongLetters.length > 0 ? wrongLetters.length + 1 : 1, (int index) {
          if (index != 0) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Text(
                wrongLetters[index - 1],
                style: Theme.of(context).textTheme.body1.copyWith(
                      fontSize: 20.0,
                    ),
              ),
            );
          } else {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 13.0, vertical: 8.0,),
              child: Text('ERROS: ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),),
            );
          }
        }),
      ),
    );
  }
}
