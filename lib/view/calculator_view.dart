import 'package:flutter/material.dart';

class CalculatorView extends StatefulWidget {
  const CalculatorView({super.key});

  @override
  State<CalculatorView> createState() => _CalculatorViewState();
}

class _CalculatorViewState extends State<CalculatorView> {
  final _textController = TextEditingController();
  final List<String> _history = [];
  List<String> lstSymbols = [
    "C",
    "←",
    "%",
    "/",
    "7",
    "8",
    "9",
    "*",
    "4",
    "5",
    "6",
    "-",
    "1",
    "2",
    "3",
    "+",
    "0",
    ".",
    "=",
  ];

  int first = 0;
  int second = 0;
  String operation = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Sachin Calculator App',
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blue.shade200,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Display Area
            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.deepPurple.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (_history.isNotEmpty)
                    Text(
                      _history.join(" "),
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black26,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  Text(
                    _textController.text,
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Grid of Buttons
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 12.0,
                  mainAxisSpacing: 12.0,
                ),
                itemCount: lstSymbols.length,
                itemBuilder: (context, index) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _getButtonColor(lstSymbols[index]),
                      foregroundColor: _getTextColor(lstSymbols[index]),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 4,
                    ),
                    onPressed: () {
                      final symbol = lstSymbols[index];
                      setState(() {
                        if (symbol == "C") {
                          _textController.text = "";
                          first = 0;
                          second = 0;
                          operation = "";
                          _history.clear();
                        } else if (symbol == "\u2190") {
                          if (_textController.text.isNotEmpty) {
                            _textController.text = _textController.text
                                .substring(0, _textController.text.length - 1);
                          }
                        } else if (symbol == "+" ||
                            symbol == "-" ||
                            symbol == "*" ||
                            symbol == "/" ||
                            symbol == "%") {
                          first = int.tryParse(_textController.text) ?? 0;
                          operation = symbol;
                          _history.add("${_textController.text} $symbol");
                          _textController.text = "";
                        } else if (symbol == "=") {
                          second = int.tryParse(_textController.text) ?? 0;
                          int result;
                          switch (operation) {
                            case "+":
                              result = first + second;
                              break;
                            case "-":
                              result = first - second;
                              break;
                            case "*":
                              result = first * second;
                              break;
                            case "/":
                              result = second != 0
                                  ? first ~/ second
                                  : 0; // Avoid division by zero
                              break;
                            case "%":
                              result = first % second;
                              break;
                            default:
                              result = 0;
                          }
                          _history.add(_textController.text);
                          _textController.text = result.toString();
                        } else {
                          _textController.text += symbol;
                        }
                      });
                    },
                    child: Text(
                      lstSymbols[index],
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getButtonColor(String symbol) {
    if (symbol == "=") return Colors.blueAccent;
    if ("C%*/-+=".contains(symbol)) return Colors.blue.shade100;
    return Colors.grey.shade300;
  }

  Color _getTextColor(String symbol) {
    if (symbol == "=") return Colors.white;
    if ("C%*/-+=".contains(symbol)) return Colors.deepPurple;
    return Colors.black;
  }
}
