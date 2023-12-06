import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

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
      home: const CalculatorHomePage(),
    );
  }
}

class CalculatorHomePage extends StatefulWidget {
  const CalculatorHomePage({super.key});

  @override
  State<CalculatorHomePage> createState() => _CalculatorHomePageState();
}

class _CalculatorHomePageState extends State<CalculatorHomePage> {

  String title = "Calculator";
  String _expression_calc = "0";
  String _result_calc = "0";

  void expressionCalcChanged(String value) {
    setState(() {
      if (value == "AC") {
        _expression_calc = "0";
        _result_calc = "0";
      }
      else if (value == "C") {
        debugPrint(_expression_calc.length.toString());
        _expression_calc = _expression_calc.substring(0, _expression_calc.length - 1);

        if (_expression_calc.isEmpty) {
          _expression_calc = "0";
        }
      }
      else if (value == "=") {
        Parser p = Parser();
        _expression_calc = _expression_calc.replaceAll("x", "*");
        Expression exp = p.parse(_expression_calc);
        ContextModel cm = ContextModel();
        resultCalcChanged(exp.evaluate(EvaluationType.REAL, cm).toString());
        _expression_calc = "0";
      }
      else {
        String lastChar =_expression_calc[_expression_calc.length - 1];
        if (int.tryParse(lastChar) == null && value == _expression_calc[_expression_calc.length - 1]) {
          return;
        }
        if (int.tryParse(lastChar) == null && int.tryParse(value) == null) {
          return;
        }
        if (_expression_calc == "0") {
          _expression_calc = value;
        }
        else {
          _expression_calc += value;
        }
      }
    });
  }

