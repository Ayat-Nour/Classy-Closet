import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/Models/ItemModel.dart';
import 'package:final_project/StateManagemnt/Search/states.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SearchCubit extends Cubit<SearchStates>{
  SearchCubit():super(SearchInitState());
  List<ItemModel> searchResult =[];
  String ? imageName;
  String ? colorName;
  String ? size;
  String ? imageNameWish;
  String ? colorNameWish;
  String ? sizeWish;
  void getSearchResult(String search){
    emit(SearchLoadingState());
    FirebaseFirestore.instance.collection("Items").where("itemName",arrayContains: "Belted wide leg formal pants").get().then((value){
      for(var element in value.docs){
        searchResult.add(ItemModel.fromJson(element.data()));
      }
    }).then((value) {
      print(searchResult.length);
      emit(SearchSuccessState());
    }).catchError((onError){
      emit(SearchErrorState());
    });
  }

  void addToBag(String userID , String itemID , String itemName,String itemNameAR , int itemQuantity, int itemSizeIndex, int itemColorImageIndex , double itemPrice){
    emit(SearchLoadingState());
    FirebaseFirestore.instance.collection("Items").where("itemID",isEqualTo: itemID).get().then((value) {
      value.docs.forEach((element) {
        imageName=ItemModel.fromJson(element.data() as Map<String, dynamic>).itemImage![itemColorImageIndex];
        colorName=ItemModel.fromJson(element.data() as Map<String, dynamic>).itemColor![itemColorImageIndex];
        size=ItemModel.fromJson(element.data() as Map<String, dynamic>).itemSize![itemSizeIndex];
      });
    }).then((value){
      FirebaseFirestore.instance.collection("Cart").doc(userID).collection("Item").doc(itemID).set({
        "itemID":itemID,
        "itemName":itemName,
        "itemNameAR":itemNameAR,
        "itemQuantity":itemQuantity,
        "itemSize":size,
        "itemColor":colorName,
        "itemImage":imageName,
        "itemPrice":itemPrice,

      }).then((value) => {
        Fluttertoast.showToast(
            msg: "Added successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            fontSize: 16.0
        ),
        emit(SearchSuccessState()),
      }).catchError((onError){
        emit(SearchErrorState());
      });
    });


  }

  void addToWishList(String userID ,String itemCategory, String itemID , String itemName,String itemNameAR, int itemSizeIndex, int itemColorImageIndex , double itemPrice){
    emit(SearchLoadingState());
    FirebaseFirestore.instance.collection("Items").where("itemID",isEqualTo: itemID).get().then((value) {
      value.docs.forEach((element) {
        imageNameWish=ItemModel.fromJson(element.data() as Map<String, dynamic>).itemImage![itemColorImageIndex];
        colorNameWish=ItemModel.fromJson(element.data() as Map<String, dynamic>).itemColor![itemColorImageIndex];
        sizeWish=ItemModel.fromJson(element.data() as Map<String, dynamic>).itemSize![itemSizeIndex];
      });
    }).then((value){
      FirebaseFirestore.instance.collection("WishList").doc(userID).collection("WishItem").doc(itemID).set({
        "itemCategory":itemCategory,
        "itemColor":colorNameWish,
        "itemID":itemID,
        "itemImage":imageNameWish,
        "itemName":itemName,
        "itemNameAR":itemNameAR,
        "itemPrice":itemPrice,
        "itemSize":sizeWish
      }).then((value) => {
        emit(SearchSuccessState()),
      }).catchError((onError){
        emit(SearchErrorState());
      });
    });


  }
  void removeFromWishList(String userID, String itemID){
    emit(SearchLoadingState());
    FirebaseFirestore.instance.collection("WishList").doc(userID).collection("WishItem").doc(itemID).delete().then((value){
      emit(SearchSuccessState());
    }).catchError((onError){
      emit(SearchErrorState());
    });
  }
}