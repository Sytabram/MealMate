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
            Expanded(
              child: Image.network(
                category.imageUrl,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.restaurant),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                category.name,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
