import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/category.dart';
import '../models/meal.dart';

class ApiService {
  static const baseUrl = "https://www.themealdb.com/api/json/v1/1";

  Future<List<Category>> getCategories() async {
    try {
      final response = await http
          .get(Uri.parse('$baseUrl/categories.php'))
          .timeout(Duration(seconds: 10));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        final list = data['categories'] as List;
        return list.map((e) => Category.fromJson(e)).toList();
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  Future<List<Meal>> getMealsByCategory(String category) async {
    try {
      final response = await http
          .get(Uri.parse('$baseUrl/filter.php?c=$category'))
          .timeout(Duration(seconds: 10));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        final list = data['meals'] as List;
        return list.map((e) => Meal.fromJson(e)).toList();
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  Future<List<Meal>> searchMeals(String query) async {
    try {
      final response = await http
          .get(Uri.parse('$baseUrl/search.php?s=$query'))
          .timeout(Duration(seconds: 10));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        final list = (data['meals'] ?? []) as List;
        return list.map((e) => Meal.fromJson(e)).toList();
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  Future<Meal?> getMealById(String id) async {
    try {
      final response = await http
          .get(Uri.parse('$baseUrl/lookup.php?i=$id'))
          .timeout(Duration(seconds: 10));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        final list = data['meals'] as List;
        if (list.isEmpty) return null;
        return Meal.fromJson(list.first);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<Meal?> getRandomMeal() async {
    try {
      final response = await http
          .get(Uri.parse('$baseUrl/random.php'))
          .timeout(Duration(seconds: 10));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        final list = data['meals'] as List;
        if (list.isEmpty) return null;
        return Meal.fromJson(list.first);
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
