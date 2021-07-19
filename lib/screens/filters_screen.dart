import 'package:flutter/material.dart';
import 'package:meal_recipes_app/widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';

  final void Function(Map<String, bool>) saveFilters;
  final Map<String, bool> currentFilters;

  FiltersScreen(this.currentFilters, this.saveFilters);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactoseFree = false;

  @override
  void initState() {
    _glutenFree = widget.currentFilters['gluten'] as bool;
    _vegetarian = widget.currentFilters['vegetarian'] as bool;
    _vegan = widget.currentFilters['vegan'] as bool;
    _lactoseFree = widget.currentFilters['lactose'] as bool;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your filters'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () => widget.saveFilters({
              'gluten': _glutenFree,
              'vegetarian': _vegetarian,
              'vegan': _vegan,
              'lactose': _lactoseFree,
            }),
          )
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                buildSwitchListTile(
                  'Gluten-free',
                  _glutenFree,
                  'Only include gluten-free meals.',
                  (newValue) => setState(() => _glutenFree = newValue),
                ),
                buildSwitchListTile(
                  'Vegetarian',
                  _vegetarian,
                  'Only include vegetarian meals.',
                  (newValue) => setState(() => _vegetarian = newValue),
                ),
                buildSwitchListTile(
                  'Vegan',
                  _vegan,
                  'Only include vegan meals.',
                  (newValue) => setState(() => _vegan = newValue),
                ),
                buildSwitchListTile(
                  'Lactose-free',
                  _lactoseFree,
                  'Only include lactose-free meals.',
                  (newValue) => setState(() => _lactoseFree = newValue),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  SwitchListTile buildSwitchListTile(String text, bool value, String subtitle, void Function(bool) function) {
    return SwitchListTile(
      title: Text(text),
      value: value,
      subtitle: Text(subtitle),
      onChanged: (newValue) => function(newValue),
    );
  }
}
