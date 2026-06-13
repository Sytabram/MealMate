import 'package:flutter/material.dart';
import 'package:mealmate/services/storage_service.dart';

class ThemeProvider extends ChangeNotifier {
  final StorageService _storageService = StorageService();
  bool _isDark = false;
  bool get isDark => _isDark;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  ThemeProvider() {
    _loadFromStorage();
  }

  Future<void> _loadFromStorage() async {
    try {
      final isDark = await _storageService.loadDarkMode();
      _isDark = isDark;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
    }
  }

  void toggle() {
    _isDark = !_isDark;
    _storageService.saveDarkMode(_isDark);
    notifyListeners();
  }
}