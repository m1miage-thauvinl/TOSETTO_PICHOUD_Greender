import 'dart:convert';
import 'package:localstorage/localstorage.dart';
import '../models/detailedRecipe.dart';

class LocalStorageService{
  static final LocalStorageService _sharedInstance = LocalStorageService._internal();
  factory LocalStorageService () => _sharedInstance;
  LocalStorageService._internal();

  init() async {
    await initLocalStorage();
  }

  Future<void> addFavoriteRecipe(DetailedRecipe recipe) async {
    final String? storedData = localStorage.getItem('favorites');

    List<dynamic> favorites = [];
    if (storedData != null && storedData.isNotEmpty) {
      try {
        favorites = jsonDecode(storedData);
      } catch (e) {
        print('Erreur lors du décodage des favoris: $e');
      }
    }

    Map<String, dynamic> recipeMap;

    try {
      recipeMap = recipe.toJson();
      favorites.add(recipeMap);
      print('Favoris après ajout: $favorites');
      localStorage.setItem('favorites', jsonEncode(favorites));
    } catch (e) {
      print('Erreur lors de l\'encodage des favoris');
    }
  }

  Future<List<DetailedRecipe>> getFavoriteRecipes() async {
    final String? storedData = localStorage.getItem('favorites');

    if (storedData == null || storedData.isEmpty) {
      return [];
    }

    final List<dynamic> decodedData = jsonDecode(storedData);
    return decodedData.map((item) => DetailedRecipe.fromJson(item)).toList();
  }

  Future<void> removeFavoriteRecipe(String title) async {
    final String? storedData = localStorage.getItem('favorites');
    if (storedData == null || storedData.isEmpty) {
      return;
    }

    final List<dynamic> favorites = jsonDecode(storedData);
    favorites.removeWhere((item) => item['title'] == title);

    localStorage.setItem('favorites', jsonEncode(favorites));
  }

  Future<bool> isFavorite(String title) async {
    final String? storedData = localStorage.getItem('favorites');
    if (storedData == null || storedData.isEmpty) {
      return false;
    }

    final List<dynamic> favorites = jsonDecode(storedData);
    return favorites.any((item) => item['title'] == title);
  }
}