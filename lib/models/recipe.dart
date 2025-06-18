class Recipe{
  String title = '';
  String image = '';

  Recipe fromJson(Map<String, dynamic> json) {
    title = json['title'];
    image = json['image'];
    return this;
  }
}