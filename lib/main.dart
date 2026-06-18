import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_tetris_1/pages/gamePage.dart';
import 'package:my_tetris_1/pages/homePage.dart';
import 'package:my_tetris_1/pages/rankingPage.dart';
import 'package:my_tetris_1/routes/appRoutes.dart';


void main() {
  // Garante que os widgets do sistema foram inicializados
  WidgetsFlutterBinding.ensureInitialized();
  
  // Trava o app inteiro no modo Retrato
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
         
        scaffoldBackgroundColor: const Color(0xFFF7F7F7),

        colorScheme: const ColorScheme.light(
          primary: Color(0xFFAED6F1),
          secondary: Color(0xFFA2DED0),
          surface: Color(0xFFEDEDED),
          onSurface: Color(0xFF333333),
        ),
      ),

      initialRoute: AppRoutes.home,
      routes: {
        AppRoutes.home: (ctx) => HomePage(),
        AppRoutes.game: (ctx) => Gamepage(),
        AppRoutes.ranking: (ctx) => Rankingpage(),
      },
    );
  }
}
