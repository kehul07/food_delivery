import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  Future addUser(Map<String, dynamic> map, String id) async {
    await FirebaseFirestore.instance.collection("users").doc(id).set(map);
  }

  UpdateUserWallet(String id, String amount) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .update({"Wallet": amount});
  }

  Future addFoodItem(Map<String, dynamic> map, String name) async {
    await FirebaseFirestore.instance.collection(name).add(map);
  }

  Future<Stream<QuerySnapshot>> getItem(String name) async {
    return FirebaseFirestore.instance.collection(name).snapshots();
  }

  Future addFoodToCart(Map<String, dynamic> map, String id) async {
    await FirebaseFirestore.instance.collection("users").doc(id).collection("Cart").add(map);
  }
  Future addOrderInfo(Map<String, dynamic> map, String id) async {
    await FirebaseFirestore.instance.collection("users").doc(id).collection("Orders").add(map);
  }

  Future<Stream<QuerySnapshot>> getFoodCart(String id) async {
    return FirebaseFirestore.instance.collection("users").doc(id).collection("Cart").snapshots();
  }
  Future<void> deleteFoodFromCart(String userId, DocumentReference foodRef) async {
    await foodRef.delete();
  }

  Future<Stream<QuerySnapshot>> getOrderIfo(String id) async {
    return FirebaseFirestore.instance.collection("users").doc(id).collection("Orders").snapshots();
  }

  Future<void> deleteFoodFromAdmin(DocumentReference foodRef) async {
    await foodRef.delete();
  }

}
