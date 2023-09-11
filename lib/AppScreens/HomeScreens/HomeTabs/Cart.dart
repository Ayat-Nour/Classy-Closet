import 'package:easy_localization/easy_localization.dart';
import 'package:final_project/AppScreens/PlaceOrderScreens/PaymentScreen.dart';
import 'package:final_project/Models/OrderHistoryModel.dart';
import 'package:final_project/Models/UserModel.dart';
import 'package:final_project/StateManagemnt/Bag/cubit.dart';
import 'package:final_project/StateManagemnt/Bag/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math';

class CartPage extends StatefulWidget {
  final String ?userID;
  const CartPage({Key? key, this.userID,}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {



 @override

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: BlocProvider(
        create: (c)=> BagCubit()..getBag(widget.userID!)..getWishList(widget.userID!)..getRandomOrderID(),
        child: BlocConsumer<BagCubit,BagStates>(
          builder: (c,state){
            if (state is BagSuccessState){
              return  SingleChildScrollView(
                physics: const ScrollPhysics(),
                child: Column(
                  children: [
                    c.read<BagCubit>().cartItems.isEmpty? SizedBox(
                      height: MediaQuery.of(context).size.height*0.4,
                      child: Center(child: Text("noCart".tr()),),) :Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                      child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: c.read<BagCubit>().cartItems.length,
                          itemBuilder: (context,index){
                            return
                              Column(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height*0.19,
                                  color: Theme.of(context).colorScheme.background,
                                  child: Expanded(
                                    child: Row(
                                      children: [
                                        Flexible(
                                          flex:3,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 10),
                                            child: SizedBox(
                                              height: MediaQuery.of(context).size.height*0.17,
                                              child: Image.network(c.read<BagCubit>().cartItems[index].itemImage!,fit: BoxFit.cover,),
                                            ),
                                          ),
                                        ),
                                        Flexible(
                                          flex: 4,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              //const SizedBox(height: 10,),
                                               Flexible(
                                                   flex: 2,
                                                   child: Text(EasyLocalization.of(context)!.currentLocale.toString() == "en_US"? c.read<BagCubit>().cartItems[index].itemName!:c.read<BagCubit>().cartItems[index].itemNameAR!,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),overflow: TextOverflow.fade,)),

                                              Flexible(
                                                flex: 1,
                                                child: Container(
                                                  width: 75,
                                                  height: 25,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(50),
                                                    color: Theme.of(context).colorScheme.onBackground
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                                    children: [
                                                      CircleAvatar(
                                                        radius: 15,
                                                        backgroundColor: Colors.black,
                                                        child: CircleAvatar(
                                                          radius: 11,
                                                          backgroundColor: Color(int.parse(c.read<BagCubit>().cartItems[index].itemColor!)),
                                                        ),
                                                      ),

                                                       Center(child: Text(c.read<BagCubit>().cartItems[index].itemSize!,style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold),)),

                                                      const Center(child: Icon(Icons.keyboard_arrow_down_outlined)),
                                                     // const SizedBox(width: 5,),
                                                    ],
                                                  ),
                                                ),
                                              ),

                                               Flexible(
                                                   flex: 1,
                                                   child: Text("${c.read<BagCubit>().cartItems[index].itemPrice! * c.read<BagCubit>().cartItems[index].itemQuantity!} ${"jod".tr()}",style: const TextStyle(fontSize: 20,),)),

                                            ],
                                          ),
                                        ),

                                        Flexible(
                                          flex: 2,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              const SizedBox(height: 10,),
                                              Image.asset("lib/assets/png/moveTowishList.png",height: 20,),
                                             const Spacer(),
                                              Container(
                                                width: 80,
                                                height: 25,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(20),
                                                  color: Theme.of(context).colorScheme.onBackground
                                                ),
                                                child: Center(
                                                  child: Text("+    ${c.read<BagCubit>().cartItems[index].itemQuantity!}    -",style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                                                ),
                                              ),
                                              const SizedBox(height: 10,),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 7,),
                                 index == c.read<BagCubit>().cartItems.length -1 ?Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height*0.09,
                                   color: Theme.of(context).colorScheme.background,

                                   child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,

                                          children:  [
                                            Text("JOD ${c.read<BagCubit>().totalPrice}",style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                                            Text("(${c.read<BagCubit>().totalQuantity})"+"item".tr(),style: const TextStyle(fontSize: 16),),
                                          ],
                                        ),
                                      ),
                                      InkWell(
                                        onTap:(){
                                          c.read<BagCubit>().placeOrder(widget.userID!,c.read<BagCubit>().orderID!,DateTime.now().toString(), c.read<BagCubit>().totalPrice, 1, c.read<BagCubit>().itemsImages, c.read<BagCubit>().totalQuantity,  );
                                          Navigator.push(context, MaterialPageRoute(builder: (context) =>  PaymentScreen(userID: widget.userID,orderID:c.read<BagCubit>().orderID!,)));
                                          },
                                        child: Container(
                                          width: MediaQuery.of(context).size.width*0.5,
                                          height: MediaQuery.of(context).size.height*0.09,
                                          color: Theme.of(context).colorScheme.onSecondary,
                                          child:  Center(child:Text("checkOut".tr(),style: const TextStyle(color: Colors.white,fontSize: 20),),),
                                        ),
                                      )
                                    ],
                                  ),
                                ):Container(),
                              ],
                            );
                          }),
                    ),
                    const SizedBox(height: 20,),
                    c.read<BagCubit>().wishItems.isEmpty ? Container():Container(
                      color: Theme.of(context).colorScheme.background,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child:  Column(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width*2,
                            height: MediaQuery.of(context).size.height*0.05,
                            child:  Center(child: Text("addFav".tr(),style: const TextStyle(fontSize:18 ),)),),

                          GridView.builder(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio:0.7,

                            ),
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: c.read<BagCubit>().wishItems.length,
                            itemBuilder: (context,index){
                              return Padding(
                                padding: const EdgeInsets.all(5),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Stack(
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context).size.width*0.45,
                                          height:MediaQuery.of(context).size.height*0.27,
                                          decoration: BoxDecoration(
                                              borderRadius: const BorderRadius.all(Radius.circular(5)),
                                              color: Colors.grey.shade200,
                                              image:  DecorationImage(
                                                image: NetworkImage("${c.read<BagCubit>().wishItems[index].itemImage}"),
                                                fit: BoxFit.cover,
                                              )
                                          ),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: CircleAvatar(
                                            radius: 15,
                                            backgroundColor: Colors.white,
                                            child: Icon(Icons.add_shopping_cart,color: Colors.black,),
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 10,),
                                     Expanded(child:  Text("${EasyLocalization.of(context)!.currentLocale.toString() == "en_US" ?  c.read<BagCubit>().wishItems[index].itemName:c.read<BagCubit>().wishItems[index].itemNameAR}",style: const TextStyle(fontSize: 16),),),

                                    const SizedBox(height: 5,),
                                     Text("${c.read<BagCubit>().wishItems[index].itemPrice} ${"jod".tr()}",style: const TextStyle(fontSize: 16),)
                                  ],
                                ),
                              );
                            },),
                        ],
                      ),
                    )
                  ],
                ),
              );
            }
            else {
              return const Center(child: CircularProgressIndicator(),);
            }
          },
          listener: (c,state){},
        ),
      )
    );
  }
}