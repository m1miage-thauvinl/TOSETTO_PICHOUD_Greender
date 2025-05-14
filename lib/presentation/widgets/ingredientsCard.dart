import 'package:flutter/material.dart';
import 'package:tosetto_pichoud_greender/models/vegetable.dart';

class IngredientsCard extends StatelessWidget {
  final Vegetable candidate;
  final Function onSwipe;

  const IngredientsCard({Key? key, required this.candidate, required this.onSwipe}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details){
        if(details.localPosition.dx>0){
          onSwipe('like');
        }else{
          onSwipe('dislike');
        }
      },
    child: Card(
        elevation: 4.0,
        child: Column(
        children: [
            Image.network(candidate.image),
            Text(candidate.name),
            Text(candidate.description),
            Text(candidate.season),
        ],
      ),
    ),
    );

  }
}