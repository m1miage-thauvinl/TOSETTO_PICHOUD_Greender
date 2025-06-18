import 'package:flutter/material.dart';
import 'package:tosetto_pichoud_greender/presentation/pages/recipeDetailPage.dart';

import '../../models/recipe.dart';
import '../../models/vegetable.dart';
import '../../services/spoonacular.dart';
class RecipePage extends StatefulWidget {
  final List<Vegetable> likedVegetables;
  const RecipePage({super.key, required this.likedVegetables});

  @override
  State<RecipePage> createState() => _RecipePageState();
}
class _RecipePageState extends State<RecipePage> {
  final service = SpoonacularService();
  List<Recipe> recipes = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchRecipes();
  }

  Future<void> fetchRecipes() async {
    try {
      final results = await service.getRecipesFromIngredients(widget.likedVegetables);
      setState(() {
        recipes = results;
        isLoading = false;
      });
    } catch (e) {
      debugPrint('Erreur: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Recettes 🍽️')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : recipes.isEmpty
          ? const Center(child: Text('Aucune recette trouvée.'))
          : ListView.builder(
        itemCount: recipes.length,
        itemBuilder: (context, index) {
          final recipe = recipes[index];
          return ListTile(
            leading: Image.network(
              recipe.image,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image),
            ),
            title: Text(recipe.title),
            onTap: () async {
              final detailedRecipe = await service.getDetailedRecipe(recipe.title);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => RecipeDetailPage(recipe: detailedRecipe),
                  ),
              );
            },
          );
        },
      ),
    );
  }
}
