import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meal_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';

class MealsDataItem extends StatelessWidget {
  const MealsDataItem({super.key, required this.currentmeal});

  String get complexityText {
    return currentmeal.complexity.name[0].toUpperCase() +
        currentmeal.complexity.name.substring(1);
  }

  String get affordabilityText {
    return currentmeal.affordability.name[0].toUpperCase() +
        currentmeal.affordability.name.substring(1);
  }

  final Meal currentmeal;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      child: InkWell(
        onTap: () {},
        child: Stack(
          children: [
            FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(currentmeal.imageUrl),
              fit: BoxFit.cover,
              height: 180,
              width: double.infinity,
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: 60,
                color: Colors.black54,
                child: Column(
                  children: [
                    Text(
                      currentmeal.title,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MealItemTrait(
                            icon: Icons.schedule,
                            label: '${currentmeal.duration} min'),
                        MealItemTrait(
                          icon: Icons.work,
                          label: complexityText,
                        ),
                        MealItemTrait(
                          icon: Icons.attach_money,
                          label: affordabilityText,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
