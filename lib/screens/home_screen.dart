import 'package:flutter/material.dart';
import 'package:my_tetris_1/components/btn_shape.dart';
import 'package:my_tetris_1/screens/game_screen.dart';
import 'package:my_tetris_1/routes/app_routes.dart';

class AppData {
  static String playerName = '';
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //controladores do input
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // Libera os recursos utilizados pelo controller quando a tela é destruída.
  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  //Função que valida o input e envia para págino de jogo
  void _startGame() {
    if (_formKey.currentState!.validate()) {
      AppData.playerName = _nameController.text.trim();

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => Gamepage(playerName: _nameController.text.trim()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/fundo.png'), // Caminho da imagem
              fit: BoxFit.cover, //  cobrir todo o fundo
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'INFORME SEU NOME',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 20),

              Form(
                key: _formKey,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Nome',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'O nome é obrigatório';
                      }
                      return null;
                    },
                  ),
                ),
              ),

              const SizedBox(height: 40),

              SizedBox(
                width: MediaQuery.of(context).size.width *0.7,
                child: BtnShape(text: 'INICIAR', onPressed: _startGame),
              ),

              const SizedBox(height: 12),

              SizedBox(
                width: MediaQuery.of(context).size.width *0.7,
                child: BtnShape(
                  text: 'RANKING',
                  onPressed: () {
                    Navigator.of(context).pushNamed(AppRoutes.ranking);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
