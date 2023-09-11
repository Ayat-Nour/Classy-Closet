import 'package:final_project/StateManagemnt/Signin/states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInCubit extends Cubit<SignInStates>{
  SignInCubit():super(SignInInitState());

  void signIn(String email,String password){
    emit(SignInLoadingState());

    FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value) {
      emit(SignInSuccessState(Id: value.user!.uid));
    }).catchError((onError){
      emit(SignInErrorState());
    });
  }
}