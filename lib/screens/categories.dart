import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/category.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/category_grid_item.dart';
import 'package:meals_app/providers/filters_provider.dart';

class Categories extends ConsumerStatefulWidget {
  const Categories({super.key});

  @override
  ConsumerState<Categories> createState() {
    return _CategoriesState();
  }
}

class _CategoriesState extends ConsumerState<Categories>
    with SingleTickerProviderStateMixin {
  // ANIMATION INCLUSION --:
  // you have to use with keyword and include another class which is either Singletickerproviderstatemixin or tickerproviderstatemixin
  // if you want to manage more than one animation , then include tickerproviderstatemixin
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync:
          this, // this is some in-built function shit that has to be present (and you have to include that ticker class to use this keyword over there)
      duration: const Duration(
        milliseconds: 300,
      ), // this is the duration for which the animation will run
      lowerBound: 0, // which 2 values the animation will run between
      upperBound:
          1, // there are some factors that you might want to add and they might depend on the current value of the animation (which is between specified values)
    );

    _animationController
        .forward(); // this is a must to start any animation , it basically starts the animation.
  }

  @override
  void dispose() {
    _animationController
        .dispose(); // this makes sure that this animation controller is removed from the device memory when this widget (categories) is removed.
    super
        .dispose(); // disposing this animation makes sure that we dont create any memory issues
  }

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
  Widget build(BuildContext context) {
    final filterParameters = ref.watch(filterMealProvider);
    return AnimatedBuilder(
      // the animated builder is basically a widget that contains an animation and a builder function that returns the stuff that is supposed to be animated.
      animation:
          _animationController, // this is the animation , basically a variable of type Animationcontroller that has all the details regarding the duration , lower/upper bounds of an animation , etc etc.
      child: GridView(
        // the child parameter of the animatedbuilder contains the stuff that actually WILL NOT BE ANIMATED. DUE TO THE PURPOSE OF INCRASING OUR APP PERFORMANCE WE ONLY ANIMATE THE PADDING WIDGET AND NOT THE ENTIRE GRIDVIEW WIDGET !
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
                _selectCategory(
                  context,
                  category,
                  ref.read(filteredMealsList),
                  filterParameters,
                );
              },
            ),
          //)
        ],
      ),
      //builder: (context, child) => Padding(
      //  // the builder is basically a function that takes in 2 parameters , the context and child , and it returns a widget that WILL ACTUALLY BE ANIMATED
      //  padding: EdgeInsets.only(
      //    top: ((1 - _animationController.value) *
      //        300), // the logic for animation , the animatedbuilder will go from lowerbound 0 to upperbound 1 , and thus the padding from the top will adjust itself thereby generating motion.
      //  ),
      //  child:
      //      child, // the child is the thing that we have mentioned above , hence we are only animating the padding widget , rest remains same thereby improving performance.
      //),
      builder: (context, child) => SlideTransition(
        // slide transition is a build-in widget in flutter that provides such a slding animation
        position: //_animationController.drive(
            // the position parameter basically needs a .drive method of the animation that we have.
            Tween(
          // the drive method needs a Animatable child , and Tween is such a animatable child , and thus we use it.
          begin: const Offset(0,0.4), // the begin parameter is used to specify where do you want the sliding effect to begin
          end: const Offset(0,0), // the end parameter is used to specify where do you want the sliding effect to end.
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.decelerate,
          ),
        ), // offset basically means the difference between the ideal location of a particular widget (in this case , the child) and the location where we want it to be , (so 0.0 means no difference and 0.4 means a difference of 40%)
        //),
        child: child, // this is the child about to be animated.
      ),
    );
  }
}
