import 'package:easy_localization/easy_localization.dart';
import 'package:final_project/AppScreens/HomeScreens/ProfileTabs/WishList.dart';
import 'package:final_project/AppScreens/HomeScreens/ProfileTabs/ordersHistory.dart';
import 'package:final_project/StateManagemnt/Profile/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatefulWidget {
  final String userID;
  const ProfilePage({Key? key, required this.userID}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (c)=> ProfileCubit()..getOrderHistory(widget.userID)..getWishList(widget.userID),
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar:PreferredSize(
            preferredSize: const Size.fromHeight(70),
            child: AppBar(

              bottom: TabBar(
                labelColor: Colors.white,
                indicatorColor: Colors.pink,
                tabs: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children:  [
                      Icon(Icons.list_alt,color: Theme.of(context).iconTheme.color,),
                      const SizedBox(height: 5,),
                      Text("myOrders".tr(),style: Theme.of(context).textTheme.bodyMedium),
                      const SizedBox(height: 5,),

                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children:  [
                      Icon(Icons.favorite,color: Theme.of(context).iconTheme.color,),
                      const SizedBox(height: 5,),
                      Text("myWish".tr(),style:Theme.of(context).textTheme.bodyMedium),
                      const SizedBox(height: 5,),

                    ],
                  ),
                ],
              ),
            ),
          ),
          body: TabBarView(
            children: [
              OrdersHistory(userID: widget.userID!),
              MyWishList(userID: widget.userID!,),
            ],
          ),
        ),
      ),
    );
  }
}
