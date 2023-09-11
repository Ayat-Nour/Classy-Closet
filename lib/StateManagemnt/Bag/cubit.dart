
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/Models/ItemModel.dart';
import 'package:final_project/Models/WishListModel.dart';
import 'package:final_project/StateManagemnt/Bag/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Models/CartModel.dart';
import '../../Models/OrderHistoryModel.dart';

class BagCubit extends Cubit<BagStates>{
  BagCubit():super(BagInitState());
  List<CartModel> cartItems=[];
  double totalPrice=0.0;
  int totalQuantity=0;
  List<WishListModel> wishItems=[];
  List<dynamic> itemsImages=[];
  OrderHistoryModel ? order;
  String ? orderID;

  final _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  final Random _rnd = Random();
  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  void getRandomOrderID(){
    orderID=getRandomString(15);
  }


  Future<void> getBag(String userID) async {
    print(userID);
    emit(BagLoadingState());

    if(await FirebaseFirestore.instance.collection("Cart").doc(userID).snapshots().isEmpty){emit(BagSuccessState());}else{
      FirebaseFirestore.instance.collection("Cart").doc(userID).collection(
          "Item").get().then((value) {
        value.docs.forEach((element) {
          cartItems.add(
              CartModel.fromJson(element.data() as Map<String, dynamic>));
          totalPrice += (CartModel
              .fromJson(element.data())
              .itemPrice! * CartModel
              .fromJson(element.data())
              .itemQuantity!);
          totalQuantity += CartModel
              .fromJson(element.data())
              .itemQuantity!;
          itemsImages.add(CartModel
              .fromJson(element.data())
              .itemImage!);
        });

        print("Hellor");
      }).then((value) {
        print("Succes 1");
        emit(BagSuccessState());
      }).catchError((onError) {
        print("Bag Error state is : $onError");
        emit(BagErrorState());
      });
    }


  }
  Future<void> getWishList(String userID) async {
    emit(BagLoadingState());

      if(await FirebaseFirestore.instance.collection("WishList").doc(userID).snapshots().isEmpty){emit(BagSuccessState());}else{
        FirebaseFirestore.instance.collection("WishList").doc(userID).collection("WishItem").get().then((value){
          value.docs.forEach((element) {
            wishItems.add(WishListModel.fromJson(element.data() as Map<String, dynamic>));

          });
        }).then((value) {
          emit(BagSuccessState());
        }).catchError((onError){
          print(onError);
          emit(BagErrorState());
        });
      }


  }
  void placeOrder(String userID , String orderID , String orderTime,double orderTotalPrice, int orderStatus, List<dynamic> orderImages ,int orderTotalQuantity){
    emit(BagLoadingState());
      FirebaseFirestore.instance.collection("OrderHistory").doc(userID).collection("Orders").doc(orderID).set({
      "userID":userID,
      "orderID":orderID,
      "orderTime":orderTime,
      "orderTotalPrice":orderTotalPrice,
      "orderStatus":orderStatus,
      "orderImages":orderImages, "orderTotalQuantity":orderTotalQuantity,
      }).then((value) {
        emit(BagSuccessState());
        print("Place order successful");
      }).catchError((onError){
        emit(BagErrorState());
      });

  }


}