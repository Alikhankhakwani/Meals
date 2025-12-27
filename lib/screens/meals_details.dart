import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/providers/favorites_provider.dart';

class MealsDetailsScreen extends ConsumerWidget {
  const MealsDetailsScreen({
    super.key,
    required this.title,
    required this.meal,
    required this.imageUrl,
  });
  final Meal meal;
  final String title;
  final String imageUrl;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favroiteMeals = ref.watch(favroiteMealsProvider);
    final isFavroite = favroiteMeals.contains(meal);

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
            onPressed: () {
              final wasAdded = ref
                  .read(favroiteMealsProvider.notifier)
                  .toggleMealFavoriteStatus(meal);
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    wasAdded ? ' Meal Added as a favroite' : 'Meal Removed ',
                  ),
                ),
              );
            },
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) => RotationTransition(
                turns: Tween<double>(begin: 0.9, end: 1).animate(animation),
                child: child,
              ),
              child: Icon(
                isFavroite ? Icons.star : Icons.star_border,
                key: ValueKey(isFavroite),
              ),
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: meal.id,
              child: Image.network(
                imageUrl,
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
              ),
            ),

            SizedBox(height: 16),
            Text(
              "ingredients",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            for (final ingredient in meal.ingredients)
              Text(
                ingredient,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 12.0,
              ),

              child: Text(
                "Steps",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            for (final step in meal.steps)
              Text(
                step,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
