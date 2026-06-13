import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/favorites_provider.dart';
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
          ? const Center(child: CircularProgressIndicator())
          : favorites.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('No favourites at the moment'),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Discover recipes'),
            ),
          ],
        ),
      )
      : GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.25,
        ),
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          final meal = favorites[index];
          return MealCard(meal);
        },
      ),
    );
  }
}
