import 'package:flutter/material.dart';
import 'package:mealmate/providers/favorites_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/meal.dart';
import '../services/api_service.dart';
import '../widgets/loading_indicator.dart';

class MealDetailScreen extends StatefulWidget {
  const MealDetailScreen(this.meal, {super.key});
  final Meal meal;
  @override
  State<MealDetailScreen> createState() => _MealDetailScreenState();
}

class _MealDetailScreenState extends State<MealDetailScreen> {
  final ApiService _apiService = ApiService();
  Meal? _meal;
  bool _isLoading = true;
  String? _error;

  Future<void> _loadData() async {
    try {
      final meal = await _apiService.getMealById(widget.meal.id);
      if (meal == null) {
        setState(() {
          _error = 'Unable to load recipe. Check your internet connection.';
          _isLoading = false;
        });
        return;
      }
      setState(() {
        _meal = meal;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    final isFavorite = context.watch<FavoritesProvider>().isFavorite(
      widget.meal.id,
    );
    return Scaffold(
      body: _isLoading
          ? const LoadingIndicator()
          : _error != null
          ? EmptyState(
              message: _error!,
              actionLabel: 'Back',
              onAction: () => Navigator.pop(context),
            )
          : CustomScrollView(
              slivers: [
                SliverAppBar(
                  iconTheme: const IconThemeData(color: Colors.white),
                  expandedHeight: 250,
                  pinned: true,
                  flexibleSpace: LayoutBuilder(
                    builder: (context, constraints) {
                      final settings = context
                          .dependOnInheritedWidgetOfExactType<FlexibleSpaceBarSettings>();
                      final deltaExtent = settings!.maxExtent - settings.minExtent;
                      final t = (1.0 -
                          (settings.currentExtent - settings.minExtent) / deltaExtent)
                          .clamp(0.0, 1.0);

                      final startPad = 16.0 + (40.0 * t);
                      final endPad = 16.0 + (40.0 * t);

                      return FlexibleSpaceBar(
                        centerTitle: true,
                        titlePadding: EdgeInsetsDirectional.only(
                          start: startPad,
                          end: endPad,
                          bottom: 16,
                        ),
                        title: Text(
                          _meal!.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.white),
                        ),
                        background: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.network(_meal!.imageUrl, fit: BoxFit.cover),
                            Container(color: Colors.black.withValues(alpha: 0.3)),
                          ],
                        ),
                      );
                    },
                  ),
                  actions: [
                    IconButton(
                      onPressed: () {
                        context.read<FavoritesProvider>().toggle(_meal!);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              isFavorite
                                  ? 'Removed from favorites'
                                  : 'Added to favorites',
                            ),
                          ),
                        );
                      },
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                      ),
                    ),
                  ],
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        if (_meal!.category.isNotEmpty)
                          Chip(label: Text(_meal!.category)),
                        if (_meal!.area.isNotEmpty)
                          Chip(label: Text(_meal!.area)),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Ingredients',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        ..._meal!.ingredients.map((i) => Text(i)),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Instructions',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Text(_meal!.instructions),
                      ],
                    ),
                  ),
                ),
                if (_meal!.youtubeUrl != null && _meal!.youtubeUrl!.isNotEmpty)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () => launchUrl(
                          Uri.parse(_meal!.youtubeUrl!),
                          mode: LaunchMode.externalApplication,
                        ),
                        child: const Text('Watch video'),
                      ),
                    ),
                  ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: MediaQuery.of(context).padding.bottom + 8,
                  ),
                ),
              ],
            ),
    );
  }
}
