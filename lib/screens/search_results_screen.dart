import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/meal.dart';
import '../providers/favorites_provider.dart';
import '../services/api_service.dart';
import '../widgets/loading_indicator.dart';
import '../widgets/meal_card.dart';
import 'favorites_screen.dart';

class SearchResultsScreen extends StatefulWidget {
  const SearchResultsScreen(this.query, {super.key});
  final String query;
  @override
  State<SearchResultsScreen> createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  final ApiService _apiService = ApiService();
  List<Meal> _meals = [];
  bool _isLoading = true;
  String? _error;

  Future<void> _loadData() async {
    try {
      final meals = await _apiService.searchMeals(widget.query);
      setState(() {
        _meals = meals;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Results: "${widget.query}"'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FavoritesScreen()),
              );
            },
            icon: Badge(
              isLabelVisible: context
                  .watch<FavoritesProvider>()
                  .meals
                  .isNotEmpty,
              label: Text(
                context.watch<FavoritesProvider>().meals.length.toString(),
              ),
              child: const Icon(Icons.favorite),
            ),
          ),
        ],
      ),
      body: _isLoading
          ? const LoadingIndicator()
          : _error != null
          ? EmptyState(
              message: _error!,
              actionLabel: 'Back',
              onAction: () => Navigator.pop(context),
            )
          : _meals.isEmpty
          ? EmptyState(
              message: 'No results found',
              actionLabel: 'Go back',
              onAction: () => Navigator.pop(context),
            )
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.25,
              ),
              itemCount: _meals.length,
              itemBuilder: (context, index) {
                final meal = _meals[index];
                return MealCard(meal);
              },
            ),
    );
  }
}
