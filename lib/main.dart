import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:splashscreen/splashscreen.dart';

void main() => runApp(MaterialApp(
      home: Splash(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.teal,
      ),
    ));

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 5,
      navigateAfterSeconds: new MyApp(),
      title: new Text(
        'Rajat\'s Calculator',
        textScaleFactor: 2,
      ),
      image: new Image.asset('images/calculator.png'),
      loadingText: Text("Loading"),
      photoSize: 70.0,
      loaderColor: Colors.blue,
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String equation = "0";
  String result = "0";
  String expression = "";
  double equationsize = 28.0;
  double answersize = 38.0;

  calcresult() {
    expression = equation;
    setState(() {
      try {
        Parser p = Parser();
        Expression exp = p.parse(equation);
        ContextModel cm = ContextModel();
        result = '${exp.evaluate(EvaluationType.REAL, cm)}';
      } catch (e) {
        result = "Error";
      }
      equationsize = 28.0;
      answersize = 38.0;
    });
  }

  buttonpressed(value) {
    setState(() {
      if (result != "0" &&
          (value == "+" || value == "-" || value == "*" || value == "/")) {
        equation = result;
      }
      if (value == "C") {
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
          equationsize = 28.0;
          answersize = 38.0;
        }
      } else if (value == "AC") {
        equation = "0";
        result = "0";
        equationsize = 28.0;
        answersize = 38.0;
      } else {
        equationsize = 38.0;
        answersize = 28.0;
        if (equation == "0") {
          equation = value;
        } else {
          equation = equation + value;
        }
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Image.asset(
          "images/calculator.png",
          height: 100,
          width: 100,
        ),
        title: Text(
          "Calculator",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: AutoSizeText(
                equation,
                maxLines: 3,
                style: TextStyle(fontSize: equationsize),
              )),
          Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: Text(
                result,
                style: TextStyle(fontSize: answersize),
              )),
          Expanded(child: Divider()),
          Column(
            children: [
              Row(
                children: <Widget>[
                  keys("1", Colors.teal[300]),
                  keys("2", Colors.teal[300]),
                  keys("3", Colors.teal[300]),
                  keys("+", Colors.lightBlue),
                ],
              ),
              Row(
                children: <Widget>[
                  keys("4", Colors.teal[300]),
                  keys("5", Colors.teal[300]),
                  keys("6", Colors.teal[300]),
                  keys("-", Colors.lightBlue),
                ],
              ),
              Row(
                children: <Widget>[
                  keys("7", Colors.teal[300]),
                  keys("8", Colors.teal[300]),
                  keys("9", Colors.teal[300]),
                  keys("*", Colors.lightBlue),
                ],
              ),
              Row(
                children: <Widget>[
                  keys(".", Colors.teal[300]),
                  keys("0", Colors.teal[300]),
                  keys("00", Colors.teal[300]),
                  keys("/", Colors.lightBlue),
                ],
              ),
            ],
          ),
          Row(
            children: <Widget>[
              keys("C", Colors.red),
              keys("AC", Colors.red),
              specialkey("=", Colors.teal),
            ],
          ),
        ],
      ),
    );
  }

  Widget keys(String val, Color setcolor) {
    return Expanded(
        child: FlatButton(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(
              color: Colors.white, width: 1, style: BorderStyle.solid)),
      padding: EdgeInsets.fromLTRB(20, 36, 20, 36),
      onPressed: () => buttonpressed(val),
      child: Text(
        val,
        style: TextStyle(
          fontSize: 26,
        ),
      ),
      color: setcolor,
      textColor: Colors.black,
    ));
  }

  Widget specialkey(String val, Color setcolor) {
    return Expanded(
        flex: 2,
        child: FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: BorderSide(
                  color: Colors.white, width: 1, style: BorderStyle.solid)),
          padding: EdgeInsets.fromLTRB(20, 36, 20, 36),
          onPressed: () => calcresult(),
          child: Text(
            val,
            style: TextStyle(
              fontSize: 26,
            ),
          ),
          color: setcolor,
          textColor: Colors.black,
        ));
  }
}
