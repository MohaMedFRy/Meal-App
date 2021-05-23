import 'package:flutter/material.dart';
import 'package:meal_app/weights/category_items.dart';
import 'package:meal_app/dummy_data.dart';
 
class CategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // appBar: AppBar(title: Text("Meal App",),centerTitle: true,),
      body: GridView(
        children: DUMMY_CATEGORIES.map((catData)=>
            CategoryItems(catData.id,catData.title,catData.color),
        ).toList(),
        
        padding: EdgeInsets.all(15),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          crossAxisSpacing: 20,
          mainAxisSpacing: 30,
          childAspectRatio: 3/2,
        ),
      ),
    );
  }
}
