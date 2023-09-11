import 'package:easy_localization/easy_localization.dart';
import 'package:final_project/AppScreens/HomeScreens/HomeMain.dart';
import 'package:final_project/AppScreens/PlaceOrderScreens/CreditCardScreen.dart';
import 'package:final_project/Models/UserModel.dart';
import 'package:final_project/StateManagemnt/Payment/cubit.dart';
import 'package:final_project/StateManagemnt/Payment/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Models/OrderHistoryModel.dart';
import '../HomeScreens/EditProfile/EditProfileScreen.dart';


class PaymentScreen extends StatefulWidget {
  final String ?userID;
  final String ?orderID;
  const PaymentScreen({Key? key, this.userID, this.orderID}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (c)=>PaymentCubit()..getOrder(widget.userID!, widget.orderID!),
      child: BlocConsumer<PaymentCubit,PaymentStates>(
        listener: (c,state){
          if(state is PaymentSuccessState && state.isOrderPlaced!){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeMain(id: widget.userID!,selectedIndex: 2,)));
          }
        },
        builder: (c,state){
          if(state is PaymentSuccessState){
            return  Scaffold(
               appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.black),
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
            elevation: 0,
            centerTitle: true,
            actions:  [
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> const EditProfileScreen()));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage("${c.read<PaymentCubit>().user!.img}"),
                  ),
                ),
              ),
            ],
            title:Column(
              children: [
                Text(
                  "${c.read<PaymentCubit>().user!.name}",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  "${c.read<PaymentCubit>().user!.address}",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Text("${"total1".tr()} : ${c.read<PaymentCubit>().order!.orderTotalPrice}",style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                        const SizedBox(height: 20,),
                        Row(
                          children: [
                            const Icon(Icons.home_work,color: Colors.grey,),
                            const SizedBox(width: 20,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:  [
                                 Text("warehouse".tr(),style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                                Text("${c.read<PaymentCubit>().order!.orderTotalQuantity} ${"item".tr()}",style: const TextStyle(fontSize: 14,color: Colors.grey),),
                              ],
                            ),
                          ],
                        ),
                        const Icon(Icons.more_vert,color: Colors.grey,),
                        Row(
                          children: [
                            const Icon(Icons.location_on,color: Colors.grey,),
                            const SizedBox(width: 20,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:  [
                                Text("${c.read<PaymentCubit>().user!.name} ${"address".tr()}",style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                                Text("${c.read<PaymentCubit>().user!.address}",style: const TextStyle(fontSize: 14,color: Colors.grey),),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 20,),
                        const Divider(thickness: 1,),
                        const SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                             Text("credit".tr(),style:const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                            TextButton(onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const CreditCardScreen()));
                            }, child:  Text("addCard".tr(),style: const TextStyle(color: Colors.pink,fontSize: 16),))
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.credit_card,color: Colors.grey,size: 40,),
                            const SizedBox(width: 20,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text("************4356",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.grey),),
                                Text("Ayat Nur",style: TextStyle(fontSize: 14,color: Colors.grey),),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 20,),
                        const Divider(thickness: 1,),
                        const SizedBox(height: 20,),
                         Text("save".tr(),style: const TextStyle(color: Colors.grey,fontSize: 14),),
                        Row(children: [
                          Image.network("https://icons-for-free.com/iconfiles/png/512/Mastercard-1320568043376143718.png",width: 50,),
                          const SizedBox(width: 10,),
                          Image.network("https://cdn.iconscout.com/icon/free/png-256/maestro-5-675721.png",width: 50,),
                          const SizedBox(width: 10,),
                          Image.network("https://cdn2.iconfinder.com/data/icons/shopping-online-e-commerce-store/512/visa-512.png",width: 50,),
                        ],),
                        const SizedBox(height: 20,),
                         Text("wallet".tr(),style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                        const SizedBox(height: 20,),
                         ListTile(
                          leading: const CircleAvatar(
                            radius: 15,
                            backgroundImage: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRyKmJd7F0S3Raf7rnCZhOKeBev5iy5yo0xYbo-9wR7N1QIBoHSFP55eykLc6mcdDBmaN8&usqp=CAU"),
                          ),
                          title: Text("phone".tr(),style: const TextStyle(fontSize: 16),),
                        ),
                        const Divider(),
                         ListTile(
                          leading: const CircleAvatar(
                            radius: 15,
                            backgroundImage: NetworkImage("https://static1.anpoimages.com/wordpress/wp-content/uploads/2020/11/05/Google-Pay-India-Tez-new-icon.jpg"),

                          ),
                          title: Text("google".tr(),style: const TextStyle(fontSize: 16),),
                        ),
                        const Divider(),
                        const ListTile(
                          leading: CircleAvatar(
                            radius: 15,
                            backgroundImage: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQYOEqzq7I3jawfifoi-s22O6cnOEWV9vKZWry-WYfP5d5xMKPqookpXbjSL6l7yAmlpHw&usqp=CAU"),

                          ),
                          title: Text("pay pal",style: TextStyle(fontSize: 16),),
                        ),
                        const SizedBox(height: 15,),
                        InkWell(
                          onTap: (){
                            c.read<PaymentCubit>().emptyBag(widget.userID!, widget.orderID!);
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height*0.07,
                            color: Theme.of(context).colorScheme.onSecondary,
                            child: Center(
                              child: Text("payNow".tr(),style: const TextStyle(color: Colors.white,fontSize: 20),),
                            ),
                          ),
                        )



                      ],
                    ),
                  ),
                ),
              ),
            );
          }else{
            return const Scaffold(body: Center(
              child: CircularProgressIndicator(),
            )
              ,);
          }
        },

      ),
    );
  }
}
