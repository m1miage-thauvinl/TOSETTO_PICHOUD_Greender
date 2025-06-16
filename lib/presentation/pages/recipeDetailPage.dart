import 'package:flutter/material.dart';
import '../../models/detailedRecipe.dart';
import '../../services/localStorage.dart';

class RecipeDetailPage extends StatefulWidget {
  final DetailedRecipe recipe;

  const RecipeDetailPage({super.key, required this.recipe});

  @override
  State<RecipeDetailPage> createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends State<RecipeDetailPage> {
  final LocalStorageService storage = LocalStorageService();
  bool isFavorite = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkIfFavorite();
  }


  Future<void> _checkIfFavorite() async {
    setState(() {
      isLoading = true;
    });
    final isRecipeFavorite = await storage.isFavorite(widget.recipe.title);

    if (mounted) {
      setState(() {
        isFavorite = isRecipeFavorite;
        isLoading = false;
      });
    }
  }

  Future<void> _toggleFavorite() async {
    setState(() {
      isLoading = true;
    });

    try {
      if (isFavorite) {
        await storage.removeFavoriteRecipe(widget.recipe.title);
      } else {
        await storage.addFavoriteRecipe(widget.recipe);
      }

      if (mounted) {
        setState(() {
          isFavorite = !isFavorite;
          isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              isFavorite ? 'Recette ajoutée aux favoris !' : 'Recette retirée des favoris !',
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erreur: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Widget _buildIngredientsList() {
    final ingredients = widget.recipe.extendedIngredients;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Ingrédients',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        ...ingredients.map((ingredient) {
          // Format : quantité + unité + nom, par ex. "150 g de farine"
          final amountStr = ingredient.amount > 0 ? ingredient.amount.toString() : '';
          final unitStr = ingredient.unit.isNotEmpty ? ' ${ingredient.unit}' : '';
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0),
            child: Text(
              '$amountStr$unitStr de ${ingredient.name}',
              style: const TextStyle(fontSize: 16),
            ),
          );
        }).toList(),
      ],
    );
  }


  Widget _buildIconText(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey[700]),
        const SizedBox(width: 6),
        Text(text, style: const TextStyle(fontSize: 14)),
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    final recipe = widget.recipe;
    return WillPopScope(
        onWillPop: () async {
          Navigator.pop(context, true); // on renvoie true pour dire "reload"
          return false; // on empêche le pop automatique, on le fait manuellement
        },
    child:  Scaffold(
      appBar: AppBar(title: Text(recipe.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                recipe.imageUrl,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.broken_image, size: 100),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              recipe.title,
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildIconText(Icons.people, '${recipe.servings} '),
                if (recipe.readyInMinutes > 0)
                  _buildIconText(Icons.schedule, '${recipe.readyInMinutes} min'),
                _buildIconText(Icons.euro, 'Prix: ${recipe.pricePerServing.toStringAsFixed(2)} €'),
              ],
            ),

            const SizedBox(height: 16),

            Wrap(
              spacing: 12,
              children: [
                if (recipe.vegetarian)
                  _buildIconText(Icons.eco, 'Végétarien'),
                if (recipe.vegan)
                  _buildIconText(Icons.spa, 'Vegan'),
                if (recipe.glutenFree)
                  _buildIconText(Icons.no_food, 'Sans gluten'),
                if (recipe.dairyFree)
                  _buildIconText(Icons.free_breakfast, 'Sans lactose'),
              ],
            ),

            const SizedBox(height: 16),

            Expanded(
              child: ListView(
                children: [
                  _buildIngredientsList(),
                  const SizedBox(height: 24),
                  const Divider(),
                  const SizedBox(height: 16),
                  const Text(
                    'Instructions',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  ...recipe.instructions.map((step) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      '${step.number}. ${step.step}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  )).toList(),
                ],
              ),
            ),

            isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton.icon(
              onPressed: _toggleFavorite,
              icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
              label: Text(isFavorite ? 'Retirer des favoris' : 'Ajouter aux favoris'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                backgroundColor: isFavorite ? Colors.red : null,
              ),
            ),
          ],
        ),
      ),
    )
    );
  }
}
