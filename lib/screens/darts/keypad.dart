import "package:flutter/material.dart";

typedef void KeypadButtonTapCallback(String buttonText);

class KeypadButton extends StatelessWidget {
  KeypadButton(this.onTap, this.buttonText);
  final String buttonText;
  final KeypadButtonTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: MaterialButton(
        color: buttonText == "DEL"
            ? Colors.red
            : buttonText == "OK"
                ? Colors.green
                : Colors.grey[900],
        onPressed: () => onTap(buttonText),
        child: Text(
          buttonText,
          style: TextStyle(
            color: Colors.white,
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class KeypadRow extends StatelessWidget {
  final List<String> symbols;
  final KeypadButtonTapCallback onTap;
  final double spacing;

  KeypadRow(this.onTap, this.symbols, this.spacing);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          KeypadButton(onTap, symbols[0]),
          Container(width: spacing),
          KeypadButton(onTap, symbols[1]),
          Container(width: spacing),
          KeypadButton(onTap, symbols[2]),
        ],
      ),
    );
  }
}

class Keypad extends StatelessWidget {
  Keypad(this.onTap, this.spacing);
  final double spacing;
  final KeypadButtonTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      KeypadRow(onTap, ["1", "2", "3"], spacing),
      Container(height: spacing),
      KeypadRow(onTap, ["4", "5", "6"], spacing),
      Container(height: spacing),
      KeypadRow(onTap, ["7", "8", "9"], spacing),
      Container(height: spacing),
      KeypadRow(onTap, ["DEL", "0", "OK"], spacing),
    ]);
  }
}