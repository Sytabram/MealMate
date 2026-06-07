import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../screens/meal_detail_screen.dart';

class MealCard extends StatelessWidget {
  const MealCard(this.meal, {super.key});

  final Meal meal;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MealDetailScreen(meal)),
        );
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            Image.network(
              meal.imageUrl,
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.restaurant),
            ),
            Text(meal.name, maxLines: 2, overflow: TextOverflow.ellipsis),
          ],
        ),
      ),
    );
  }
}
