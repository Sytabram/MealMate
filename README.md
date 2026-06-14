# MealMate
Bryan Zweiacker

## Description
MealMate is a Flutter mobile application for discovering recipes from around the world using the TheMealDB API. Users can browse categories, search for recipes, view detailed instructions and ingredients, and save their favorite recipes locally.

## How to run
1. Make sure you have Flutter 3.41 or higher installed (`flutter --version`)
2. Clone the repository
3. Install dependencies:
   ```
   flutter pub get
   ```
4. Run the app on an Android emulator:
   ```
   flutter run
   ```

## Dependencies
- `provider` ^6.1.2 - state management
- `http` ^1.2.2 - API calls to TheMealDB
- `shared_preferences` ^2.3.2 - local storage for favorites and dark mode
- `url_launcher` ^6.3.1 - opening YouTube links

## Technical choices
The app follows the folder structure imposed by the project requirements, separating models, services, providers, screens, and widgets. State management relies entirely on Provider with two ChangeNotifiers: FavoritesProvider and ThemeProvider, both wired through MultiProvider at the root of the app and both persisted with SharedPreferences. All API calls go through ApiService, with try/catch blocks, a 10 second timeout, and null-safe JSON parsing to avoid crashes on missing fields or network failures. Reusable widgets such as MealCard, CategoryCard, DailyMealCard, FavoriteMealTile, LoadingIndicator, and EmptyState help keep the screens consistent and avoid code duplication. Navigation between screens uses Navigator.push with constructor parameters to pass Meal and Category objects.

## SUS score
Average score: 96.67 / 100 (See doc/SUS-MealMate-Bryan-Zweiacker.xlsx).

The app is considered very user-friendly and intuitive to navigate.

Area for improvement: Q10 suggests that the user experience could be more enjoyable —
for example, by displaying more information about recipes in the grid view (preparation time,
difficulty) to help users make a choice before opening the full details.

## AI tools used
Claude for:
- FlexibleSpaceBar animation
- Some ternary logic
- Readme writing
- Code review
