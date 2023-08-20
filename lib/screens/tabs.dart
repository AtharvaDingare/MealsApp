import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/SideDrawer.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});
  @override
  State<StatefulWidget> createState() {
    return _TabScreenState();
  }
}

class _TabScreenState extends State<TabScreen> {
  Map<Filter, bool> filterParameters = {
    Filter.glutenFree: false,
    Filter.lactoseFree: false,
    Filter.vegetarian: false,
    Filter.vegan: false
  };
  int activeScreenIndex = 0;
  void _selectPageindex(int index) {
    setState(() {
      activeScreenIndex = index;
    });
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  List<Meal> favoriteMeals = [];

  void addtofavorites(Meal currentmeal) {
    bool inFavorites = false;
    if (favoriteMeals.contains(currentmeal)) {
      inFavorites = true;
    }
    setState(() {
      if (inFavorites) {
        favoriteMeals.remove(currentmeal);
        _showSnackBar('Removed ${currentmeal.title} from Favorites!');
      } else {
        favoriteMeals.add(currentmeal);
        _showSnackBar('Added ${currentmeal.title} to Favorites!');
      }
    });
  }

  void changeScreen(String screenname) async {
    Navigator.of(context).pop();
    if (screenname == 'Filters') {
      final Map<Filter, bool>? result =
          await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => FiltersScreen(filterParameters: filterParameters),
        ),
      );
      setState(() {
        filterParameters = result!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget activeScreen = Categories(
      addtoFavorites: addtofavorites,
      filterParameters: filterParameters,
    );
    var activePageTitle = 'Categories';
    if (activeScreenIndex == 1) {
      activeScreen = Meals(
        title: 'Favorites',
        meals: favoriteMeals,
        addtoFavorites: addtofavorites,
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
