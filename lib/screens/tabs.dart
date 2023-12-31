import 'package:flutter/material.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/SideDrawer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/favorites_provider.dart';
import 'package:meals_app/providers/filters_provider.dart';

class TabScreen extends ConsumerStatefulWidget {
  const TabScreen({super.key});
  @override
  ConsumerState<TabScreen> createState() {
    return _TabScreenState();
  }
}

class _TabScreenState extends ConsumerState<TabScreen> {
  int activeScreenIndex = 0;
  void _selectPageindex(int index) {
    setState(() {
      activeScreenIndex = index;
    });
  }

  //void _showSnackBar(String message) {
  //  ScaffoldMessenger.of(context).clearSnackBars();
  //  ScaffoldMessenger.of(context).showSnackBar(
  //    SnackBar(
  //      content: Text(message),
  //    ),
  //  );
  //}

  //void addtofavorites(Meal currentmeal) {
  //  bool inFavorites = false;
  //  if (favoriteMeals.contains(currentmeal)) {
  //    inFavorites = true;
  //  }
  //  setState(() {
  //    if (inFavorites) {
  //      favoriteMeals.remove(currentmeal);
  //      _showSnackBar('Removed ${currentmeal.title} from Favorites!');
  //    } else {
  //      favoriteMeals.add(currentmeal);
  //      _showSnackBar('Added ${currentmeal.title} to Favorites!');
  //    }
  //  });
  //}

  void changeScreen(String screenname) async {
    Navigator.of(context).pop();
    if (screenname == 'Filters') {
      Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => const FiltersScreen(),
        ),
      );
      ref.watch(filterMealProvider);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget activeScreen = const Categories();
    var activePageTitle = 'Categories';
    if (activeScreenIndex == 1) {
      final favoriteMeals = ref.watch(favoriteMealsProvider);
      activeScreen = Meals(
        title: 'Favorites',
        meals: favoriteMeals,
      );
      activePageTitle = 'Favorites';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: SideDrawer(changescreen: changeScreen),
      body:
          activeScreen, // this is the active screen which is to be displayed , it changes dynamically ontap , whenever setstate is called.
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPageindex,
        currentIndex:
            activeScreenIndex, // it needs a function which takes an integer parameter as an input which would be the index of the current highlighted section in the bottom navigation bar.
        items: const [
          // takes a list of bottomnavigationbar items
          BottomNavigationBarItem(
            // this is a constructor item of the bottomnavigationbar widget
            icon: Icon(Icons
                .set_meal), // creates an icon for the bottomnavigationbar item
            label: 'Categories', // label for that section
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
