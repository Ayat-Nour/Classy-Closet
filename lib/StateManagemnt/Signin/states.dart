abstract class SignInStates{}

class SignInInitState extends SignInStates{}
class SignInLoadingState extends SignInStates{}
class SignInSuccessState extends SignInStates{
  String ? Id;
  SignInSuccessState({this.Id});

}
class SignInErrorState extends SignInStates{}