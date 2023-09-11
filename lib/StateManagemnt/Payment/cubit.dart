import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/Models/OrderHistoryModel.dart';
import 'package:final_project/StateManagemnt/Payment/states.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../Models/UserModel.dart';

class PaymentCubit extends Cubit<PaymentStates>
{
  PaymentCubit():super(PaymentInitState());
 UserModel ? user;
 OrderHistoryModel ? order;


  void getOrder(String userID,String OrderID){
    emit(PaymentLoadingState());
    FirebaseFirestore.instance.collection("OrderHistory").doc(userID).collection("Orders").doc(OrderID).get().then((value){
      order = OrderHistoryModel.fromJson(value.data() as Map<String, dynamic>);
    }).then((value) {
      FirebaseFirestore.instance.collection("Users").doc(userID).get().then((value){
        user = UserModel.fromJson(value.data() as Map<String, dynamic>);
        emit(PaymentSuccessState(false));
    }).catchError((onError){
      print("Error in get order $onError");
      emit(PaymentErrorState());
    });
  });}
  
  void emptyBag(String userID,String OrderID){
    emit(PaymentLoadingState());
    FirebaseFirestore.instance.collection("OrderHistory").doc(userID).collection("Orders").doc(OrderID).update({"orderStatus":2}).then((value) {
      FirebaseFirestore.instance.collection("Cart").doc(userID).collection("Item").get().then((value) {
        value.docs.forEach((element) {element.reference.delete();});
        Fluttertoast.showToast(
            msg: "order placed successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            fontSize: 16.0
        ).then((value) =>  emit(PaymentSuccessState(true)));

      }).catchError((onError){
        emit(PaymentErrorState());
      });

    }).catchError((onError){
      emit(PaymentErrorState());
    });

  }

  /*void DeleteBag(String userID,String OrderID){
    emit(PaymentLoadingState());
    print(userID);
    FirebaseFirestore.instance.collection("Cart").doc(userID).collection("Item").get().then((value) {
      value.docs.forEach((element) {element.reference.delete();});
      emit(PaymentSuccessState());
    }).catchError((onError){
      emit(PaymentErrorState());
    });



  }*/


}