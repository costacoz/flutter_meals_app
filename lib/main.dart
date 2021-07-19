import 'package:flutter/material.dart';
import 'package:meal_recipes_app/dummy_data.dart';

import 'models/meal.dart';
import 'screens/filters_screen.dart';
import 'screens/tabs_screen.dart';
import 'screens/categories_screen.dart';
import 'screens/category_meals_screen.dart';
import 'screens/meal_details_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'vegetarian': false,
    'vegan': false,
    'lactose': false,
  };

  late List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  void _toggleFavorite(String mealId) {
    final int existingIndex = _favoriteMeals.indexWhere((Meal meal) => meal.id == mealId);
    if (existingIndex > -1) {
        setState(() {
          _favoriteMeals.removeAt(existingIndex);
        });
    } else {
      setState(() {
        _favoriteMeals.add(DUMMY_MEALS.firstWhere((Meal meal) => meal.id == mealId));
      });
    }
  }

  bool _isMealFavorited(String mealId) {
    return _favoriteMeals.any((Meal meal) => meal.id == mealId);
  }

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
      _availableMeals = DUMMY_MEALS.where((Meal meal) {
        if ((_filters['gluten'] as bool && !meal.isGlutenFree) ||
            (_filters['lactose'] as bool && !meal.isLactoseFree) ||
            (_filters['vegan'] as bool && !meal.isVegan) ||
            (_filters['vegetarian'] as bool && !meal.isVegetarian)) {
          return false;
        } else {
          return true;
        }
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MealRecipes',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              bodyText2: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              headline6: TextStyle(fontSize: 20, fontFamily: 'RobotoCondensed', fontWeight: FontWeight.bold),
            ),
      ),
      initialRoute: '/',
      // default is '/'
      routes: {
        '/': (ctx) => TabsScreen(_favoriteMeals),
        CategoriesScreen.routeName: (ctx) => CategoriesScreen(),
        CategoryMealsScreen.routeName: (ctx) => CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(_toggleFavorite, _isMealFavorited),
        FiltersScreen.routeName: (ctx) => FiltersScreen(_filters, _setFilters),
      },
      /**
       *  onGenerateRoute is used for dynamic routes.
       *
          onGenerateRoute: (settings) {
          print('what is here? $settings');
          return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
          }; */

      /**
       * onUnknownRoute is error fallback route mechanism to show at least some page if other routes failed.
       * It's like a web's 404 page.
       */
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
    );
  }
}
