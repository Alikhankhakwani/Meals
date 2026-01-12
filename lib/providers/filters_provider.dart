import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart'; // if needed for the filtered provider
import 'package:meals/providers/meal_providers.dart'; // existing provider file with `mealsProvider`

enum Filter { glutenFree, lactoseFree, vegetarian, vegan }

class FiltersNotifier extends Notifier<Map<Filter, bool>> {
  @override
  Map<Filter, bool> build() {
    return {
      Filter.glutenFree: false,
      Filter.lactoseFree: false,
      Filter.vegetarian: false,
      Filter.vegan: false,
    };
  }

  void setFilter(Filter filter, bool isActive) {
    state = {...state, filter: isActive};
  }

  void setAllFilters(Map<Filter, bool> chosenFilters) {
    state = chosenFilters;
  }
}

// Main filters provider
final filtersProvider = NotifierProvider<FiltersNotifier, Map<Filter, bool>>(
  FiltersNotifier.new,
);

// Filtered meals provider (auto-recomputes when filters or meals change)
final filteredMealsProvider = Provider<List<Meal>>((ref) {
  final meals = ref.watch(mealsProvider);
  final activeFilters = ref.watch(filtersProvider);

  return meals.where((meal) {
    if (activeFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
      return false;
    }
    if (activeFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
      return false;
    }
    if (activeFilters[Filter.vegetarian]! && !meal.isVegetarian) {
      return false;
    }
    if (activeFilters[Filter.vegan]! && !meal.isVegan) {
      return false;
    }
    return true;
  }).toList();
});
