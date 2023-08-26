import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:meals_app/providers/favorites_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MealsScreen extends ConsumerWidget {
  const MealsScreen({
    super.key,
    required this.meal,
  });

  final Meal meal;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          meal.title,
        ),
        actions: [
          IconButton(
            onPressed: () {
              bool isPresent = ref
                  .read(favoriteMealsProvider.notifier)
                  .toggleMealFavoriteStatus(meal);
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(isPresent
                      ? '${meal.title} has been removed from the Favorites'
                      : '${meal.title} has been added to the Favorites'),
                ),
              );
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
