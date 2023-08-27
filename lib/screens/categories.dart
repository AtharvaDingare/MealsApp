import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/category.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/category_grid_item.dart';
import 'package:meals_app/providers/filters_provider.dart';

class Categories extends ConsumerWidget {
  
  const Categories({super.key});

  void _selectCategory(BuildContext context, Category category,
      List<Meal> mealsList, Map<Filter, bool> filterParameters) {
    final filteredList = mealsList
        .where((meal) => meal.categories.contains(category.id))
        .toList();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => Meals(
          title: category.title,
          meals: filteredList,
        ),
      ),
    );
    // Navigator.of(context).push(route)
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filterParameters = ref.watch(filterMealProvider);
    return GridView(
        padding: const EdgeInsets.all(30),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // number of cross axis (number of columns).
          childAspectRatio: 3.5 / 2, // changes the sizes of the grid boxes.
          crossAxisSpacing: 20, // spacing between the cross axes.
          mainAxisSpacing:
              20, // spacing between the main axes --> which are the horizontally formed axes.
        ),
        children: [
          //...availableCategories
          //    .map((category) => CategoryGridItem(category: category))
          //    .toList()
          for (final category in availableCategories)
            //Padding(
            //padding: const EdgeInsets.all(16),
            CategoryGridItem(
                category: category,
                selectCategory: () {
                  _selectCategory(context, category,
                      ref.read(filteredMealsList), filterParameters);
                }),
          //)
        ]);
  }
}
