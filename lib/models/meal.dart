class Meal {
  final String id;
  final String name;
  final String imageUrl;
  final String category;
  final String area;
  final String instructions;
  final List<String> ingredients;
  final String? youtubeUrl;

  Meal({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.category,
    required this.area,
    required this.instructions,
    required this.ingredients,
    this.youtubeUrl
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      id: json['idMeal'] ?? '',
      name: json['strMeal'] ?? '',
      imageUrl: json['strMealThumb'] ?? '',
      category: json['strCategory'] ?? '',
      area: json['strArea']?? '',
      instructions: json['strInstructions'] ?? '',
      ingredients: [
        for (int i = 1; i <= 20; i++)
          if (json['strIngredient$i'] != null && json['strIngredient$i'] != '')
            '${json['strMeasure$i'] ?? ''} ${json['strIngredient$i']}'.trim()
      ],
      youtubeUrl: json['strYoutube'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'idMeal': id,
      'strMeal': name,
      'strMealThumb': imageUrl,
      'strCategory': category,
      'strArea': area,
      'strInstructions': instructions,
      'strYoutube': youtubeUrl,
    };
  }
}
