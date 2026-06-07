import 'package:flutter/material.dart';

import '../models/category.dart';
import '../screens/category_screen.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard(this.category, {super.key});

  final Category category;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CategoryScreen(category)),
        );
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            Image.network(
              category.imageUrl,
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.restaurant),
            ),
            Text(category.name),
          ],
        ),
      ),
    );
  }
}
