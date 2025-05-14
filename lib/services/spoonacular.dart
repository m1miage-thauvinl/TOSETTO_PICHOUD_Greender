import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tosetto_pichoud_greender/models/recipe.dart';
import 'package:tosetto_pichoud_greender/models/vegetable.dart';

  class SpoonacularService {
  final String _apiKey = '81ad68fa37fa446e8b71b194bfb79201';
  final String _baseUrl = 'https://api.spoonacular.com/recipes/findByIngredients?ingredients=';

  Future<List> getRecipesFromIngredients(List<Vegetable> vegetables) async {
    String query = vegetables.map((v) => v.name).join(',');
    final uri = Uri.parse('$_baseUrl$query&apiKey=$_apiKey');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final List<dynamic> decoded = jsonDecode(response.body);
      return decoded.map((recipeJson) => Recipe().fromJson(recipeJson)).toList();
    } else {
      throw Exception('Erreur Spoonacular: ${response.statusCode}');
    }
  }


}