import 'package:easy_localization/easy_localization.dart';
import 'package:final_project/StateManagemnt/Profile/cubit.dart';
import 'package:final_project/StateManagemnt/Profile/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class MyWishList extends StatefulWidget {
  final String userID;
  const MyWishList({Key? key, required this.userID}) : super(key: key);

  @override
  State<MyWishList> createState() => _MyWishListState();
}

class _MyWishListState extends State<MyWishList> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit,ProfileStates>(
      listener: (c,states){},
      builder: (c,state){
        if(state is ProfileSuccessState){
          return c.read<ProfileCubit>().wishItems.isEmpty ?   Center(child: Text("noWish".tr()),): Padding(
            padding: const EdgeInsets.only(left: 7.0,top: 5),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio:0.7,

              ),
              //physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: c.read<ProfileCubit>().wishItems.length,
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
                            height:MediaQuery.of(context).size.height*0.30,
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(5)),
                                color: Colors.grey.shade200,
                                image:  DecorationImage(
                                  image: NetworkImage("${c.read<ProfileCubit>().wishItems[index].itemImage}"),
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
                     // const SizedBox(height: 10,),
                       Expanded(child: Text("${EasyLocalization.of(context)!.currentLocale.toString() == "en_US" ? c.read<ProfileCubit>().wishItems[index].itemName :  c.read<ProfileCubit>().wishItems[index].itemNameAR}",style: TextStyle(fontSize: 16),)),
                     // const SizedBox(height: 5,),
                       Expanded(child: Text("${c.read<ProfileCubit>().wishItems[index].itemPrice} ${"jod".tr()}",style: TextStyle(fontSize: 16),))
                    ],
                  ),
                );
              },),
          );
        }
        else{
          return Center(child: CircularProgressIndicator(),);
        }
      },
    );
  }
}
