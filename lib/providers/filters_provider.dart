import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/meals_provider.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class FilterMealNotifier extends StateNotifier<Map<Filter, bool>> {
  FilterMealNotifier()
      : super(
          {
            Filter.glutenFree: false,
            Filter.lactoseFree: false,
            Filter.vegetarian: false,
            Filter.vegan: false
          },
        );

  void changeFilters(Map<Filter, bool> filterStatus) {
    state = filterStatus;
  }

  void changeFilter(Filter filter, bool check) {
    state = {
      ...state,
      filter: check,
    };
  }
}

final filterMealProvider =
    StateNotifierProvider<FilterMealNotifier, Map<Filter, bool>>(
  (ref) => FilterMealNotifier(),
);

final filteredMealsList = Provider((ref) {
  final mealsList = ref.watch(mealsProvider);
  final filterState = ref.watch(filterMealProvider);
  return mealsList.where((meal) {
    if ((filterState[Filter.glutenFree]!) && (!meal.isGlutenFree)) {
      return false;
    }
    if ((filterState[Filter.lactoseFree]!) && (!meal.isLactoseFree)) {
      return false;
    }
    if ((filterState[Filter.vegetarian]!) && (!meal.isVegetarian)) {
      return false;
    }
    if ((filterState[Filter.vegan]!) && (!meal.isVegan)) {
      return false;
    }
    return true;
  }).toList();
});
