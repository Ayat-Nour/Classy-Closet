abstract class SignupStates{}

class SignupInitState extends SignupStates{}
class SignupSuccessState extends SignupStates{
  String ? Id;
  SignupSuccessState({this.Id});

}
class SignupErrorState extends SignupStates{}
class SignupLoadingState extends SignupStates{}