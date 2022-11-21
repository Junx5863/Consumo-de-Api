import 'package:api_tutorial/models/product.dart';
import 'package:api_tutorial/services/apiService.dart';
import 'package:flutter/material.dart';



class ProductDetail extends StatelessWidget {
   final int id; 
   ProductDetail(this.id);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
      ),
      body: FutureBuilder(
        future: ApiService().getSingleProduct(id),
        builder:(context,AsyncSnapshot snapshot){
          if(snapshot.hasData){
            Product product = snapshot.data;
            return Container(
              margin: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30,),
                  Image.network(product.image,height: 200,width: double.infinity,),
                   SizedBox(height: 10,),
                  Center(
                    child: Text("\$"+product.price.toString(),style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    
                    ),),
                  ),
                  SizedBox(height: 10,),
        
                  Text(product.title,style: TextStyle(
                    fontSize: 25,
                  ),),
                   Chip(label: Text(product.category.toString(),style: TextStyle(
                    fontSize: 15,
                    color: Colors.white
                  ),),backgroundColor: Colors.blueGrey,),
                  
                     SizedBox(height: 30,),
                   Text(product.description),
                  
                ],
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        } ),
        floatingActionButton: FloatingActionButton(
          child:  Icon(Icons.add_shopping_cart_outlined),
          onPressed: ()async{
            await ApiService().updateCart(1, id);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Product added to Cart"),backgroundColor: Colors.green,));
          },
          backgroundColor: Colors.green,

        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      
    );
  }
}