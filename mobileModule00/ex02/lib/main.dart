import 'package:flutter/material.dart';
import 'dart:developer' as developer;

void main() {
  runApp(const Calculator());
}

class Calculator extends StatelessWidget {
  const Calculator({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ex02',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: const CalculatorHomePage(title: 'Calculator'),
    );
  }
}

class CalculatorHomePage extends StatefulWidget {
  const CalculatorHomePage({super.key, required this.title});

  final String title;

  @override
  State<CalculatorHomePage> createState() => _CalculatorHomePageState();
}

class NumPad extends StatelessWidget {
  const NumPad({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.5,
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisSize: MainAxisSize.values.first,
        children: [
          Column(
            children: [
              Expanded(child: TextButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.tealAccent),
                  shape: MaterialStatePropertyAll(ContinuousRectangleBorder()),
                ),
                onPressed: () {debugPrint('7');},
                child: const Text('7',
                    style: TextStyle(color: Colors.black, fontSize: 20)),
              )),
              Expanded(child: TextButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.tealAccent),
                  shape: MaterialStatePropertyAll(ContinuousRectangleBorder()),
                ),
                onPressed: () {debugPrint('4');},
                child: const Text('4',
                    style: TextStyle(color: Colors.black, fontSize: 20)),
              )),
              Expanded(child: TextButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.tealAccent),
                  shape: MaterialStatePropertyAll(ContinuousRectangleBorder()),
                ),
                onPressed: () {debugPrint('1');},
                child: const Text('1',
                    style: TextStyle(color: Colors.black, fontSize: 20)),
              )),
              Expanded(child: TextButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.tealAccent),
                  shape: MaterialStatePropertyAll(ContinuousRectangleBorder()),
                ),
                onPressed: () {debugPrint('0');},
                child: const Text('0',
                    style: TextStyle(color: Colors.black, fontSize: 20)),
              )),
            ],
          ),
          Column(
            children: [
              Expanded(child: TextButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.tealAccent),
                  shape: MaterialStatePropertyAll(ContinuousRectangleBorder()),
                ),
                onPressed: () { debugPrint('8'); },
                child: const Text('8',
                    style: TextStyle(color: Colors.black, fontSize: 20)),
              )),
              Expanded(child: TextButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.tealAccent),
                  shape: MaterialStatePropertyAll(ContinuousRectangleBorder()),
                ),
                onPressed: () {debugPrint('5');},
                child: const Text('5',
                    style: TextStyle(color: Colors.black, fontSize: 20)),
              )),
              Expanded(child: TextButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.tealAccent),
                  shape: MaterialStatePropertyAll(ContinuousRectangleBorder()),
                ),
                onPressed: () {debugPrint('2');},
                child: const Text('2',
                    style: TextStyle(color: Colors.black, fontSize: 20)),
              )),
              Expanded(child: TextButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.tealAccent),
                  shape: MaterialStatePropertyAll(ContinuousRectangleBorder()),
                ),
                onPressed: () {debugPrint('.');},
                child: const Text('.',
                    style: TextStyle(color: Colors.black, fontSize: 20)),
              )),
            ],
          ),
          Column(
            children: [
              Expanded(child: TextButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.tealAccent),
                  shape: MaterialStatePropertyAll(ContinuousRectangleBorder()),
                ),
                onPressed: () {debugPrint('9');},
                child: const Text('9',
                    style: TextStyle(color: Colors.black, fontSize: 20)),
              )),
              Expanded(child: TextButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.tealAccent),
                  shape: MaterialStatePropertyAll(ContinuousRectangleBorder()),
                ),
                onPressed: () {debugPrint('6');},
                child: const Text('6',
                    style: TextStyle(color: Colors.black, fontSize: 20)),
              )),
              Expanded(child: TextButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.tealAccent),
                  shape: MaterialStatePropertyAll(ContinuousRectangleBorder()),
                ),
                onPressed: () {debugPrint('3');},
                child: const Text('3',
                    style: TextStyle(color: Colors.black, fontSize: 20)),
              )),
              Expanded(child: TextButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.tealAccent),
                  shape: MaterialStatePropertyAll(ContinuousRectangleBorder()),
                ),
                onPressed: () {debugPrint('00');},
                child: const Text('00',
                    style: TextStyle(color: Colors.black, fontSize: 20)),
              )),
            ],
          ),
          Column(
            children: [
              Expanded(child: TextButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.tealAccent),
                  shape: MaterialStatePropertyAll(ContinuousRectangleBorder()),
                ),
                onPressed: () {debugPrint('C');},
                child: const Text('C',
                    style: TextStyle(color: Colors.red, fontSize: 20)),
              )),
              Expanded(child: TextButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.teal),
                  shape: MaterialStatePropertyAll(ContinuousRectangleBorder()),
                ),
                onPressed: () {debugPrint('+');},
                child: const Text('+',
                    style: TextStyle(color: Colors.white, fontSize: 20)),
              )),
              Expanded(child: TextButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.teal),
                  shape: MaterialStatePropertyAll(ContinuousRectangleBorder()),
                ),
                onPressed: () {debugPrint('x');},
                child: const Text('x',
                    style: TextStyle(color: Colors.white, fontSize: 20)),
              )),
              Expanded(child: TextButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.teal),
                  shape: MaterialStatePropertyAll(ContinuousRectangleBorder()),
                ),
                onPressed: () {debugPrint('=');},
                child: const Text('=',
                    style: TextStyle(color: Colors.white, fontSize: 20)),
              )),
            ],
          ),
          Column(
            children: [
              Expanded(child: TextButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.tealAccent),
                  shape: MaterialStatePropertyAll(ContinuousRectangleBorder()),
                ),
                onPressed: () {debugPrint('AC');},
                child: const Text('AC',
                    style: TextStyle(color: Colors.red, fontSize: 20)),
              )),
              Expanded(child: TextButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.teal),
                  shape: MaterialStatePropertyAll(ContinuousRectangleBorder()),
                ),
                onPressed: () {debugPrint('-');},
                child: const Text('-',
                    style: TextStyle(color: Colors.white, fontSize: 20)),
              )),
              Expanded(child: TextButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.teal),
                  shape: MaterialStatePropertyAll(ContinuousRectangleBorder()),
                ),
                onPressed: () {debugPrint('/');},
                child: const Text('/',
                    style: TextStyle(color: Colors.white, fontSize: 20)),
              )),
              Expanded(child: TextButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.tealAccent),
                  shape: MaterialStatePropertyAll(ContinuousRectangleBorder()),
                ),
                onPressed: () {},
                child: const Text('',
                    style: TextStyle(color: Colors.black, fontSize: 20)),
              )),
            ],
          ),
        ],
      ),
    );
  }
}

class _CalculatorHomePageState extends State<CalculatorHomePage> {
  static const String _expression_calc = "0";
  static const String _result_calc = "0";

  /*void _onClicked() {
    setState(() {
      _text = _text == "Hello World!" ? "Welcome on this beautiful app !" : "Hello World!";
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: const Center(
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.centerRight,
              child: Column(
                children: <Widget>[
                  Text(
                    _expression_calc,
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  Text(
                    _result_calc,
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: const NumPad(),
    );
  }
}
