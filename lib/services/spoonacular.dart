import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tosetto_pichoud_greender/models/recipe.dart';
import 'package:tosetto_pichoud_greender/models/vegetable.dart';

import '../models/detailedRecipe.dart';

  class SpoonacularService {
  final String _apiKey = '81ad68fa37fa446e8b71b194bfb79201';
  Future<List<Recipe>> getRecipesFromIngredients(List<Vegetable> vegetables) async {
    String query = vegetables.map((v) => v.name).join(',');
    final uri = Uri.https(
      'api.spoonacular.com',
      '/recipes/findByIngredients',
      {
        'ingredients': query,
        'apiKey': _apiKey,
      },
    );

    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final List<dynamic> decoded = jsonDecode(response.body);
      return decoded.map((recipeJson) => Recipe().fromJson(recipeJson)).toList();
    } else {
      throw Exception('Erreur Spoonacular: ${response.statusCode}');
    }
  }

  Future<DetailedRecipe> getDetailedRecipe(String title) async {
    final uri = Uri.https(
      'api.spoonacular.com',
      '/recipes/complexSearch',
      {
        'query': title,
        'addRecipeInformation': 'true',
        'addRecipeInstructions': 'true',
        'fillIngredients' : 'true',
        'number': '1',
        'apiKey': _apiKey,
      },
    );

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> decoded = jsonDecode(response.body);
      if (decoded['results'] != null && decoded['results'] is List && decoded['results'].isNotEmpty) {
        final Map<String, dynamic> recipeJson = decoded['results'][0];
        return DetailedRecipe.fromJson(recipeJson);
      } else {
        throw Exception('Aucune recette trouvée pour ce titre.');
      }
    } else {
      throw Exception('Erreur Spoonacular: ${response.statusCode}');
    }
  }
  }