import 'package:flutter/material.dart';
import 'package:tosetto_pichoud_greender/models/detailedRecipe.dart';
import 'package:tosetto_pichoud_greender/presentation/pages/recipeDetailPage.dart';

import '../../services/localStorage.dart';

class FavoriteRecipesPage extends StatefulWidget {
  const FavoriteRecipesPage({super.key});

  @override
  State<FavoriteRecipesPage> createState() => _FavoriteRecipesPageState();
}

class _FavoriteRecipesPageState extends State<FavoriteRecipesPage> {
  List<DetailedRecipe> favoriteRecipes = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final storage = LocalStorageService();
    final recipes = await storage.getFavoriteRecipes();
    setState(() {
      favoriteRecipes = recipes;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mes recettes favorites ❤️')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : favoriteRecipes.isEmpty
          ? const Center(child: Text('Aucune recette en favori.'))
          : ListView.builder(
        itemCount: favoriteRecipes.length,
        itemBuilder: (context, index) {
          final recipe = favoriteRecipes[index];
          return ListTile(
            leading: Image.network(
              recipe.imageUrl,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.broken_image),
            ),
            title: Text(recipe.title),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () async {
              final shouldRefresh = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RecipeDetailPage(recipe: recipe)),
              );

              if (shouldRefresh == true) {
                _loadFavorites();
              }
            },
          );
        },
      ),
    );
  }
}
