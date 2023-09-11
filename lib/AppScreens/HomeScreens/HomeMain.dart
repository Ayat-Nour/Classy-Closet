import 'package:final_project/AppScreens/HomeScreens/EditProfile/EditProfileScreen.dart';
import 'package:final_project/AppScreens/HomeScreens/HomeTabs/Cart.dart';
import 'package:final_project/AppScreens/HomeScreens/HomeTabs/Home.dart';
import 'package:final_project/AppScreens/HomeScreens/HomeTabs/Profile.dart';
import 'package:final_project/StateManagemnt/HomeMain/cubit.dart';
import 'package:final_project/StateManagemnt/HomeMain/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeMain extends StatefulWidget {
  final String id;
   int selectedIndex;
   HomeMain({Key? key, required this.id, required this.selectedIndex}) : super(key: key);

  @override
  State<HomeMain> createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain> {


  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      CartPage(userID: widget.id,),
      const HomePage(),
      ProfilePage(userID: widget.id,),

    ];
    return BlocProvider(
      create: (context)=>HomeMainCubit()..getUser(widget.id)..getTopRated()..getCategories(),
      child: BlocConsumer<HomeMainCubit,HomeMainStates>(
        listener: (context,state){},
        builder: (context,state){
          return  Scaffold(
            appBar: AppBar(
              iconTheme:  IconThemeData(color: Theme.of(context).appBarTheme.iconTheme?.color),
              backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
              elevation: 0,
              centerTitle: true,
              actions:  [
                state is HomeMainSuccessState && context.read<HomeMainCubit>().user != null

                ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> const EditProfileScreen()));
                    },
                    child: CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(
                          "${context.read<HomeMainCubit>().user!.img}"),
                    ),
                  ),
                ): const Center(child: CircularProgressIndicator(),),
              ],
              title: state is HomeMainSuccessState ? Column(
                children: [
                  Text(
                    "${context.read<HomeMainCubit>().user!.name}",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Text(
                    "${context.read<HomeMainCubit>().user!.address}",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ):const Center(child: CircularProgressIndicator(),),
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_bag,color: Colors.white,), label: "Shopping cart",),
                BottomNavigationBarItem(icon: Icon(Icons.home,color: Colors.white), label: "Home"),
                BottomNavigationBarItem(icon: Icon(Icons.person,color: Colors.white), label: "Me"),
              ],
              backgroundColor: Colors.black,
              unselectedItemColor: Colors.white,
              currentIndex: widget.selectedIndex,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              selectedIconTheme: const IconThemeData(size: 38),
              onTap: (x){
                setState(() {
                  widget.selectedIndex=x;
                });
              },

            ),
            body: screens[widget.selectedIndex],
          );
        },
      ),
    );
  }
}
