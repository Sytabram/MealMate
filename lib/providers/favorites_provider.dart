import 'package:flutter/material.dart';
import 'package:mealmate/services/storage_service.dart';
import '../models/meal.dart';

class FavoritesProvider extends ChangeNotifier {
  final List<Meal> _favorites = <Meal>[];
  List<Meal> get meals => _favorites.toList();

  final StorageService _storageService = StorageService();
  bool _isLoading = true;
  bool get isLoading => _isLoading;
  FavoritesProvider() {
    _loadFromStorage();
  }

  Future<void> _loadFromStorage() async {
    try {
      final favorites = await _storageService.loadFavorites();
      _favorites.addAll(favorites);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
    }
  }


  void toggle(Meal meal) {
    if (_favorites.contains(meal)) {
      _favorites.remove(meal);
    } else {
      _favorites.add(meal);
    }
    _storageService.saveFavorites(_favorites);
    notifyListeners();
  }
}