import 'package:flutter/material.dart';
import 'package:refeicoes/components/meal_item.dart';
import '../models/category.dart';
import '../models/meal.dart';

class CategoriesMealsScreen extends StatelessWidget {

  final List<Meal> meals;

  const CategoriesMealsScreen(this.meals);

  @override
  Widget build(BuildContext context) {
    //ao invés de pegar categoria via construtor, pegamos via rota transformando em categoria
    final category = ModalRoute.of(context).settings.arguments as Category;

    final categoryMeals = meals.where((meal) {
      return meal.categories.contains(category.id);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            category.title,
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: Container(
        color: Colors.grey[200],
        child: ListView.builder(
          itemCount: categoryMeals.length,
          itemBuilder: (ctx, index) {
          return MealItem(categoryMeals[index]);
        }),
      ),
    );
  }
}
