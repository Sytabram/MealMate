import 'package:flutter/material.dart';
import 'package:mealmate/providers/favorites_provider.dart';
import 'package:provider/provider.dart';
import '../models/meal.dart';

class MealDetailScreen extends StatelessWidget {
  const MealDetailScreen(this.meal, {super.key});

  final Meal meal;

  @override
  Widget build(BuildContext context) {
    final isFavorite = context.watch<FavoritesProvider>().meals.contains(meal);
    return Scaffold(
      appBar: AppBar(
        title:Text(meal.name),
        actions: [
          IconButton(onPressed: () {
            context.read<FavoritesProvider>().toggle(meal);
          }, icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),),

        ],
      ),
    );
  }

}