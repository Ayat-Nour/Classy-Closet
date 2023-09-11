import 'package:final_project/StateManagemnt/EditProfile/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileCubit extends Cubit<EditProfileStates>{
  EditProfileCubit():super(EditProfileInitState());

  bool isLightMood=true;

  void changeMode(){
    isLightMood = !isLightMood;
    print(isLightMood);
    emit(ChangeThemeState());
  }
}