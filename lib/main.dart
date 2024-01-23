// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),
      home: const MyCalculator(),
    );
  }
}

class MyCalculator extends StatefulWidget {
  const MyCalculator({Key? key});

  @override
  State<MyCalculator> createState() => _MyCalculatorState();
}

class _MyCalculatorState extends State<MyCalculator> {
  final TextEditingController num1Controller = TextEditingController();
  final TextEditingController num2Controller = TextEditingController();
  final TextEditingController resultController = TextEditingController();
  String operation = '';
  String currentOperator = 'OP';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: num1Controller,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Num1',
                      labelStyle: TextStyle(color: Colors.white54),
                      filled: true,
                      fillColor: Colors.lightBlue,
                    ),
                    enabled: false,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    currentOperator,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: num2Controller,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Num2',
                      labelStyle: TextStyle(color: Colors.white54),
                      filled: true,
                      fillColor: Colors.lightBlue,
                    ),
                    enabled: false,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    '=',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: resultController,
                    enabled: false,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.lightBlue,
                      labelText: 'Result',
                      labelStyle: TextStyle(color: Colors.white54),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 240.0,
                  height: 70.0,
                  margin: const EdgeInsets.only(bottom: 8.0),
                  child: const TextField(
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    enabled: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      labelText: 'P1',
                      filled: true,
                    ),
                  ),
                ),
                _buildOperatorButton('/'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildNumberButton('7'),
                _buildNumberButton('8'),
                _buildNumberButton('9'),
                _buildOperatorButton('*'),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildNumberButton('4'),
                _buildNumberButton('5'),
                _buildNumberButton('6'),
                _buildOperatorButton('-'),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildNumberButton('1'),
                _buildNumberButton('2'),
                _buildNumberButton('3'),
                _buildOperatorButton('+'),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildOperatorButton('+/-'),
                _buildNumberButton('0'),
                _buildDecimalButton(),
                _buildOperatorButton('='),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _clearFields,
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(100, 40),
                    backgroundColor: Colors.greenAccent,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                  child: const Text('Clear'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNumberButton(String number) {
    return ElevatedButton(
      onPressed: () => _appendToInput(number),
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(70, 50),
        foregroundColor: Colors.black87,
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      ),
      child: Text(number),
    );
  }

  Widget _buildDecimalButton() {
    return ElevatedButton(
      onPressed: () => _appendToInput('.'),
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(70, 50),
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      ),
      child: const Text('.'),
    );
  }

  Widget _buildOperatorButton(String operator) {
    return ElevatedButton(
      onPressed: () {
        if (operator == '=') {
          _calculateResult();
        } else if (operator == '+/-') {
          _toggleSign();
        }
        else {
          _performOperation(operator);
        }
      },
      style: ElevatedButton.styleFrom(
          fixedSize: const Size(70, 50),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white),
      child: Text(operator),
    );
  }

  void _appendToInput(String value) {
    TextEditingController activeController =
    operation.isEmpty ? num1Controller : num2Controller;
    activeController.text = activeController.text + value;
  }

  void _performOperation(String op) {
    setState(() {
      operation = op;
      currentOperator = op;
    });
  }

  void _calculateResult() {
    double num1 = double.tryParse(num1Controller.text) ?? 0;
    double num2 = double.tryParse(num2Controller.text) ?? 0;

    double result = 0;

    switch (operation) {
      case '+':
        result = num1 + num2;
        break;
      case '-':
        result = num1 - num2;
        break;
      case '*':
        result = num1 * num2;
        break;
      case '/':
        result = num1 / num2;
        break;
      case '=':
        result = num1;
        break;
    }

    if (result % 1 == 0) {
      resultController.text = result.toInt().toString();
    } else {
      resultController.text = result.toString();
    }
  }

  void _clearFields() {
    setState(() {
      num1Controller.text = '';
      num2Controller.text = '';
      resultController.text = '';
      operation = '';
      currentOperator = 'OP';
    });
  }

  void _toggleSign() {
    TextEditingController activeController =
    operation.isEmpty ? num1Controller : num2Controller;
    if (activeController.text.startsWith('-')) {
      activeController.text = activeController.text.substring(1);
    } else {
      activeController.text = '-${activeController.text}';
    }
  }
}
