import 'package:flutter/material.dart';
import 'package:tosetto_pichoud_greender/presentation/pages/mainPage.dart';
import 'package:tosetto_pichoud_greender/services/localStorage.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  LocalStorageService().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MainPage(),
    );
  }
}