  void resultCalcChanged(String value) {
    setState(() {
      _result_calc = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        title: Text(title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.centerRight,
              child: Column(
                children: <Widget>[
                  Text(
                    _expression_calc,
                    style: const TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  Text(
                    _result_calc,
                    style: const TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: NumPad(expression_calc: _expression_calc, result_calc: _result_calc, onExpressionCalcChanged: expressionCalcChanged, onResultCalcChanged: resultCalcChanged),
    );
  }
}

class NumPad extends StatefulWidget {
  const NumPad({
    required this.expression_calc,
    required this.result_calc,
    required this.onExpressionCalcChanged,
    required this.onResultCalcChanged,
    super.key
  });

  final String title = "Calculator";
  final String expression_calc;
  final String result_calc;
  final ValueChanged<String> onExpressionCalcChanged;
  final ValueChanged<String> onResultCalcChanged;

  @override
  State<NumPad> createState() => _NumPadState();
}

class _NumPadState extends State<NumPad> {

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
                onPressed: () {debugPrint('7'); widget.onExpressionCalcChanged("7");},
                child: const Text('7',
                    style: TextStyle(color: Colors.black, fontSize: 20)),
              )),
              Expanded(child: TextButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.tealAccent),
                  shape: MaterialStatePropertyAll(ContinuousRectangleBorder()),
                ),
                onPressed: () {debugPrint('4'); widget.onExpressionCalcChanged("4");},
                child: const Text('4',
                    style: TextStyle(color: Colors.black, fontSize: 20)),
              )),
              Expanded(child: TextButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.tealAccent),
                  shape: MaterialStatePropertyAll(ContinuousRectangleBorder()),
                ),
                onPressed: () {debugPrint('1');widget.onExpressionCalcChanged("1");},
                child: const Text('1',
                    style: TextStyle(color: Colors.black, fontSize: 20)),
              )),
              Expanded(child: TextButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.tealAccent),
                  shape: MaterialStatePropertyAll(ContinuousRectangleBorder()),
                ),
                onPressed: () {debugPrint('0');widget.onExpressionCalcChanged("0");},
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
                onPressed: () { debugPrint('8');widget.onExpressionCalcChanged("8"); },
                child: const Text('8',
                    style: TextStyle(color: Colors.black, fontSize: 20)),
              )),
              Expanded(child: TextButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.tealAccent),
                  shape: MaterialStatePropertyAll(ContinuousRectangleBorder()),
                ),
                onPressed: () {debugPrint('5');widget.onExpressionCalcChanged("5");},
                child: const Text('5',
                    style: TextStyle(color: Colors.black, fontSize: 20)),
              )),
              Expanded(child: TextButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.tealAccent),
                  shape: MaterialStatePropertyAll(ContinuousRectangleBorder()),
                ),
                onPressed: () {debugPrint('2');widget.onExpressionCalcChanged("2");},
                child: const Text('2',
                    style: TextStyle(color: Colors.black, fontSize: 20)),
              )),
              Expanded(child: TextButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.tealAccent),
                  shape: MaterialStatePropertyAll(ContinuousRectangleBorder()),
                ),
                onPressed: () {debugPrint('.');widget.onExpressionCalcChanged(".");},
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
                onPressed: () {debugPrint('9');widget.onExpressionCalcChanged("9");},
                child: const Text('9',
                    style: TextStyle(color: Colors.black, fontSize: 20)),
              )),
              Expanded(child: TextButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.tealAccent),
                  shape: MaterialStatePropertyAll(ContinuousRectangleBorder()),
                ),
                onPressed: () {debugPrint('6');widget.onExpressionCalcChanged("6");},
                child: const Text('6',
                    style: TextStyle(color: Colors.black, fontSize: 20)),
              )),
              Expanded(child: TextButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.tealAccent),
                  shape: MaterialStatePropertyAll(ContinuousRectangleBorder()),
                ),
                onPressed: () {debugPrint('3');widget.onExpressionCalcChanged("3");},
                child: const Text('3',
                    style: TextStyle(color: Colors.black, fontSize: 20)),
              )),
              Expanded(child: TextButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.tealAccent),
                  shape: MaterialStatePropertyAll(ContinuousRectangleBorder()),
                ),
                onPressed: () {debugPrint('00');widget.onExpressionCalcChanged("00");},
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
                onPressed: () {debugPrint('C');widget.onExpressionCalcChanged("C");},
                child: const Text('C',
                    style: TextStyle(color: Colors.red, fontSize: 20)),
              )),
              Expanded(child: TextButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.teal),
                  shape: MaterialStatePropertyAll(ContinuousRectangleBorder()),
                ),
                onPressed: () {debugPrint('+');widget.onExpressionCalcChanged("+");},
                child: const Text('+',
                    style: TextStyle(color: Colors.white, fontSize: 20)),
              )),
              Expanded(child: TextButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.teal),
                  shape: MaterialStatePropertyAll(ContinuousRectangleBorder()),
                ),
                onPressed: () {debugPrint('x');widget.onExpressionCalcChanged("x");},
                child: const Text('x',
                    style: TextStyle(color: Colors.white, fontSize: 20)),
              )),
              Expanded(child: TextButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.teal),
                  shape: MaterialStatePropertyAll(ContinuousRectangleBorder()),
                ),
                onPressed: () {debugPrint('=');widget.onExpressionCalcChanged("=");},
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
                onPressed: () {debugPrint('AC');widget.onExpressionCalcChanged("AC");},
                child: const Text('AC',
                    style: TextStyle(color: Colors.red, fontSize: 20)),
              )),
              Expanded(child: TextButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.teal),
                  shape: MaterialStatePropertyAll(ContinuousRectangleBorder()),
                ),
                onPressed: () {debugPrint('-');widget.onExpressionCalcChanged("-");},
                child: const Text('-',
                    style: TextStyle(color: Colors.white, fontSize: 20)),
              )),
              Expanded(child: TextButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.teal),
                  shape: MaterialStatePropertyAll(ContinuousRectangleBorder()),
                ),
                onPressed: () {debugPrint('/');widget.onExpressionCalcChanged("/");},
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