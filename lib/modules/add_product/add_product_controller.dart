import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddProductController extends GetxController {

  Rx isloading = false.obs;
  TextEditingController? cNameProduct;
  TextEditingController? cCategoryProduct;
  @override
  void onInit() {
    super.onInit();
    cNameProduct = new TextEditingController();
    cCategoryProduct = new TextEditingController();
  }

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<Map<String, dynamic>> addProduct(Map<String,dynamic>data) async {
    try {
      var hasil = await firestore
      .collection("products")
      .add(data);
      await firestore.collection("products").doc(hasil.id).update({
        "Id": hasil.id,
      });
      return {
        "error": false,
        "message": "Berhasil menambah product.",
      };
    } catch (e) {
      print(e);
      return {
        "error": true,
        "message": "Tidak dapat menambah product.",
      };
    }
  }
}