class Vegetable {
  final String name;
  final String description;
  final String season;
  final String image;

  const Vegetable({
    required this.name,
    required this.description,
    required this.season,
    required this.image,
  });

  factory Vegetable.fromJson(Map<String, dynamic> json) {
    return Vegetable(
      name: json['name'],
      description: json['description'],
      season: json['season'],
      image: json['image'],
    );
  }
}