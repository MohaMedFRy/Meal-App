import 'package:flutter/material.dart';
import 'package:meal_app/dummy_data.dart';
//import 'package:flutter_icons/flutter_icons.dart';
//import './screens/category_screen.dart';flu
import './screens/categroy_meal_screen.dart';
import './screens/filter_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/tabs_screen.dart';
import 'models/meal.dart';

main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };
  List <Meal> _availableMeals = DUMMY_MEALS;
  List <Meal> _favoriteMeal =[];

  void _setFilters( Map<String, bool> _filterData ){
    setState(() {
      _filters=_filterData;
      _availableMeals =DUMMY_MEALS.where((meal){
        if(_filters['gluten'] && !meal.isGlutenFree)  return false;
        if(_filters['lactose'] && !meal.isLactoseFree)  return false;
        if(_filters['vegan'] && !meal.isVegan)  return false;
        if(_filters['vegetarian'] && !meal.isVegetarian)  return false;
        return true;
      }).toList();
    });
  }
  void _toggleFavorite(String mealId){
    final existingIndex = _favoriteMeal.indexWhere((meal) => meal.id == mealId );
    if(existingIndex >= 0){
      setState(() {
        _favoriteMeal.removeAt(existingIndex);
      });
    }else{
      setState(() {
        _favoriteMeal.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }
  bool _isFavorite(String id){
    return _favoriteMeal.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Colors.redAccent,
          accentColor: Colors.amberAccent,
          canvasColor: Color.fromRGBO(255, 254, 230, 1),
          textTheme: ThemeData.light().textTheme.copyWith(
                body1: TextStyle(
                  color: Color.fromRGBO(20, 50, 50, 0.8),
                ),
                body2: TextStyle(
                  color: Color.fromRGBO(20, 50, 50, 0.8),
                ),
                title: TextStyle(
                    fontSize: 20,
                    fontFamily: 'RobotoCondensed',
                    fontWeight: FontWeight.bold),
              )),
      // home: Scaffold(
      //   appBar: AppBar(
      //     title: Text("Meal App"),
      //     centerTitle: true,
      //   ),
      //   body: CategoryScreen(),
      // ),
      routes: {
        '/': (context) => TabScreen(_favoriteMeal),
        CategoryMealScreen.routeName: (context) => CategoryMealScreen(_availableMeals),
        MealDetailScreen.routeName: (context) => MealDetailScreen(_toggleFavorite, _isFavorite),
        FilterScreen.routeName: (context) => FilterScreen(_filters,_setFilters),
      },
    );
  }
}
