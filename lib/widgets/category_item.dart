import 'package:flutter/material.dart';
import '../screens/category_meals_screen.dart';

class CategoryItem extends StatelessWidget {
  final String id;
  final String title;
  final Color color;

  CategoryItem({required this.id, required this.title, required this.color});

  void selectCategory(BuildContext ctx, String categoryTitle) {
    Navigator.of(ctx).pushNamed(
      CategoryMealsScreen.routeName,
      arguments: {'id': id, 'title': title},
    );
  }

  @override
  Widget build(BuildContext context) {
    final BorderRadius itemRadius = BorderRadius.circular(15);

    return InkWell(
      onTap: () => selectCategory(context, title),
      borderRadius: itemRadius,
      splashColor: Theme.of(context).primaryColor,
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Text(
          title,
          style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.white),
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color.withOpacity(0.6), color],
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
          ),
          borderRadius: itemRadius,
        ),
      ),
    );
  }
}
