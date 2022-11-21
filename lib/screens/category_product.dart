import 'package:api_tutorial/services/apiService.dart';
import 'package:flutter/material.dart';

import 'product_detail.dart';


class CategoryProductScreen extends StatelessWidget {
  final String categoryName;
  CategoryProductScreen(this.categoryName);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName.toUpperCase()),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
       body: FutureBuilder(
        future: ApiService().getProductByCategory(categoryName),
        builder: (context,AsyncSnapshot snapsnot){
          if(snapsnot.hasData){
             return ListView.builder(
               itemCount: snapsnot.data.length,
               itemBuilder: (context,index){
                 return ListTile(
                   leading: Image.network(snapsnot.data[index]['image'],height: 50,width: 30,),
                   title: Text(snapsnot.data[index]['title']),
                   subtitle: Text("Price - \$"+snapsnot.data[index]['price'].toString()),
                   onTap: (){
                     Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetail(snapsnot.data[index]['id'])));
                   },
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