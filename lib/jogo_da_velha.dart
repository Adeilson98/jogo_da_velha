import 'package:flutter/material.dart';

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
        });

        return;

      }

    }

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
      body: Column(
        children: [
          const SizedBox(height: 20),
          Text(
            'Placar - X: $_placarX | O: $_placarO',
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: GridView.builder(
              itemCount: 9,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => _fazerJogada(index),
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 5,
                          offset: const Offset(2, 2)
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        _tabuleiro[index],
                        style: TextStyle(
                          fontSize: 48,
                          color: _tabuleiro[index] == 'X'
                            ? Colors.deepPurple
                              : Colors.orange,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          if(_vencedor != null)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    '$_vencedor venceu!',
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _resetarTabuleiro,
                    child: const Text('Jogar novamente'),
                  )
                ],
              ),
            )
        ],
      ),
    );

  }

}