abstract class PaymentStates{}

class PaymentInitState extends PaymentStates{}
class PaymentLoadingState extends PaymentStates{}
class PaymentSuccessState extends PaymentStates{
  bool ? isOrderPlaced ;
  PaymentSuccessState(this.isOrderPlaced);

}
class PaymentErrorState extends PaymentStates{}