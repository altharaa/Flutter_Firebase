import 'package:flutter/material.dart';
import 'package:flutter_firebase_crud/data/product_model.dart';
import 'package:flutter_firebase_crud/modules/add_product/add_product.dart';
import 'package:flutter_firebase_crud/modules/home_page/home_page_controller.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {

  final controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product"),
      ),
      body: StreamBuilder(
        stream: controller.streamProduct(),
        builder: (context, snapshot) {
          
          // LOADING
          if (snapshot.connectionState == ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );
          } 
          // NO PRODUCT
          else if (snapshot.data!.docs.isEmpty){
            return Center(
              child: Text("No Product"),
            );
          }
          // HAVE PRODUCT 
          else {
            List<ProductModel> listProduct = [];
            for (var elemen in snapshot.data!.docs) {
              listProduct.add(ProductModel.fromMap(elemen.data()));
              listProduct.sort((a, b) => a.name.compareTo(b.name));
            }
            return ListView.builder(
              itemCount: listProduct.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: ListTile(
                    title: Text(listProduct[index].name),
                    subtitle: Text(listProduct[index].category),
                    shape: Border(bottom: BorderSide(width: 1)),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(AddProduct());
          },
          child: Icon(Icons.add),
        )
    );
  }
}