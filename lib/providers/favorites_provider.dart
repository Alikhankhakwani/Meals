import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart';

class FavoriteMealsNotifier extends Notifier<List<Meal>> {
  @override
  List<Meal> build() {
    return []; // initial empty list
  }

  bool toggleMealFavoriteStatus(Meal meal) {
    final mealIsFavorite = state.contains(meal);

    if (mealIsFavorite) {
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

// Provider
final favoriteMealsProvider =
    NotifierProvider<FavoriteMealsNotifier, List<Meal>>(
      FavoriteMealsNotifier.new,
    );
