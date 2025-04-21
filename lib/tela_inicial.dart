import 'package:flutter/material.dart';
import 'jogo_da_velha.dart';

class TelaInicial extends StatelessWidget {

  final bool modoEscuro;
  final VoidCallback alternarTema;

  const TelaInicial({
    super.key,
    required this.modoEscuro,
    required this.alternarTema,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        actions: [
          IconButton(
            icon: Icon(modoEscuro ? Icons.light_mode : Icons.dark_mode),
            onPressed: alternarTema,
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: modoEscuro ? Colors.black : Colors.deepPurple[50],
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.games, size: 100, color: Colors.deepPurple),
            const SizedBox(height: 20,),
            Text(
              'Jogo da Velha',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: modoEscuro ? Colors.white : Colors.deepPurple[800],
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    transitionDuration: const Duration(milliseconds: 500),
                    pageBuilder: (_, __, ___) => JogoDaVelha(),
                    transitionsBuilder: (_, animation, __, child) {
                      final offsetAnimation = Tween<Offset>(
                        begin: const Offset(0.0, 1.0),
                        end: Offset.zero,
                      ).animate(CurvedAnimation(
                        parent: animation,
                        curve: Curves.easeOut,
                      ));

                      return SlideTransition(
                        position: offsetAnimation,
                        child: FadeTransition(
                          opacity: animation,
                          child: child,
                        ),
                      );
                    }
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)
                ),
              ),
              child: const Text('Iniciar Jogo'),
            ),
          ],
        ),
      ),
    );
  }

}
