import 'package:api_tutorial/models/fruit.dart';
import 'package:api_tutorial/services/apiService.dart';
import 'package:flutter/material.dart';

class FruitScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.orangeAccent,
        title: Text("All Fruits"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: ApiService().getAllFruits(),
        builder: (context,AsyncSnapshot snapshot){
          if(snapshot.hasData){
             return ListView.builder(
               itemCount: snapshot.data!.length,
               itemBuilder: (context,index){
                 Fruit fruit = snapshot.data![index];
                 return Card(
                   child: ListTile(
                     title: Center(child: Text(fruit.name)),
                     subtitle: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                       children: [
                         Text("Carbohydrates : ${fruit.nutritions.carbohydrates}"),
                          Text("Protein : ${fruit.nutritions.protein}"),
                           Text("Fats : ${fruit.nutritions.fat}"),
                       ],
                     )
                   ),
                 );
               });
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      
    );
  }
}