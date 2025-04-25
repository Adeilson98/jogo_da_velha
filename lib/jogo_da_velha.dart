import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';

class JogoDaVelha extends StatefulWidget {

  @override
  State<JogoDaVelha> createState() => _JogoDaVelhaState();

}

class _JogoDaVelhaState extends State<JogoDaVelha> {

  List<String> _tabuleiro = List.filled(9, '');
  String _jogadorAtual = 'X';
  String? _vencedor;
  int _placarX = 0;
  int _placarO = 0;

  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(
        duration: const Duration(seconds: 2),
    );
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  void _resetarTabuleiro() {

    setState(() {
      _tabuleiro = List.filled(9, '');
      _vencedor = null;
      _jogadorAtual = 'X';
    });

  }

  void _resetarPlacar() {

    setState(() {
      _placarX = 0;
      _placarO = 0;
      _resetarTabuleiro();
    });

  }

  void _fazerJogada(int index) {

    if(_tabuleiro[index] == '' && _vencedor == null) {

      setState(() {
        _tabuleiro[index] = _jogadorAtual;
        _verificarVencedor();
        _jogadorAtual = _jogadorAtual == 'X' ? 'O' : 'X';
      });

    }

  }

  void _verificarVencedor() {

    List<List<int>> combinacoes = [
      [0,1,2], [3,4,5], [6,7,8], //linhas
      [0,3,6], [1,4,7], [2,5,8], //colunas
      [0,4,8], [2,4,6]           //diagonais
    ];

    for(var combinacao in combinacoes) {

      String a = _tabuleiro[combinacao[0]];
      String b = _tabuleiro[combinacao[1]];
      String c = _tabuleiro[combinacao[2]];

      if(a != '' && a == b && b == c) {

        setState(() {
          _vencedor = a;
          if(a == 'X') {

            _placarX++;

          } else {

            _placarO++;

          }

          _confettiController.play();

        });

        return;

      }

    }

  }

  Widget _construirCelula(int index) {
    return GestureDetector(
      onTap: () => _fazerJogada(index),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade600),
        ),
        child: Center(
          child: Text(
            _tabuleiro[index],
            style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Jogo da Velha'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Zerar placar',
            onPressed: _resetarPlacar,
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Vez de: $_jogadorAtual',
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 300,
                height: 300,
                child: GridView.builder(
                  itemCount: 9,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemBuilder: (context, index) => _construirCelula(index),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Placar - X: $_placarX | O: $_placarO',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 20),
              if(_vencedor != null)
                Column(
                  children: [
                    AnimatedScale(
                      scale: 1.2,
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeOutBack,
                      child: Text(
                        '$_vencedor venceuu!',
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: _resetarTabuleiro,
                      child: const Text('Jogar novamente'),
                    )
                  ],
                )
            ],
          ),
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              colors: const [
                Colors.red,
                Colors.green,
                Colors.blue,
                Colors.orange,
                Colors.purple,
              ],
            ),
          ),
        ],
      ),
    );

  }

}