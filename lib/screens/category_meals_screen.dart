import 'package:flutter/material.dart';
import 'package:meal_recipes_app/widgets/meal_item.dart';

import '../models/meal.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/category-meals';

  final List<Meal> availableMeals;

  CategoryMealsScreen(this.availableMeals);

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String categoryTitle = "Category";
  List<Meal> displayedMeals = [];
  bool _loadedInitData = false;

  @override
  void didChangeDependencies() {
    if (!_loadedInitData) {
      final routeArgs = ModalRoute.of(context)!.settings.arguments as Map<String, String>;
      final String categoryId = routeArgs['id'] as String;
      categoryTitle = routeArgs['title'] as String;
      displayedMeals = widget.availableMeals.where((meal) => meal.categories.contains(categoryId)).toList();
      _loadedInitData = true;
    }
    super.didChangeDependencies();
  }

  void _removeMeal(String mealIdtoRemove) {
    setState(() => displayedMeals.removeWhere((meal) => meal.id == mealIdtoRemove));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) => MealItem(
          displayedMeals[index],
          (mealIdtoRemove) => _removeMeal(mealIdtoRemove),
        ),
        itemCount: displayedMeals.length,
      ),
    );
  }
}
