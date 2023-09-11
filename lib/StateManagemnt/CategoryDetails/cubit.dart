import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/Models/ItemModel.dart';
import 'package:final_project/StateManagemnt/CategoryDetails/states.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CategoryDetailsCubit extends Cubit<CategoryDetailsStates>{
  CategoryDetailsCubit():super(CategoryDetailsInitState());
  List<ItemModel> items=[];
  String ? imageName;
  String ? colorName;
  String ? size;
  String ? imageNameWish;
  String ? colorNameWish;
  String ? sizeWish;
  void getItems(String categoryID){
    emit(CategoryDetailsLoadingState());
    FirebaseFirestore.instance.collection("Items").where("itemCategory",isEqualTo: categoryID).get().then((value){
      value.docs.forEach((element) {
        print(element.data());
       items.add(ItemModel.fromJson(element.data() as Map<String, dynamic>));

        emit(CategoryDetailsSuccessState());
      });
    }).catchError((onError){
      print(onError);
      emit(CategoryDetailsErrorState());
    });
  }

  void addToBag(String userID , String itemID , String itemName,String itemNameAR , int itemQuantity, int itemSizeIndex, int itemColorImageIndex , double itemPrice){
    emit(CategoryDetailsLoadingState());
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
        emit(CategoryDetailsSuccessState()),
      }).catchError((onError){
        emit(CategoryDetailsErrorState());
      });
    });


  }

  void addToWishList(String userID ,String itemCategory, String itemID , String itemName,String itemNameAR, int itemSizeIndex, int itemColorImageIndex , double itemPrice){
    emit(CategoryDetailsLoadingState());
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
        emit(CategoryDetailsSuccessState()),
      }).catchError((onError){
        emit(CategoryDetailsErrorState());
      });
    });


  }

  void removeFromWishList(String userID, String itemID){
    emit(CategoryDetailsLoadingState());
    FirebaseFirestore.instance.collection("WishList").doc(userID).collection("WishItem").doc(itemID).delete().then((value){
      emit(CategoryDetailsSuccessState());
    }).catchError((onError){
      emit(CategoryDetailsErrorState());
    });
  }

}

