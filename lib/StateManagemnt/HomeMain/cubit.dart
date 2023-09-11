import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/Models/CategoriesModel.dart';
import 'package:final_project/Models/ItemModel.dart';
import 'package:final_project/Models/UserModel.dart';
import 'package:final_project/StateManagemnt/HomeMain/states.dart';

class HomeMainCubit extends Cubit<HomeMainStates>{
  HomeMainCubit():super(HomeMainInitState());
List<CategoriesModel> categories =[];
List<ItemModel> topRated =[];
 UserModel ? user;

  void getCategories(){
    emit(HomeMainLoadingState());
    FirebaseFirestore.instance.collection("Categories").get().then((value) => {
      for(var element in value.docs){
        categories.add(CategoriesModel.fromJson(element.data()))
      }
    }).then((value) => {
      emit(HomeMainSuccessState()),
    }).catchError((onError){
      print(onError);
      emit(HomeMainErrorState());
    });

  }

  void getTopRated(){
    emit(HomeMainLoadingState());
    FirebaseFirestore.instance.collection("Items").where("itemRate",isEqualTo: "5").get().then((value) => {
      for(var element in value.docs){
        topRated.add(ItemModel.fromJson(element.data()))
      }
    }).then((value) => {

      emit(HomeMainSuccessState()),
    }).catchError((onError){

      emit(HomeMainErrorState());
    });

  }

  void getUser(String id){
    emit(HomeMainLoadingState());
    FirebaseFirestore.instance.collection("Users").doc(id).get().then((value){
      user = UserModel.fromJson(value.data() as Map<String, dynamic>);
    }).then((value) {
      emit(HomeMainSuccessState());
    }).catchError((onError){
      emit(HomeMainErrorState());
    });
  }


}