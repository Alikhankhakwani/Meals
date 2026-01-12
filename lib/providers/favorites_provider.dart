import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart';

class FavroiteMealNotifier extends StateNotifier<List<Meal>> {
  FavroiteMealNotifier() : super([]);

  bool toggleMealFavoriteStatus(Meal meal) {
    final mealIsFavroite = state.contains(meal);
    if (mealIsFavroite) {
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
    }
    return true;
  }
}

final favroiteMealsProvider =
    StateNotifierProvider<FavroiteMealNotifier, List<Meal>>((ref) {
      return FavroiteMealNotifier();
    });
