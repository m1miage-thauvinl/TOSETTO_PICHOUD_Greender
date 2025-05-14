import 'package:tosetto_pichoud_greender/models/ingredient.dart';

class Recipe{
  String title = '';
  String image = '';
  List<Ingredient> usedIngredients = [];
  List <Ingredient> unusedIngredients = [];
  List<Ingredient> missedIngredients = [];

  Recipe fromJson(json){
    title = json['title'];
    print(title);
    image = json['image'];
    print(image);
    json['usedIngredients'].forEach((ingredient) => {
      usedIngredients.add(Ingredient().fromJson(ingredient))
    });
    json['unusedIngredients'].forEach((ingredient) => {
      unusedIngredients.add(Ingredient().fromJson(ingredient))
    });
    json['missedIngredients'].forEach((ingredient) => {
      missedIngredients.add(Ingredient().fromJson(ingredient))
    });
    return this;
  }
}