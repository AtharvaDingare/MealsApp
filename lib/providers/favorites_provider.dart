import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals_app/models/meal.dart';

class FavoritesMealsNotifier extends StateNotifier<List<Meal>> {
  FavoritesMealsNotifier() : super([]);

  bool toggleMealFavoriteStatus(Meal meal) {
    // we cannot edit the list in super (we simply cannot do that) and hence it must be replaced
    bool favoritePresent = state.contains(meal);
    if (favoritePresent) {
      state = state.where((m) => meal.id != m.id).toList();
      return true;
    } else {
      state = [...state, meal]; // ... can be used to pull out all the elements of a list as another list
      return false;
    }
  }
}

final favoriteMealsProvider =
    StateNotifierProvider<FavoritesMealsNotifier, List<Meal>>(
  (ref) => FavoritesMealsNotifier(),
);
