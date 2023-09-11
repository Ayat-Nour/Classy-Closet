import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/StateManagemnt/Signup/states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupCubit extends Cubit<SignupStates>{
  SignupCubit():super(SignupInitState());


  void signUp(String name, String password, String email,String phone){
    emit(SignupLoadingState());

    FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((value) {
      FirebaseFirestore.instance.collection("Users").doc(value.user!.uid.toString()).set(
          {
            "id":value.user!.uid,
            "name":name,
            "email":email,
            "password":password,
            "phone":phone,
            "img":"https://t3.ftcdn.net/jpg/02/31/19/64/360_F_231196474_IT7zKhOFyJCqEJr3b9huL4W0ODVWsZd0.webp",
            "country":"",
            "address":"",
          }).then((value){
            print("!!!!!!!!!!!!!!!");
      }).catchError((onError){
        print(onError);
      });
      emit(SignupSuccessState(Id:value.user!.uid));
    }).catchError((onError){
      emit(SignupErrorState());
    });

  }

  void signUpAddress(String country, String address,String id){
    emit(SignupLoadingState());

    FirebaseFirestore.instance.collection("Users").doc(id).update(
        {
          "country":country,
          "address":address,

        }).then((value){
          emit(SignupSuccessState(Id: id));
    }).catchError((onError){
      emit(SignupErrorState());
    });

  }

}