// Várias pessoas notaram que há um pequeno bug neste app,
// que ocorre quando há uma mensagem de erro em um dos campos
// e o usuário toca no botão de reset. Neste caso, as mensagens
// de erro deveriam sumir, mas não somem!

// Pra resolver isso é muito simples,
// basta você recriar a _formKey da forma mostrada abaixo:

// void _resetFields(){
//   weightController.text = "";
//   heightController.text = "";
//   setState(() {
//     _infoText = "Informe seus dados!";
//     _formKey = GlobalKey<FormState>();  // ADICIONE ESTA LINHA!
//   });
// }

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: HomePage(),
    debugShowCheckedModeBanner: false,
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Enter your details.";

  void _resetFields() {
    weightController.text = "";
    heightController.clear(); // Equals to weightController.text = ""?
    setState(() {
      _infoText = "Enter your details.";
    });
  }

  void _calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double bmi = weight / (height * height);

      _infoBmi(bmi);
    });
  }

  void _infoBmi(double bmi) {
    if (bmi < 18.6) {
      _infoText = "Underweight (BMI = ${bmi.toStringAsPrecision(3)})";
    } else if (bmi >= 18.6 && bmi < 24.9) {
      _infoText = "Great, ideal weight! (BMI = ${bmi.toStringAsPrecision(3)})";
    } else if (bmi >= 24.9 && bmi < 29.9) {
      _infoText = "Slightly overweight. (BMI = ${bmi.toStringAsPrecision(3)})";
    } else if (bmi >= 29.9 && bmi < 34.9) {
      _infoText = "Obesity grade I. (BMI = ${bmi.toStringAsPrecision(3)})";
    } else if (bmi >= 34.9 && bmi < 39.9) {
      _infoText =
          "Caution, obesity grade II. (BMI = ${bmi.toStringAsPrecision(3)})";
    } else if (bmi >= 40.0) {
      _infoText =
          "Very careful, obesity grade III! (BMI = ${bmi.toStringAsPrecision(3)})";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BMI Calculator"),
        centerTitle: true,
        backgroundColor: Colors.red,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetFields,
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(
                Icons.person,
                size: 90.0,
                color: Colors.red,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Weight (kg)",
                  labelStyle: TextStyle(
                    color: Colors.red,
                  ),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 20.0,
                ),
                controller: weightController,
                validator: (value) {
                  if (value.isEmpty) return "Enter your weight...";
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Height (cm)",
                  labelStyle: TextStyle(
                    color: Colors.red,
                  ),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 20.0,
                ),
                controller: heightController,
                validator: (value) {
                  if (value.isEmpty) return "Enter your height...";
                },
              ),
              Padding(
                // Similar to EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0)
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Container(
                  height: 50.0,
                  child: RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) _calculate();
                    },
                    child: Text(
                      "Calculate",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,
                      ),
                    ),
                    color: Colors.red,
                  ),
                ),
              ),
              Text(
                _infoText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 25.0,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
