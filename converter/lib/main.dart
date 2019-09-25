import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

const request = "https://api.hgbrasil.com/finance?format=json&key=60df7606";

/*
Na próxima aula utilizaremos bordas nos campos de texto, porém na versão mais recente do flutter
houve uma pequena mudança nesta área, assim a borda não está ficando mais colorida.
Pra resolver, basta aplicar o código a seguir no seu ThemeData:

theme: ThemeData(
  inputDecorationTheme: InputDecorationTheme(
    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white))
  )
)
*/

void main() async {
  runApp(MaterialApp(
    home: HomePage(),
    theme: ThemeData(
      hintColor: Colors.amber,
      primaryColor: Colors.white,
    ),
    debugShowCheckedModeBanner: false,
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final euroController = TextEditingController();
  final dollarController = TextEditingController();
  final realController = TextEditingController();

  double euro; // Why dnot private?
  double dollar; // Why not private?

  void _clearAll() {
    // realController.text = "";
    // dollarController.text = "";
    // euroController.text = "";
    realController.clear();
    dollarController.clear();
    euroController.clear();
  }

  void _realChanged(String value) {
    if (value.isEmpty) {
      _clearAll();
      return;
    }

    double aux = double.parse(value);
    dollarController.text = (aux / dollar).toStringAsPrecision(2);
    euroController.text = (aux / euro).toStringAsPrecision(2);
  }

  void _dollarChanged(value) {
    if (value.isEmpty) {
      _clearAll();
      return;
    }

    double aux = double.parse(value);
    realController.text = (aux * this.dollar).toStringAsPrecision(2);
    euroController.text = ((aux * this.dollar) / euro).toStringAsPrecision(2);
  }

  void _euroChanged(value) {
    if (value.isEmpty) {
      _clearAll();
      return;
    }

    double aux = double.parse(value);
    realController.text = (aux * this.euro).toStringAsPrecision(2);
    dollarController.text = ((aux * this.euro) / dollar).toStringAsPrecision(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Currencies converter"),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      body: FutureBuilder<Map>(
        future: getData(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: Text(
                  "Loading data...",
                  style: TextStyle(color: Colors.amber, fontSize: 25.0),
                  textAlign: TextAlign.center,
                ),
              );
            default:
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    "Error loading data...",
                    style: TextStyle(color: Colors.amber, fontSize: 25.0),
                    textAlign: TextAlign.center,
                  ),
                );
              } else {
                dollar = snapshot.data["results"]["currencies"]["USD"]["buy"];
                euro = snapshot.data["results"]["currencies"]["EUR"]["buy"];

                return SingleChildScrollView(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Icon(
                        Icons.monetization_on,
                        size: 100.0,
                        color: Colors.amber,
                      ),
                      Divider(),
                      buildTextField(
                          "Reais", "R\$", realController, _realChanged),
                      Divider(),
                      buildTextField(
                          "Dollars", "US\$", dollarController, _dollarChanged),
                      Divider(),
                      buildTextField(
                          "Euros", "€", euroController, _euroChanged),
                    ],
                  ),
                );
              }
          }
        },
      ),
    );
  }
}

buildTextField(String label, String prefix,
    TextEditingController textController, Function currencyChanged) {
  return TextField(
    controller: textController,
    decoration: InputDecoration(
      labelText: label,
      labelStyle: TextStyle(
        color: Colors.amber,
      ),
      border: OutlineInputBorder(),
      prefixText: "prefix ",
    ),
    style: TextStyle(
      color: Colors.amber,
      fontSize: 25.0,
    ),
    onChanged: currencyChanged,
    keyboardType: TextInputType.number,
  );
}

Future<Map> getData() async {
  http.Response response = await http.get(request);
  return json.decode(response.body);
}
