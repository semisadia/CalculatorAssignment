import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'color.dart';

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({Key? key}) : super(key: key);

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  double firstNum = 0.0;
  double secondNum = 0.0;
  var input = '';
  var output = '';
  var operator = '';

  onButtonClick(value) {
    if (value == "AC") {
      input = '';
      output = '';
    } else if (value == "<") {
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
      }
    } else if (value == "=") {
      if (input.isNotEmpty) {
        var userInput = input;
        userInput = input.replaceAll("x", "*");
        Parser p = Parser();
        Expression expression = p.parse(userInput);
        ContextModel cm = ContextModel();
        var finalValue = expression.evaluate(EvaluationType.REAL, cm);
        output = finalValue.toString();
      }
      input = output;
    } else {
      input = input + value;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
              child: Container(
            color: Color.fromRGBO(192, 192, 192, 0.6705882352941176),
            width: double.infinity,
            padding: EdgeInsets.all(2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  input,
                  style: TextStyle(
                    fontSize: 50,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  output,
                  style: TextStyle(
                    fontSize: 70,
                    color: Colors.black.withOpacity(0.7),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          )),
          Row(
            children: [
              button(
                  text: "AC",
                  buttonBgColor: operatorColor,
                  tColor: orangeColor),
              button(
                  text: "<",
                  buttonBgColor: operatorColor,
                  tColor: orangeColor),
              button(
                  text: "%", tColor: orangeColor, buttonBgColor: operatorColor),
              button(
                  text: "/", buttonBgColor: operatorColor, tColor: orangeColor),
            ],
          ),
          Row(
            children: [
              button(text: "7"),
              button(text: "8"),
              button(text: "9"),
              button(
                  text: "x", tColor: orangeColor, buttonBgColor: operatorColor),
            ],
          ),
          Row(
            children: [
              button(text: "4"),
              button(text: "5"),
              button(text: "6"),
              button(
                  text: "-", tColor: orangeColor, buttonBgColor: operatorColor),
            ],
          ),
          Row(
            children: [
              button(text: "1"),
              button(text: "2"),
              button(text: "3"),
              button(
                  text: "+", tColor: orangeColor, buttonBgColor: operatorColor),
            ],
          ),
          Row(
            children: [
              button(
                  text: "", buttonBgColor: Color.fromRGBO(255, 255, 255, 0.0)),
              button(text: "0"),
              button(text: "."),
              button(
                  text: "=",
                  tColor: orangeColor,
                  buttonBgColor: Color.fromRGBO(
                      197, 71, 16, 1.0)),
            ],
          )
        ],
      ),
    );
  }

  Widget button({
    text,
    tColor = Colors.black,
    buttonBgColor = buttonColor,
  }) {
    return Expanded(
        child: Container(
      margin: const EdgeInsets.all(4),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(25),
          primary: buttonBgColor,
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(25), // Adjust the radius as needed
          ),
        ),
        onPressed: () => onButtonClick(text),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 30,
            color: tColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ));
  }
}
