// GOAL OF THIS SCREEN --> TO SHOW THE MEALS AVAILABLE INSIDE ONE CATEAGORY , HENCE IT WILL BE CALLED WHEN A SPECIFIC CATAEGORY IS PRESSED.

import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/mealsscreen.dart';
import 'package:meals_app/widgets/meals_data_item.dart';

class Meals extends StatelessWidget {
  const Meals({super.key, this.title, required this.meals});


  void _selectMeal(BuildContext context, Meal meal) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(meal: meal,),
      ),
    );
  }

  final String? title;
  final List<Meal> meals;
  @override
  Widget build(BuildContext context) {
    Widget mealsOutput = Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Uh oh... Nothing to see here!',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Theme.of(context).colorScheme.onBackground),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            'Add some $title to view them here',
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Theme.of(context).colorScheme.onBackground),
          ),
        ],
      ),
    );
    if (meals.isNotEmpty) {
      mealsOutput = ListView(
        children: [
          ...meals
              .map(
                (meal) => MealsDataItem(
                  currentmeal: meal,
                  selectMeal: () {
                    _selectMeal(context, meal);
                  },
                ),
              )
              .toList(),
        ],
      );
    }

    if (title == 'Favorites') {
      return mealsOutput;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: mealsOutput,
    );
  }
}
