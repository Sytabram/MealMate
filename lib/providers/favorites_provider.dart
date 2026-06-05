import 'package:flutter/material.dart';
import '../models/meal.dart';

class FavoritesProvider extends ChangeNotifier {
  final List<Meal> _favorites = <Meal>[];
  List<Meal> get meals => _favorites.toList();

  void toggle(Meal meal) {
    if (_favorites.contains(meal)) {
      _favorites.remove(meal);
    } else {
      _favorites.add(meal);
    }
    notifyListeners();
  }
}