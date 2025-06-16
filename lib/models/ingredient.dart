class Ingredient{
   String name = '';
   double amount = 0;
   String unit = '';

   Ingredient fromJson(Map<String, dynamic> json) {
     name = json['name'] ?? '';
     amount = json['amount'] ?? 0;
     unit = json['unit'] ?? '';
     return this;
   }


   Map<String, dynamic> toJson() {
     return {
       'name': name,
       'amount': amount,
       'unit': unit,
     };
   }
}