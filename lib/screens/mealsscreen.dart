import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:transparent_image/transparent_image.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({super.key , required this.meal});

  final Meal meal;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meals Screen'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(children: [
        FadeInImage(placeholder: MemoryImage(kTransparentImage), image: NetworkImage(meal.imageUrl),),
        const Text('Ingredients' , style: TextStyle(color: Color.fromARGB(255, 194, 118, 113),),),
        Column(
          children: [
            ...meal.ingredients.map((ingredient) => Text(ingredient , textAlign: TextAlign.center,),).toList(),
          ],
        ),
        const Text('Steps' , style: TextStyle(color: Color.fromARGB(255, 186, 106, 100),fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
        Column(
          children: [
            ...meal.steps.map((steps) => Text(steps , textAlign: TextAlign.center,),).toList(),
          ],
        ),
      ],),
    );
  }
}
