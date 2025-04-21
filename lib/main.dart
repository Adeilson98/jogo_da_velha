import 'package:flutter/material.dart';
import 'package:jogo_da_velha/tela_inicial.dart';

void main() {
  runApp(const JogoDaVelhaApp());
}

class JogoDaVelhaApp extends StatefulWidget {
  const JogoDaVelhaApp({super.key});

  // This widget is the root of your application.
  @override
  State<JogoDaVelhaApp> createState() => _JogoDaVelhaState();
}

class _JogoDaVelhaState extends State<JogoDaVelhaApp> {

  bool _modoEscuro = false;

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Jogo da Velha',
      theme: _modoEscuro
      ? ThemeData.dark()
      : ThemeData.light().copyWith(
        primaryColor: Colors.deepPurple,
        scaffoldBackgroundColor: Colors.grey[100],
        textTheme: ThemeData.light().textTheme.copyWith(
          bodyLarge: const TextStyle(fontSize: 20),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: TelaInicial(
        modoEscuro: _modoEscuro,
        alternarTema: () {
          setState(() {
            _modoEscuro = !_modoEscuro;
          });
        },
      ),
    );

  }

}
