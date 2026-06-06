import 'package:flutter/material.dart';
import 'package:mealmate/providers/favorites_provider.dart';
import 'package:mealmate/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => FavoritesProvider())],
      child: MaterialApp(
        title: 'MealMate',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: .fromSeed(seedColor: Colors.deepPurple),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
