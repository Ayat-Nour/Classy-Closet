import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

class CreditCardScreen extends StatelessWidget {
  const  CreditCardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:     SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height*0.05,
              ),
              CreditCardWidget(
                cardNumber: "12345678912345",
                expiryDate: "04/23",
                cardHolderName: "Ayat nour",
                cvvCode: "145",
                bankName: "Today Bank",
                cardType: CardType.mastercard,
                obscureCardCvv: false,
                isChipVisible: true,
                cardBgColor: Colors.black12,
                isHolderNameVisible: true,
                showBackView: false, onCreditCardWidgetChange: (CreditCardBrand ) {  }, //true when you want to show cvv(back) view
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 15),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Number",
                    hintStyle: TextStyle(fontSize: 14),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(width: 1, color: Colors.black38),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width*0.4,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Expired date",
                          hintStyle: TextStyle(fontSize: 14),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(width: 1, color: Colors.black38),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width*0.4,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "CCV",
                          hintStyle: TextStyle(fontSize: 14),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(width: 1, color: Colors.black38),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ],),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 15),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Card Holder",
                    hintStyle: TextStyle(fontSize: 14),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(width: 1, color: Colors.black38),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.1,
              ),

            ],
          ),
        ),
      ),
    );
  }
}
