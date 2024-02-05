import 'package:flutter/material.dart';
import 'package:testando_criacao/components/display.dart';
import 'package:testando_criacao/components/keyboard.dart';
import 'package:testando_criacao/models/memory.dart';

class CalculadoraWidget extends StatefulWidget {
  const CalculadoraWidget({super.key});

  @override
  State<CalculadoraWidget> createState() => _CalculadoraWidgetState();
}

class _CalculadoraWidgetState extends State<CalculadoraWidget> {
  final Memoria memory = Memoria();


  _onPressed(String text){
    setState(() {
      memory.applyCommand(text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Column(
        children: <Widget>[
          Display(memory.getValue()),
          Keyboard(cb: _onPressed),
        ],
      ),
    );
  }
}