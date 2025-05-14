class Ingredient{
   String name = '';
   double amount = 0;
   String unit = '';

  Ingredient fromJson(json){
    name = json['name'] ?? '';
    amount = json['amount'] ?? 0;
    unit = json['unit'] ?? '';
    return this;
  }
}