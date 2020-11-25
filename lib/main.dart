import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:math_expressions/math_expressions.dart';
import 'dart:async';

void main() => runApp(MaterialApp(
      title: "Svastik Calculator",
      home: MyApp(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.teal,
      ),
    ));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  dynamic night;
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

  @override
  void initState() {
    super.initState();
    var temp = FlutterSession().get("nightmode");
    if (temp == null) {
      night = "False";
    } else {
      night = temp;
      print(night);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: night == "False" ? Colors.white : Colors.black87,
      appBar: AppBar(
        backgroundColor: night == "False" ? Colors.grey[200] : Colors.blue[900],
        elevation: 5,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                if (night == "False") {
                  night = "True";
                } else {
                  night = "False";
                }
                FlutterSession().set("nightmode", night);
              });
            },
            icon: Icon(
              night == "False" ? Icons.wb_sunny : Icons.nights_stay,
              color: night == "False" ? Colors.orange[900] : Colors.white,
            ),
          ),
        ],
        title: Text(
          "Svastik Calculator",
          style: TextStyle(
              color: night == "False" ? Colors.black : Colors.white,
              fontFamily: "Arial"),
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
                style: TextStyle(
                    color: night == "False" ? Colors.black : Colors.white,
                    fontSize: equationsize),
              )),
          Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: Text(
                result,
                style: TextStyle(
                  fontSize: answersize,
                  color: night == "False" ? Colors.black : Colors.white,
                ),
              )),
          Expanded(child: Divider()),
          Column(
            children: [
              Row(
                children: <Widget>[
                  keys("1", night == "False" ? Colors.teal[300] : Colors.teal),
                  keys("2", night == "False" ? Colors.teal[300] : Colors.teal),
                  keys("3", night == "False" ? Colors.teal[300] : Colors.teal),
                  keys(
                      "+", night == "False" ? Colors.lightBlue : Colors.indigo),
                ],
              ),
              Row(
                children: <Widget>[
                  keys("4", night == "False" ? Colors.teal[300] : Colors.teal),
                  keys("5", night == "False" ? Colors.teal[300] : Colors.teal),
                  keys("6", night == "False" ? Colors.teal[300] : Colors.teal),
                  keys(
                      "-", night == "False" ? Colors.lightBlue : Colors.indigo),
                ],
              ),
              Row(
                children: <Widget>[
                  keys("7", night == "False" ? Colors.teal[300] : Colors.teal),
                  keys("8", night == "False" ? Colors.teal[300] : Colors.teal),
                  keys("9", night == "False" ? Colors.teal[300] : Colors.teal),
                  keys(
                      "*", night == "False" ? Colors.lightBlue : Colors.indigo),
                ],
              ),
              Row(
                children: <Widget>[
                  keys(".", night == "False" ? Colors.teal[300] : Colors.teal),
                  keys("0", night == "False" ? Colors.teal[300] : Colors.teal),
                  keys("00", night == "False" ? Colors.teal[300] : Colors.teal),
                  keys(
                      "/", night == "False" ? Colors.lightBlue : Colors.indigo),
                ],
              ),
            ],
          ),
          Row(
            children: <Widget>[
              keys("C", night == "False" ? Colors.red : Colors.red[900]),
              keys("AC", night == "False" ? Colors.red : Colors.red[900]),
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
              color: night == "False" ? Colors.white : Colors.grey,
              width: 1,
              style: BorderStyle.solid)),
      padding: EdgeInsets.fromLTRB(20, 36, 20, 36),
      onPressed: () => buttonpressed(val),
      child: Text(
        val,
        style: TextStyle(
          fontSize: 26,
        ),
      ),
      color: setcolor,
      textColor: night == "False" ? Colors.black : Colors.white,
    ));
  }

  Widget specialkey(String val, Color setcolor) {
    return Expanded(
        flex: 2,
        child: FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: BorderSide(
                  color: night == "False" ? Colors.white : Colors.grey,
                  width: 1,
                  style: BorderStyle.solid)),
          padding: EdgeInsets.fromLTRB(20, 36, 20, 36),
          onPressed: () => calcresult(),
          child: Text(
            val,
            style: TextStyle(
              fontSize: 26,
            ),
          ),
          color: setcolor,
          textColor: night == "False" ? Colors.black : Colors.white,
        ));
  }
}
