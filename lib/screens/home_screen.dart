import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/meal.dart';
import '../providers/favorites_provider.dart';
import '../widgets/meal_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static final List<Meal> _mockMeals = [
    Meal(id: '52772', name: 'Teriyaki Chicken Casserole', imageUrl: 'https://www.themealdb.com/images/media/meals/wvpsxx1468256321.jpg', category: 'Chicken', area: 'Japanese', ingredients: [], instructions: ''),
    Meal(id: '52893', name: 'Apple Frangipan Tart', imageUrl: 'https://www.themealdb.com/images/media/meals/wxywrq1468235067.jpg', category: 'Dessert', area: 'British', ingredients: [], instructions: ''),
    Meal(id: '52768', name: 'Smoked Haddock Kedgeree', imageUrl: 'https://www.themealdb.com/images/media/meals/utxqpt1511639216.jpg', category: 'Seafood', area: 'British', ingredients: [], instructions: ''),
    Meal(id: '52913', name: 'Beef and Mustard Pie', imageUrl: 'https://www.themealdb.com/images/media/meals/sytuqu1511553755.jpg', category: 'Beef', area: 'British', ingredients: [], instructions: ''),
    Meal(id: '52959', name: 'Baked salmon with fennel', imageUrl: 'https://www.themealdb.com/images/media/meals/1548772327.jpg', category: 'Seafood', area: 'British', ingredients: [], instructions: ''),
    Meal(id: '52804', name: 'Poutine', imageUrl: 'https://www.themealdb.com/images/media/meals/uuyrrx1487327597.jpg', category: 'Miscellaneous', area: 'Canadian', ingredients: [], instructions: ''),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('MealMate'),
          actions: [
            IconButton(onPressed: () {
            }, icon: Badge(
              isLabelVisible: context.watch<FavoritesProvider>().meals.isNotEmpty,
              label: Text(context.watch<FavoritesProvider>().meals.length.toString()),
              child: const Icon(Icons.favorite),
            )),

          ],
        ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.25,
        ),
        itemCount: _mockMeals.length,
        itemBuilder: (context, index) {
          final meal = _mockMeals[index];
          return MealCard(meal);
        },
      ),
    );
  }
}

