import 'package:flutter/material.dart';
import 'package:tosetto_pichoud_greender/models/vegetable.dart';

class IngredientsCard extends StatelessWidget {
  final Vegetable vegetable;

  const IngredientsCard( this.vegetable,{
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ]
      ),
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(vegetable.image),
                  fit: BoxFit.cover,
              )
            ),
          ),
          ),
          Padding(padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                vegetable.name,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                vegetable.description,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                vegetable.season,
                style: const TextStyle(color: Colors.grey),
              )
            ],
          ),)
        ],
      ),
    );

  }
}