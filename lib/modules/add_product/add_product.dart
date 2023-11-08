import 'package:flutter/material.dart';
import 'package:flutter_firebase_crud/modules/add_product/add_product_controller.dart';
import 'package:get/get.dart';

class AddProduct extends StatelessWidget {
  final controller = Get.put(AddProductController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            TextFormField(
              controller: controller.cNameProduct,
              decoration: InputDecoration(
                labelText: "Name Product",
              ),
            ),
            TextFormField(
              controller: controller.cCategoryProduct,
              decoration: InputDecoration(
                labelText: "Category Product",
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async{
              if (controller.cNameProduct!.text.isNotEmpty &&
                  controller.cCategoryProduct!.text.isNotEmpty) {
                Map<String, dynamic>
                hasil = await controller.addProduct({
                  "name": controller.cNameProduct!.text,
                  "category": controller.cCategoryProduct!.text,
                });
                Get.back();
                Get.snackbar(
                  hasil["error"] == true ? "Error" : "Success", 
                  hasil["message"]);
                controller.cCategoryProduct!.clear();
                controller.cNameProduct!.clear();
              } else {
                  Get.snackbar("Error", "Semua data wajib diisi.");
              }
            }, 
            child:
            Obx(() =>
              controller.isloading.value == true
              ? CircularProgressIndicator()
              : Text("Add Product")
            )
            )
          ]),
      ),
    );
  }
}