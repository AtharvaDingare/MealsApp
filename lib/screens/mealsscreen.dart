import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:transparent_image/transparent_image.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen(
      {super.key, required this.meal, required this.addtoFavorites});

  final Meal meal;
  final void Function(Meal) addtoFavorites;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          meal.title,
        ),
        actions: [
          IconButton(
            onPressed: () {
              addtoFavorites(meal);
            },
            icon: const Icon(Icons.star),
          ),
        ],
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: ListView(
        children: [
          FadeInImage(
            placeholder: MemoryImage(kTransparentImage),
            image: NetworkImage(meal.imageUrl),
          ),
          Text(
            'Ingredients',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: const Color.fromARGB(255, 186, 106, 100),
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 10,
          ),
          Column(
            children: [
              ...meal.ingredients
                  .map(
                    (ingredient) => Text(
                      ingredient,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.white),
                    ),
                  )
                  .toList(),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Steps',
            style: TextStyle(
              color: Color.fromARGB(255, 186, 106, 100),
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 10,
          ),
          Column(
            children: [
              ...meal.steps
                  .map(
                    (steps) => Text(
                      steps,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Colors.white,
                          ),
                    ),
                  )
                  .toList(),
            ],
          ),
        ],
      ),
    );
  }
}
