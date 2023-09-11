import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:final_project/Models/CartModel.dart';
import 'package:final_project/Models/UserModel.dart';
import 'package:final_project/StateManagemnt/CategoryDetails/cubit.dart';
import 'package:final_project/StateManagemnt/CategoryDetails/states.dart';
import 'package:final_project/StateManagemnt/Search/cubit.dart';
import 'package:final_project/StateManagemnt/Search/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../EditProfile/EditProfileScreen.dart';

class SearchResult extends StatefulWidget {
  final String ? categoryId;
  final UserModel ? currentUser;
  final String ? search;
  const SearchResult({Key? key,this.categoryId, this.currentUser, this.search}) : super(key: key);

  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  List<String> itemColors = [];
  int  itemColorImageIndex=0;
  int  itemSizeIndex=0;
  int itemQuantity =1;
  String ? itemName;
  String ? itemNameAR;
  String ? itemID;
  String ? itemCategory;
  double ? itemPrice;
  bool isFav=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                backgroundImage: NetworkImage("${widget.currentUser!.img}"),
              ),
            ),
          ),
        ],
        title:Column(
          children: [
            Text(
              "${widget.currentUser!.name}",
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Text(
              "${widget.currentUser!.address}",
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: BlocProvider(
          create: (c)=>SearchCubit()..getSearchResult(widget.search!),
          child: BlocConsumer<SearchCubit,SearchStates>(
            listener: (c,state){},
            builder: (c,state){
              if(state is SearchSuccessState){
                return Padding(
                  padding:  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio:0.65,
                    ),
                    //physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: c.read<SearchCubit>().searchResult.length,
                    itemBuilder: (context,index){
                      return Padding(
                        padding: const EdgeInsets.all(5),
                        child: InkWell(
                          onTap: (){
                            itemName =  c.read<SearchCubit>().searchResult[index].itemName;
                            itemNameAR = c.read<SearchCubit>().searchResult[index].itemNameAR;
                            itemID =  c.read<SearchCubit>().searchResult[index].itemID;
                            itemCategory =  c.read<SearchCubit>().searchResult[index].itemCategory;
                            itemPrice = double.parse( c.read<SearchCubit>().searchResult[index].itemPrice!);
                            showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                elevation: 10,
                                useSafeArea: true,
                                backgroundColor: Theme.of(context).colorScheme.background,
                                builder: (context) {
                                  return StatefulBuilder(
                                    builder: (BuildContext context, void Function(void Function()) setState) {
                                      return Wrap(
                                        children: <Widget>[
                                          Container(
                                            width: MediaQuery.of(context).size.width,
                                            height: MediaQuery.of(context).size.height*0.63,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: NetworkImage("${ c.read<SearchCubit>().searchResult[index].itemImage![itemColorImageIndex]}",),
                                                    fit: BoxFit.fitWidth
                                                )
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 15.0,horizontal: 20),
                                            child: Text(EasyLocalization.of(context)!.currentLocale.toString() == "en_US" ?    c.read<SearchCubit>().searchResult[index].itemName! :  c.read<SearchCubit>().searchResult[index].itemNameAR!,style: const TextStyle(fontSize: 20),),
                                          ),
                                          Row(
                                            children: [
                                              Column(
                                                children: [
                                                  SizedBox(
                                                    width: MediaQuery.of(context).size.width*0.5,
                                                    height: MediaQuery.of(context).size.height*0.05,
                                                    child: Padding(
                                                      padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 15),
                                                      child: ListView.builder(
                                                          shrinkWrap: true,
                                                          scrollDirection: Axis.horizontal,
                                                          itemCount:  c.read<SearchCubit>().searchResult[index].itemColor!.length,
                                                          itemBuilder: (context,i){
                                                            return InkWell(
                                                              onTap: (){
                                                                setState(() {
                                                                  itemColorImageIndex = i;
                                                                });
                                                              },
                                                              child: Padding(
                                                                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                                                child: CircleAvatar(
                                                                  radius: 12,
                                                                  backgroundColor: itemColorImageIndex==i ? Theme.of(context).colorScheme.onPrimary : Theme.of(context).colorScheme.background,
                                                                  child: CircleAvatar(
                                                                    radius: 10,
                                                                    backgroundColor: Color(int.parse( c.read<SearchCubit>().searchResult[index].itemColor![i])),
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          }),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: MediaQuery.of(context).size.width*0.5,
                                                    height: MediaQuery.of(context).size.height*0.05,
                                                    child: Padding(
                                                      padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 15),
                                                      child: ListView.builder(
                                                          shrinkWrap: true,
                                                          scrollDirection: Axis.horizontal,
                                                          itemCount:  c.read<SearchCubit>().searchResult[index].itemSize!.length,
                                                          itemBuilder: (context,i){
                                                            return InkWell(
                                                              onTap: (){
                                                                setState((){
                                                                  itemSizeIndex=i;
                                                                });
                                                              },
                                                              child: Padding(
                                                                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                                                child: CircleAvatar(
                                                                  radius: 12,
                                                                  backgroundColor: Theme.of(context).colorScheme.onPrimary,
                                                                  child: CircleAvatar(
                                                                    radius: 11,
                                                                    backgroundColor: itemSizeIndex==i ? Theme.of(context).colorScheme.onPrimary :Theme.of(context).colorScheme.onBackground,
                                                                    child: Center(
                                                                      child: Text( c.read<SearchCubit>().searchResult[index].itemSize![i],style:  TextStyle(color: itemSizeIndex==i ?Theme.of(context).colorScheme.onBackground:Theme.of(context).colorScheme.onPrimary,fontSize: 14),),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          }),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                      height: MediaQuery.of(context).size.height*0.05,
                                                      width: MediaQuery.of(context).size.width*0.5,
                                                      child: Center(child: Text("${ c.read<SearchCubit>().searchResult[index].itemPrice}"+"jod".tr(),style: const TextStyle(fontSize: 24),),)),
                                                  SizedBox(
                                                      height: MediaQuery.of(context).size.height*0.05,
                                                      width: MediaQuery.of(context).size.width*0.5,
                                                      child:  Center(child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                          InkWell(
                                                              onTap: (){
                                                                setState((){
                                                                  itemQuantity++;
                                                                });
                                                              },
                                                              child: const Text("+   ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
                                                          Text("$itemQuantity",style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                                          InkWell(
                                                              onTap: (){
                                                                setState((){
                                                                  if(itemQuantity>1) itemQuantity--;
                                                                });
                                                              },
                                                              child: const Text("   -",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
                                                        ],
                                                      ),)),
                                                ],
                                              )
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(top:15.0),
                                            child: Container(
                                              width: MediaQuery.of(context).size.width,
                                              height: MediaQuery.of(context).size.height*0.08,
                                              color: Colors.black,
                                              child: Row(
                                                children:  [
                                                  Expanded(
                                                    flex:1,
                                                    child: InkWell(
                                                      onTap: (){
                                                        setState((){
                                                          isFav=!isFav;
                                                        });
                                                        isFav ? c.read<SearchCubit>().addToWishList(widget.currentUser!.id!, itemCategory!, itemID!, itemName!, itemNameAR!,itemSizeIndex, itemColorImageIndex, itemPrice!): c.read<SearchCubit>().removeFromWishList(widget.currentUser!.id!, itemID!);
                                                      },
                                                      child: Icon(Icons.favorite,color: isFav ? Colors.red : Colors.white,size: 30,),
                                                    ),
                                                  ),
                                                  Expanded(
                                                      flex:3,
                                                      child: InkWell(
                                                          onTap: (){
                                                            c.read<SearchCubit>().addToBag(widget.currentUser!.id!, itemID!, itemName!,itemNameAR!, itemQuantity, itemSizeIndex, itemColorImageIndex, itemPrice!);
                                                          },
                                                          child: Center(child: Text("addToBag".tr(),style: const TextStyle(color: Colors.white,fontSize: 22),),)))
                                                ],
                                              ),
                                            ),
                                          )

                                        ],
                                      );
                                    },

                                  );
                                }).then((value) {
                              itemQuantity=1;
                              itemSizeIndex=0;
                              itemColorImageIndex=0;

                            });

                          },
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
                                          image: NetworkImage("${ c.read<SearchCubit>().searchResult[index].itemImage![0]}"),
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
                              Expanded(child: Text("${EasyLocalization.of(context)!.currentLocale.toString() == "en_US" ?    c.read<SearchCubit>().searchResult[index].itemName :  c.read<SearchCubit>().searchResult[index].itemNameAR }",style: const TextStyle(fontSize: 16),)),
                              const SizedBox(height: 5,),
                              Text("${ c.read<SearchCubit>().searchResult[index].itemPrice} ${"jod".tr()}",style: const TextStyle(fontSize: 16),)
                            ],
                          ),
                        ),
                      );
                    },),
                );
              }
              else {
                return const Center(child: CircularProgressIndicator(),);
              }
            },
          ),
        ),
      ),
    );
  }
}
