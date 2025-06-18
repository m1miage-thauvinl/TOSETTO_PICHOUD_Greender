import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:tosetto_pichoud_greender/presentation/pages/recipePage.dart';
import 'package:tosetto_pichoud_greender/presentation/widgets/ingredientsCard.dart';
import 'package:tosetto_pichoud_greender/models/vegetable.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

class Ingredientspage extends StatefulWidget {

  const Ingredientspage({super.key});

  @override
  State<Ingredientspage> createState() => _IngredientspageState();
}

class _IngredientspageState extends State<Ingredientspage> {
  final CardSwiperController controller = CardSwiperController();
  late var cards = [];
  List<Vegetable> all_vegetables = [];
  List<Vegetable> liked = [];
  int dislikedCount = 0;
  int currentIndex = 0;
  bool isLoading = true;

  @override
  void initState(){
    super.initState();
    loadVegetables();
  }
  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }
  Future<void> loadVegetables() async {
    final String jsonString = await rootBundle.loadString('assets/greens.json');
    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    final List<dynamic> jsonList = jsonMap['vegetables'];
    setState(() {
      all_vegetables = jsonList.map((json) => Vegetable.fromJson(json)).toList();
      cards = all_vegetables.map(IngredientsCard.new).toList();
    });
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
          children: [
            Flexible(
              child: CardSwiper(
                controller: controller,
                cardsCount: cards.length,
                onSwipe: _onSwipe,
                numberOfCardsDisplayed: 1,
                backCardOffset: const Offset(40, 40),
                padding: const EdgeInsets.all(24),
                cardBuilder: (context, index, horizontalThresholdPercentage, verticalThresholdPercentage) =>
                cards[index],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => controller.swipe(CardSwiperDirection.left),
                    child: const Icon(Icons.close, color: Colors.red, size: 48),
                  ),
                  GestureDetector(
                    onTap: () => controller.swipe(CardSwiperDirection.right),
                    child: const Icon(Icons.favorite, color: Colors.pinkAccent, size: 48),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }


  bool _onSwipe(
      int previousIndex,
      int? currentIndex,
      CardSwiperDirection direction
      ){
    if(direction == CardSwiperDirection.right) {
      liked.add(all_vegetables[previousIndex]);
    }
    if(direction == CardSwiperDirection.left){
      dislikedCount++;
    }
    if (liked.length == 5 || previousIndex == cards.length - 1) {
      final List<Vegetable> copy = List.from(liked);
      liked = [];
      Future.delayed(Duration.zero, () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RecipePage(likedVegetables: copy),
          ),
        );
      });
    }
    return true;
  }
}
