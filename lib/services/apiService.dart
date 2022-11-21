import 'dart:convert';

import 'package:api_tutorial/models/fruit.dart';
import 'package:api_tutorial/models/product.dart';
import 'package:http/http.dart' as http;


class ApiService{


 
    Future<List<Product>> getAllProducts()async{
    final allProductUrl = Uri.parse('https://fakestoreapi.com/products');
    final response = await http.get(allProductUrl);
    List<Product> allProducts = [];
    List body =  json.decode(response.body);
    body.forEach((product){
      allProducts.add(Product.fromJson(product));
    });
    return allProducts;
  }

   Future<Product> getSingleProduct(int id)async{
    final singleProductUrl = Uri.parse('https://fakestoreapi.com/products/$id');
    final response = await http.get(singleProductUrl);
    print(response.statusCode);
    print(response.body);
    var body =  json.decode(response.body);
    return Product.fromJson(body);
  }

   Future getAllCategory()async{
  
       final allCategoryUrl = Uri.parse('https://fakestoreapi.com/products/categories');
    final response = await http.get(allCategoryUrl);
    print(response.statusCode);
    print(response.body);
    return json.decode(response.body);
 
    
  }

  Future getProductByCategory(String catName)async{
    
    final fetchProductCategoryUrl = Uri.parse('https://fakestoreapi.com/products/category/$catName');
    final response = await http.get(fetchProductCategoryUrl);
    print(response.statusCode);
    print(response.body);
    return json.decode(response.body);
  }

    Future getCart(String userId)async{
    final fetchCartProducts = Uri.parse('https://fakestoreapi.com/carts/$userId');
    final response = await http.get(fetchCartProducts);
    print(response.statusCode);
    print(response.body);
    return json.decode(response.body);
  }


  // POST REQUEST
   Future userLogin(String username,String password)async{
    
     final loginUrl = Uri.parse("https://fakestoreapi.com/auth/login");
     final response = await http.post(loginUrl,body: {
         'username':username,
         'password':password,
     });
     print(response.statusCode);
     print(response.body);
     return json.decode(response.body);
   }

   // PUT REQUEST
   Future updateCart(int userId,int productId)async{
     final updateCartUrl = Uri.parse("https://fakestoreapi.com/carts/$userId");
     final response = await http.put(updateCartUrl,body: {
         "userId":"$userId",
         "date": DateTime.now().toString(),
         "products":[
           {
             "productId":"$productId",
             "quantity":"1"
           }
         ].toString(),

     });
      print(response.statusCode);
     print(response.body);
     return json.decode(response.body);
   }
    
    // DELETE REQUEST
    Future deleteCart(String userId)async{
    final deleteCartUrl = Uri.parse('https://fakestoreapi.com/carts/$userId');
    final response = await http.delete(deleteCartUrl);
    print(response.statusCode);
    print(response.body);
    return json.decode(response.body);
  }


  // Get ALL Fruits
  Future<List<Fruit>> getAllFruits()async{
    final allFruitUrl = Uri.parse('https://www.fruityvice.com/api/fruit/all');
    var response = await http.get(allFruitUrl);
    List body =  json.decode(response.body);
    List<Fruit> allFruits = body.map((fruit)=>Fruit.fromJson(fruit)).toList();
    return allFruits;
  }



}