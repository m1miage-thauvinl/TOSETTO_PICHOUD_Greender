import 'ingredient.dart';

class DetailedRecipe {
  final int id;
  final String title;
  final String imageUrl;
  final int readyInMinutes;
  final int servings;
  final String sourceUrl;
  final bool vegetarian;
  final bool vegan;
  final bool glutenFree;
  final bool dairyFree;
  final double healthScore;
  final double pricePerServing;
  final int weightWatcherSmartPoints;
  final String summary;
  final List<String> dishTypes;
  final List<String> diets;
  final List<InstructionStep> instructions;
  final List<Ingredient> extendedIngredients;  // Ajout ici

  DetailedRecipe({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.readyInMinutes,
    required this.servings,
    required this.sourceUrl,
    required this.vegetarian,
    required this.vegan,
    required this.glutenFree,
    required this.dairyFree,
    required this.healthScore,
    required this.pricePerServing,
    required this.weightWatcherSmartPoints,
    required this.summary,
    required this.dishTypes,
    required this.diets,
    required this.instructions,
    required this.extendedIngredients,
  });

  factory DetailedRecipe.fromJson(Map<String, dynamic> recipe) {
    return DetailedRecipe(
      id: recipe['id'],
      title: recipe['title'],
      imageUrl: recipe['image'],
      readyInMinutes: recipe['readyInMinutes'],
      servings: recipe['servings'],
      sourceUrl: recipe['sourceUrl'],
      vegetarian: recipe['vegetarian'],
      vegan: recipe['vegan'],
      glutenFree: recipe['glutenFree'],
      dairyFree: recipe['dairyFree'],
      healthScore: recipe['healthScore']?.toDouble() ?? 0.0,
      pricePerServing: (recipe['pricePerServing']?.toDouble() ?? 0.0) / 10,
      weightWatcherSmartPoints: recipe['weightWatcherSmartPoints'],
      summary: recipe['summary'],
      dishTypes: List<String>.from(recipe['dishTypes']),
      diets: List<String>.from(recipe['diets']),
      instructions: (recipe['analyzedInstructions'] as List)
          .expand((instruction) => instruction['steps'])
          .map<InstructionStep>((step) => InstructionStep.fromJson(step))
          .toList(),
      extendedIngredients: (recipe['extendedIngredients'] as List)
          .map<Ingredient>((item) => Ingredient().fromJson(item))
          .toList(),  // Parsing ici
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'image': imageUrl,
      'readyInMinutes': readyInMinutes,
      'servings': servings,
      'sourceUrl': sourceUrl,
      'vegetarian': vegetarian,
      'vegan': vegan,
      'glutenFree': glutenFree,
      'dairyFree': dairyFree,
      'weightWatcherSmartPoints': weightWatcherSmartPoints,
      'healthScore': healthScore,
      'pricePerServing': pricePerServing,
      'summary': summary,
      'diets': diets,
      'dishTypes': dishTypes,
      'analyzedInstructions': [
        {
          'name': '',
          'steps': instructions.map((step) => step.toJson()).toList(),
        }
      ],
      'extendedIngredients': extendedIngredients.map((i) => i.toJson()).toList(),  // Serialization ici
    };
  }
}

class InstructionStep {
  final int number;
  final String step;

  InstructionStep({
    required this.number,
    required this.step,
  });

  factory InstructionStep.fromJson(Map<String, dynamic> json) {
    return InstructionStep(
      number: json['number'],
      step: json['step'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'step': step,
    };
  }
}

