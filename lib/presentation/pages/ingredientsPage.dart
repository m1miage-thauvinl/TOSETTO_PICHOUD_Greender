import 'package:flutter/material.dart';
import 'package:tosetto_pichoud_greender/presentation/widgets/ingredientsCard.dart';
import 'package:tosetto_pichoud_greender/models/vegetable.dart';
import 'package:flutter/services.dart'; // for rootBundle
import 'dart:convert'; // for json.decode

class Ingredientspage extends StatefulWidget {

  const Ingredientspage({super.key});

  @override
  State<Ingredientspage> createState() => _IngredientspageState();
}

class _IngredientspageState extends State<Ingredientspage> {
  List<Vegetable> vegetables = [];
  int currentIndex = 0;
  //final CardSwiperController controller =  CardSwiperController();
  @override
  void initState(){
    super.initState();
    loadVegetables();
  }
  /*@override
  void dispose(){
    controller.dispose();
    super.dispose();
  }*/
  Future<void> loadVegetables() async {
    final String jsonString = await rootBundle.loadString('assets/greens.json');
    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    final List<dynamic> jsonList = jsonMap['vegetables'];
    setState(() {
      vegetables = jsonList.map((json) => Vegetable.fromJson(json)).toList();
    });
  }
  void handleSwipe(String direction) {
    if (direction == 'like') {
      print('Liked: ${vegetables[currentIndex].name}');
    } else if (direction == 'dislike') {
      print('Disliked: ${vegetables[currentIndex].name}');
    }
    setState(() {
      // Move to next vegetable after swipe
      if (currentIndex < vegetables.length - 1) {
        currentIndex++;
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page des ingrédients'),
        centerTitle: true,
      ),
      body: vegetables.isEmpty
          ? const Center(child: CircularProgressIndicator())
        : Center(
        child: IngredientsCard(candidate : vegetables[currentIndex], onSwipe : handleSwipe),  // This now works since vegetables are loaded before this line
        ),
      );
  }
}
