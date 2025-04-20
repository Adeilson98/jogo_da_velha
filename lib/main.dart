import 'package:flutter/material.dart';

void main() {
  runApp(const JogoDaVelhaApp());
}

class JogoDaVelhaApp extends StatelessWidget {
  const JogoDaVelhaApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jogo da Velha',
      home: JogoDaVelha(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class JogoDaVelha extends StatefulWidget {
  @override
  _JogoDaVelhaState createState() => _JogoDaVelhaState();
}

class _JogoDaVelhaState extends State<JogoDaVelha> {
  List<String> _tabuleiro = List.filled(9, '');
  String _jogadorAtual = 'X';
  int _placarX = 0;
  int _placarO = 0;
  String _mensagem = '';

  void _fazerJogada(int index) {

    if(_tabuleiro[index] == '' && _mensagem == '') {

      setState(() {
        _tabuleiro[index] = _jogadorAtual;
        if(_verificarVencedor(_jogadorAtual)) {
          _mensagem = 'Jogador $_jogadorAtual venceu!';
          if(_jogadorAtual == 'X') {
            _placarX++;
          } else {
            _placarO++;
          }
          _mostrarDialog(_mensagem);
        } else if (!_tabuleiro.contains('')) {
          _mensagem = 'Empate!';
          _mostrarDialog(_mensagem);
        } else {
          _jogadorAtual = _jogadorAtual == 'X' ? 'O' : 'X';
        }
      });

    }

  }

  void _mostrarDialog(String titulo) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(titulo),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _reiniciarJogo();
              },
              child: Text('Jogar Novamente'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  _reiniciarJogo();
                  _placarX = 0;
                  _placarO = 0;
                });
              },
              child: Text('Resetar Placar'),
            ),
          ],
        );
      },
    );
  }

  bool _verificarVencedor(String jogador) {
    List<List<int>> combinacoes = [
      [0,1,2], [3,4,5], [6,7,8], //Lihas
      [0,3,6], [1,4,7], [2,5,8], //Colunas
      [0,4,8], [2,4,6], //Diagonais
    ];

    for(var combinacao in combinacoes) {
      if(_tabuleiro[combinacao[0]] == jogador && _tabuleiro[combinacao[1]] == jogador && _tabuleiro[combinacao[2]] == jogador) {
        return true;
      }
    }

    return false;
  }

  void _reiniciarJogo() {
    setState(() {
      _tabuleiro = List.filled(9, '');
      _jogadorAtual = 'X';
      _mensagem = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jogo da Velha'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Placar',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text('X: $_placarX    O: $_placarO',
              style: TextStyle(fontSize: 20)),
          SizedBox(height: 20),
          GridView.builder(
            shrinkWrap: true,
            itemCount: 9,
            gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => _fazerJogada(index),
                child: Container(
                  margin: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    border: Border.all(),
                    color: Colors.grey[200],
                  ),
                  child: Center(
                    child: Text(
                      _tabuleiro[index],
                      style: TextStyle(fontSize: 40),
                    ),
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 20),
          Text(
            _mensagem,
            style: TextStyle(fontSize: 20, color: Colors.blue),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: _reiniciarJogo,
            child: Text('Reiniciar'),
          )
        ],
      ),
    );
  }

}
