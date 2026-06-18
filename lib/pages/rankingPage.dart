import 'package:flutter/material.dart';
import 'package:my_tetris_1/components/btnShape.dart';

class Rankingpage extends StatelessWidget {
  const Rankingpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onSurface,
      body: Center(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/fundo.png'), // Caminho da imagem
              fit: BoxFit.cover, // Faz a imagem cobrir todo o fundo
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BtnShape(
                text: 'VOLTAR PARA HOME',
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
