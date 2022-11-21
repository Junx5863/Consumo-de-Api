import 'package:api_tutorial/models/product.dart';
import 'package:api_tutorial/screens/all_category.dart';
import 'package:api_tutorial/screens/cart_screen.dart';
import 'package:api_tutorial/screens/product_detail.dart';
import 'package:api_tutorial/services/apiService.dart';
import 'package:flutter/material.dart';


class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.redAccent,
        title: Text("Home"),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>AllCategory()));
          }, icon: Icon(Icons.view_list)),
            IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>CartScreen()));
          }, icon: Icon(Icons.shopping_cart)),
        ],
      ),
      body: FutureBuilder(
        future: ApiService().getAllProducts(),
        builder: (context,AsyncSnapshot snapshot){
          if(snapshot.hasData){
             return ListView.builder(
               itemCount: snapshot.data!.length,
               itemBuilder: (context,index){
                 Product product = snapshot.data![index];
                 return ListTile(
                   leading: Image.network(product.image,height: 50,width: 30,),
                   title: Text(product.title),
                   subtitle: Text("Price - \$"+product.price.toString()),
                   onTap: (){
                     Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetail(product.id)));
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