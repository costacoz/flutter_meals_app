import 'package:flutter/material.dart';
import '../screens/filters_screen.dart';

class MainDrawer extends StatelessWidget {
  Container buildHeading(BuildContext context) {
    return Container(
      height: 120,
      width: double.infinity,
      padding: EdgeInsets.all(20),
      alignment: Alignment.centerLeft,
      color: Theme.of(context).accentColor,
      child: Text(
        'Cooking Up!',
        style: TextStyle(
          fontWeight: FontWeight.w900,
          fontSize: 30,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  ListTile buildListTile(BuildContext ctx, IconData icon, String text, String routeName) {
    return ListTile(
      leading: Icon(icon, size: 26),
      title: Text(
        text,
        style: TextStyle(fontFamily: 'RobotoCondensed', fontSize: 24, fontWeight: FontWeight.bold),
      ),
      onTap: () => Navigator.of(ctx).pushReplacementNamed(routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          buildHeading(context),
          SizedBox(
            height: 20,
          ),
          buildListTile(context, Icons.restaurant, 'Meals', '/'),
          buildListTile(context, Icons.settings, 'Filters', FiltersScreen.routeName),
        ],
      ),
    );
  }
}
