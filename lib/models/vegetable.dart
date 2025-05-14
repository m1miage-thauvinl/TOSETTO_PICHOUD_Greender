import 'package:tosetto_pichoud_greender/enums/saison.dart';

class Vegetable {
   String name = '';
   String description = '';
   List<Saison> saisons = [];
   String image = '';


  Vegetable(this.name, this.description, this.image, this.saisons);

  Map<String, dynamic> toJson(){
    return {
      "name": name,
    };
  }
}