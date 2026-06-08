import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mealmate/models/meal.dart';

class StorageService {

  Future<List<Meal>> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('favorites_v1');
    if (data == null) return [];
    final list = jsonDecode(data) as List;
    return list.map((e) => Meal.fromJson(e)).toList();
  }
  Future<void> saveFavorites(List<Meal> meals) async {
    final prefs = await SharedPreferences.getInstance();

    final data = jsonEncode(meals.map((m) => m.toJson()).toList());
    prefs.setString('favorites_v1', data);
  }
  Future<void> clearFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('favorites_v1');
  }
  Future<bool> loadDarkMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('dark_mode') ?? false;
  }
  Future<void> saveDarkMode(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('dark_mode', isDark);
  }
}