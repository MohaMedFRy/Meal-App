import 'package:flutter/material.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/screens/category_screen.dart';
import 'package:meal_app/screens/categroy_meal_screen.dart';
import 'package:meal_app/screens/favo_screen.dart';
import 'package:meal_app/weights/main_drawer.dart';

class TabScreen extends StatefulWidget {
  final List <Meal> favoriteMeal;
  TabScreen(this.favoriteMeal);
  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  List<Map<String, Object>> _pages ;

  int selectedIndex = 0;
  @override
  void initState() {
    _pages= [
      {
        'page': CategoryScreen(),
        'title': 'Category',
      },
      {
        'page': FavoritesScreen(widget.favoriteMeal),
        'title': 'Favorites',
      },
    ];
    super.initState();
  }
  void _sectectedPage(int value) {
    setState(() {
      selectedIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_pages[selectedIndex]['title']),centerTitle: true,),
      body: _pages[selectedIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _sectectedPage,
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor:Theme.of(context).accentColor,
        unselectedItemColor: Colors.white,
        currentIndex: selectedIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            title: Text("Category"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            title: Text("Favorites"),
          )
        ],
      ),
      drawer: MainDrawer(),
    );
  }
}
