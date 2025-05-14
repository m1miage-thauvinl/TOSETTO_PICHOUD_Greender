import 'package:localstorage/localstorage.dart';
import 'package:tosetto_pichoud_greender/models/vegetable.dart';

class LocalStorageService{
  static final LocalStorageService _sharedInstance = LocalStorageService._internal();
  factory LocalStorageService () => _sharedInstance;
  LocalStorageService._internal();

  init() async {
    await initLocalStorage();
  }
  Future<void> saveVegetable(Vegetable vegetable) async {
    List<String> saved = List<String>.from(localStorage.getItem('savedVegetables') as List? ?? []);
    if (!saved.contains(vegetable.name)) {
      saved.add(vegetable.name);
      localStorage.setItem('savedVegetables', saved as String);
    }
  }


Future<List<String>> getSavedVegetables() async {
  return List<String>.from(localStorage.getItem('savedVegetables') as List? ?? []);
}
}