import 'package:flutter/material.dart';
import 'package:meals_app/widgets/listTile.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({super.key});
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 8.0,
      child: Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 30, 10, 2),
        ),
        child: Column(
          children: [
            DrawerHeader(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 54, 16, 2),
                    Color.fromARGB(255, 105, 29, 1),
                  ],
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.fastfood,
                    size: 48,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                  const SizedBox(
                    width: 18,
                  ),
                  Text(
                    'Cooking up!',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                  )
                ],
              ),
            ),
            const Listtile(
              tileTitle: 'Meals',
              tileIcon: Icons.fastfood,
            ),
            const Listtile(
              tileTitle: 'Filter',
              tileIcon: Icons.filter_list_alt,
            ),
          ],
        ),
      ),
    );
  }
}
