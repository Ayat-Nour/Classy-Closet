import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/Models/OrderHistoryModel.dart';
import 'package:final_project/Models/WishListModel.dart';
import 'package:final_project/StateManagemnt/Profile/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit():super(ProfileInitState());

  List<WishListModel> wishItems=[];
  List<OrderHistoryModel> orders=[];

  Future<void> getWishList(String userID) async {
    emit(ProfileLoadingState());

      if( await FirebaseFirestore.instance.collection("WishList").doc(userID).snapshots().isEmpty){
        emit(ProfileSuccessState());
      }else{
        FirebaseFirestore.instance.collection("WishList").doc(userID).collection("WishItem").get().then((value){
          value.docs.forEach((element) {
            wishItems.add(WishListModel.fromJson(element.data() as Map<String, dynamic>));

          });
        }).then((value) {
          emit(ProfileSuccessState());
        }).catchError((onError){
          print(onError);
          emit(ProfileErrorState());
        });
      }


  }

  Future<void> getOrderHistory(String userID) async {
    emit(ProfileLoadingState());
   if(await FirebaseFirestore.instance.collection("OrderHistory").doc(userID).snapshots().isEmpty){
     emit(ProfileSuccessState());
   }else{
        FirebaseFirestore.instance.collection("OrderHistory").doc(userID).collection("Orders").orderBy("orderTime",descending: true).get().then((value){
          value.docs.forEach((element) {
            orders.add(OrderHistoryModel.fromJson(element.data() as Map<String, dynamic>));

          });
          emit(ProfileSuccessState());
        }).catchError((onError){
          print("Error on orders History : $onError");
          emit(ProfileErrorState());
        });
      }

  }

}