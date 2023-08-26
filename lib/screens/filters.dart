import 'package:flutter/material.dart';
import 'package:meals_app/screens/tabs.dart';
import 'package:meals_app/providers/filters_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FiltersScreen extends ConsumerStatefulWidget {
  const FiltersScreen({super.key});
  @override
  ConsumerState<FiltersScreen> createState() {
    return _FilterScreenState();
  }
}

class _FilterScreenState extends ConsumerState<FiltersScreen> {
  var _glutenFreeFilterSet = false;
  var _lactoseFreeFilterSet = false;
  var _vegetarian = false;
  var _vegan = false;
  late Map<Filter, bool> filterParameters;

  @override
  void initState() {
    super.initState();
    filterParameters = ref.read(filterMealProvider);
    _glutenFreeFilterSet = filterParameters[Filter.glutenFree]!;
    _lactoseFreeFilterSet = filterParameters[Filter.lactoseFree]!;
    _vegetarian = filterParameters[Filter.vegetarian]!;
    _vegan = filterParameters[Filter.vegan]!;
  }

  void changeFromFiltersScreen(String screenswitch) {
    Navigator.of(context).pop();
    if (screenswitch == 'Meals') {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => const TabScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your filters'),
      ),
      //drawer: SideDrawer(changescreen: changeFromFiltersScreen),
      body: WillPopScope(
        onWillPop: () async {
          ref.read(filterMealProvider.notifier).changeFilters({
            Filter.glutenFree: _glutenFreeFilterSet,
            Filter.lactoseFree: _lactoseFreeFilterSet,
            Filter.vegetarian: _vegetarian,
            Filter.vegan: _vegan,
          });
          return true;
        },
        child: Column(
          children: [
            SwitchListTile(
              value: _glutenFreeFilterSet,
              onChanged: (isChecked) {
                setState(() {
                  _glutenFreeFilterSet = !_glutenFreeFilterSet;
                });
              },
              title: Text(
                'Gluten-free',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              subtitle: Text(
                'Only include gluten-free meals.',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
            ),
            SwitchListTile(
              value: _lactoseFreeFilterSet,
              onChanged: (isChecked) {
                setState(() {
                  _lactoseFreeFilterSet = !_lactoseFreeFilterSet;
                });
              },
              title: Text(
                'Lactose-free',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              subtitle: Text(
                'Only include lactose-free meals.',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
            ),
            SwitchListTile(
              value: _vegetarian,
              onChanged: (isChecked) {
                setState(() {
                  _vegetarian = !_vegetarian;
                });
              },
              title: Text(
                'Vegetarian',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              subtitle: Text(
                'Only include Vegetarian meals.',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
            ),
            SwitchListTile(
              value: _vegan,
              onChanged: (isChecked) {
                setState(() {
                  _vegan = !_vegan;
                });
              },
              title: Text(
                'Vegan',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              subtitle: Text(
                'Only include Vegan meals.',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
