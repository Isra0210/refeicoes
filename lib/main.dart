import 'package:flutter/material.dart';
import 'package:refeicoes/models/settings.dart';
import 'package:refeicoes/screens/meal_detail_screen.dart';
import 'package:refeicoes/screens/settings_screen.dart';
import 'screens/category_screen.dart';
import 'screens/categories_meals_screens.dart';
import './screens/settings_screen.dart';
import './utils/app_routes.dart';
import 'screens/tabs_screen.dart';
import 'models/meal.dart';
import 'data/dummy_data.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Settings settings = Settings();

  List<Meal> _avaliableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeal = [];

  void _filterMeals(Settings settings) {
    setState(() {
      this.settings = settings;

      _avaliableMeals = DUMMY_MEALS.where((meal) {
        final filterGluten = settings.isGlutenFree && !meal.isGlutenFree;
        final filterLactose = settings.isLactoseFree && !meal.isLactoseFree;
        final filterVegan = settings.isVegan && !meal.isVegan;
        final filterVegetarian = settings.isVegeratian && !meal.isVegetarian;

        return !filterGluten &&
            !filterLactose &&
            !filterVegan &&
            !filterVegetarian;
      }).toList();
    });
  }

  void _toggleFavorite(Meal meal) {
    setState(() {
      _favoriteMeal.contains(meal)
          ? _favoriteMeal.remove(meal)
          : _favoriteMeal.add(meal);
    });
  }

  bool _isFavorite(Meal meal) {
    return  _favoriteMeal.contains(meal);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vamos Cozinhar?',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        fontFamily: 'Releway',
        canvasColor: Colors.grey[200],
        textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
                color: Colors.white,
              ),
            ),
      ),
      routes: { 
        //Rotas nomeadas
        AppRoutes.HOME: (ctx) => TabsScreen(_favoriteMeal), //Rota inicial
        AppRoutes.CATEGORIES_MEALS: (ctx) =>
            CategoriesMealsScreen(_avaliableMeals),
        AppRoutes.MEALS_DETAIL: (ctx) => MealDetailScreen(_toggleFavorite, _isFavorite),
        AppRoutes.SETTINGS: (ctx) => SettingsScreen(settings, _filterMeals),
      },
      onGenerateRoute: (settings) {
        if (settings.name == 'uma-coisa') {
          return null;
        } else if (settings.name == 'outra-coisa') {
          return null;
        } else {
          return MaterialPageRoute(builder: (_) {
            return CategoryScreen();
          });
        }
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (_) {
            return CategoryScreen();
          },
        );
      },
    );
  }
}
