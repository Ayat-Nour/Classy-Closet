
import 'package:easy_localization/easy_localization.dart';
import 'package:final_project/StateManagemnt/Payment/states.dart';
import 'package:final_project/StateManagemnt/Profile/cubit.dart';
import 'package:final_project/StateManagemnt/Profile/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrdersHistory extends StatefulWidget {
  final String ? userID;
  const OrdersHistory({Key? key, this.userID}) : super(key: key);

  @override
  State<OrdersHistory> createState() => _OrdersHistoryState();
}

class _OrdersHistoryState extends State<OrdersHistory> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit,ProfileStates>(
      listener: (c,state){},
      builder: (c,state){
        if(state is ProfileSuccessState){
          return c.read<ProfileCubit>().orders.isEmpty ?   Center(child: Text("noOrders".tr()),):  Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Center(
              child: ListView.builder(
                  itemCount: c.read<ProfileCubit>().orders.length,

                  itemBuilder: (context,index){
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height*0.22,
                            child: Center(
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width*0.3,
                                    child: GridView(gridDelegate:  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio:1,
                                    ),
                                      //physics: const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      children: [
                                        c.read<ProfileCubit>().orders[index].orderImages!.isNotEmpty ? Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Image.network("${c.read<ProfileCubit>().orders[index].orderImages![0]}",fit: BoxFit.fitWidth,),
                                        ):Container(),
                                        c.read<ProfileCubit>().orders[index].orderImages!.length>=2? Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Image.network("${c.read<ProfileCubit>().orders[index].orderImages![1]}",fit: BoxFit.fitWidth,),
                                        ):Container(),
                                        c.read<ProfileCubit>().orders[index].orderImages!.length>=3? Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Image.network("${c.read<ProfileCubit>().orders[index].orderImages![2]}",fit: BoxFit.fitWidth,),
                                        ):Container(),
                                        c.read<ProfileCubit>().orders[index].orderImages!.length>=4? Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Image.network("${c.read<ProfileCubit>().orders[index].orderImages![3]}",fit: BoxFit.fitWidth,),
                                        ):Container(),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width:  MediaQuery.of(context).size.width*0.02,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children:  [
                                      SizedBox(height:  MediaQuery.of(context).size.height*0.01,),
                                      Text("${"OrderNo".tr()} ${c.read<ProfileCubit>().orders[index].orderID}",style: const TextStyle(fontSize: 14),),
                                      SizedBox(height:  MediaQuery.of(context).size.height*0.01,),
                                      Text("${"OrderDate".tr()} ${c.read<ProfileCubit>().orders[index].orderTime}",style: const TextStyle(fontSize: 14)),
                                      SizedBox(height:  MediaQuery.of(context).size.height*0.01,),
                                      Text("${"total".tr()} ${c.read<ProfileCubit>().orders[index].orderTotalPrice} JOD",style: const TextStyle(fontSize: 14)),
                                      SizedBox(height:  MediaQuery.of(context).size.height*0.01,),
                                      Text("${"count".tr()} ${c.read<ProfileCubit>().orders[index].orderTotalQuantity}",style: const TextStyle(fontSize: 14)),
                                      const Spacer(),
                                      Text("${"status".tr()} ${c.read<ProfileCubit>().orders[index].orderStatus==1? "status1".tr():"status2".tr()}",style: const TextStyle(fontSize: 14)),
                                      SizedBox(height:  MediaQuery.of(context).size.height*0.01,),

                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          const Divider(thickness: 2,),
                        ],
                      ),
                    );
                  }),
            ),
          );
        }
        else{
          return const Center(child: CircularProgressIndicator(),);
        }
      },
    );
  }
}
