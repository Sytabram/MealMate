import 'package:flutter/material.dart';
import 'package:mealmate/widgets/favorite_meal_tile.dart';
import 'package:provider/provider.dart';

import '../providers/favorites_provider.dart';
import '../widgets/daily_meal_card.dart';
import '../widgets/loading_indicator.dart';
import '../widgets/meal_card.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<FavoritesProvider>();
    final favorites = provider.meals;

    return Scaffold(
      appBar: AppBar(title: const Text('My favourites')),
        body: provider.isLoading
            ? const LoadingIndicator()
            : favorites.isEmpty
            ? EmptyState(
          message: 'No favourites at the moment',
          actionLabel: 'Discover recipes',
          onAction: () => Navigator.pop(context),
        )
      : ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          final meal = favorites[index];
          return Dismissible(
            key: Key(meal.id),
            direction: DismissDirection.horizontal,
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            secondaryBackground: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            onDismissed: (direction) {
              provider.toggle(meal);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${meal.name} removed from favorites')),
              );
            },
            child: FavoriteMealTile(meal),
          );
        },
      )
    );
  }
}
