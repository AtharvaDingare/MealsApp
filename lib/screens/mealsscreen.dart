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
    final favoriteList = ref.watch(favoriteMealsProvider);
    bool isFavorite = favoriteList.contains(meal);
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
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) {
                // the transition builder parameter takes a function which recieves a child (as specified in the AnimatedSwitcher) and an animation , and then we need to return some transition
                return RotationTransition(
                  //turns: animation, // this is the default animation created by flutter (whose value ranges from 0 to 1)
                  turns: Tween(begin: 0.65, end: 1.0).animate(animation),
                  child: child,
                ); // there are many types of transition widgets like fadetransition , rotationtransition etc , in our case rotationtransition widget is something that would rotate the child widget that they recieve.
                // read the documentation to see what all types of animation are available.
              },
              child: Icon(
                isFavorite ? Icons.star : Icons.star_border,
                key: ValueKey(isFavorite),
              ), // the child on which the transition is to be applied.
            ),
          ),
        ],
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: ListView(
        children: [
          Hero(
            tag: meal.id,
            child: FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(meal.imageUrl),
            ),
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
