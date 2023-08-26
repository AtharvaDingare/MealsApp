import 'package:flutter_riverpod/flutter_riverpod.dart';

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
