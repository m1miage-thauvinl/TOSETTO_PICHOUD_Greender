import 'package:tosetto_pichoud_greender/models/ingredient.dart';

class Recipe{
  String title = '';
  String image = '';

  Recipe fromJson(Map<String, dynamic> json) {
    title = json['title'];
    image = json['image'];
    return this;
  }
}