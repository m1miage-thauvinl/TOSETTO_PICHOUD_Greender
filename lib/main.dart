import 'package:flutter/material.dart';
import 'package:tosetto_pichoud_greender/presentation/pages/ingredientsPage.dart';
import 'package:tosetto_pichoud_greender/presentation/widgets/ingredientsCard.dart';
import 'package:tosetto_pichoud_greender/models/vegetable.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const Ingredientspage(),
    );
  }
}

