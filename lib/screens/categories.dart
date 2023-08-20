import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/category.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/category_grid_item.dart';

class Categories extends StatelessWidget {
  const Categories(
      {super.key,
      required this.addtoFavorites,
      required this.filterParameters});

  final void Function(Meal) addtoFavorites;
  final Map<Filter, bool> filterParameters;

  List<Meal> _filterallmeals(List<Meal> basicMeals, Map<Filter, bool> filterParameters, Category category) {
    final List<Meal> filteredList = basicMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();
    List<Meal> outputList = [];
    for (int i = 0; i < filteredList.length; i++) {
      bool check = true;
      if (filterParameters[Filter.glutenFree]!) {
        check = (check && filteredList[i].isGlutenFree);
      }
      if (filterParameters[Filter.lactoseFree]!) {
        check = (check && filteredList[i].isLactoseFree);
      }
      if (filterParameters[Filter.vegetarian]!) {
        check = (check && filteredList[i].isVegetarian);
      }
      if (filterParameters[Filter.vegan]!) {
        check = (check && filteredList[i].isVegan);
      }
      if (check) {
        outputList.add(filteredList[i]);
      }
    }
    return outputList;
  }

  void _selectCategory(BuildContext context, Category category) {
    final filteredList = _filterallmeals(dummyMeals, filterParameters, category);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => Meals(
          title: category.title,
          meals: filteredList,
          addtoFavorites: addtoFavorites,
        ),
      ),
    );
    // Navigator.of(context).push(route)
  }

  @override
  Widget build(BuildContext context) {
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
                  _selectCategory(context, category);
                }),
          //)
        ]);
  }
}
