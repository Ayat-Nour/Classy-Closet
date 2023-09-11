import 'package:easy_localization/easy_localization.dart';
import 'package:final_project/AppScreens/HomeScreens/Categories/CategorieDetails.dart';
import 'package:final_project/AppScreens/HomeScreens/Search/SearchResult.dart';
import 'package:final_project/StateManagemnt/HomeMain/cubit.dart';
import 'package:final_project/StateManagemnt/HomeMain/states.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class HomePage extends StatefulWidget {

  const HomePage({Key? key,}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> imageSliders = [
    Image.network(
      "https://www.usmagazine.com/wp-content/uploads/2022/09/camel-tan-neutral-fall-fashion.jpg?quality=55&strip=all",
      width: 500,
      fit: BoxFit.cover,
    ),
    Image.network(
      "https://hips.hearstapps.com/hmg-prod/images/emilie-joseph-wears-sunglasses-golden-earrings-a-beige-news-photo-1641239127.jpg?resize=1200:*",
      width: 500,
      fit: BoxFit.cover,
    ),
    Image.network(
      "https://publish.purewow.net/wp-content/uploads/sites/2/2021/08/fall-fashion-finds-cat.png",
      width: 500,
      fit: BoxFit.cover,
    )
  ];

  int ? index2;
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<HomeMainCubit,HomeMainStates>(
      listener: (c,state){},
      builder: (c,state){
        return SafeArea(
          child: SingleChildScrollView(
              physics: const ScrollPhysics(),
              child: Column(
                children: [
                  Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                    child: SizedBox(
                      height: 50,
                      child: TextField(
                        onEditingComplete: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> SearchResult(search: searchController.text,currentUser: c.read<HomeMainCubit>().user,)));

                        },
                          controller: searchController,
                          textAlignVertical: TextAlignVertical.center,
                          style: Theme.of(context).textTheme.bodySmall,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Theme.of(context).colorScheme.background,
                              hintText: "search".tr(),
                              hintStyle: Theme.of(context).textTheme.bodySmall,
                              prefixIcon:  Icon(
                                Icons.search,
                                color: Theme.of(context).iconTheme.color,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide.none))),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 20),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.17,
                          decoration: BoxDecoration(
                              color: Colors.pink.shade100,
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.25,
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        "Buy More and Save More",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25,
                                        ),
                                        softWrap: true,
                                      ),
                                      Text(
                                        "get 50% off when you buy 3 items",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                        ),
                                        softWrap: true,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      EasyLocalization.of(context)!.currentLocale.toString() =="en_US"?Positioned(
                          top: -10,
                          left: -40,
                          child: Image.asset(
                            "lib/assets/png/saleimage.png",
                            height: 170,
                          )):Positioned(
                          top: -10,
                          right: -70,
                          child: Image.asset(
                            "lib/assets/png/saleimage.png",
                            height: 170,
                          ))
                    ],
                  ),
                   c.read<HomeMainCubit>().categories.isNotEmpty?Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.25,
                      child: GridView.builder(
                          itemCount: c.read<HomeMainCubit>().categories.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              childAspectRatio: 1.5,
                              mainAxisSpacing: 15),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoryDetails(categoryId: "${c.read<HomeMainCubit>().categories[index].categorieID}",currentUser: c.read<HomeMainCubit>().user,)));
                              },
                              child: CircleAvatar(
                                backgroundColor: Theme.of(context).colorScheme.secondary,
                                child: Image.network(
                                  "${c.read<HomeMainCubit>().categories[index].categorieImg}",
                                  height: 40,
                                ),
                              ),
                            );
                          }),
                    ),
                  ) :const Center(child: CircularProgressIndicator()),
                   Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Center(
                      child: Text(
                        "newArrive".tr(),
                        style: const TextStyle(fontSize: 22),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width,
                    child: CarouselSlider(
                      options: CarouselOptions(
                          aspectRatio: 1, autoPlay: true, enlargeCenterPage: true),
                      items: imageSliders,
                    ),
                  ),
                   Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Center(
                      child: Text(
                        "topRated".tr(),
                        style: const TextStyle(fontSize: 22),
                      ),
                    ),
                  ),
                  state is HomeMainSuccessState ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: (c.read<HomeMainCubit>().topRated.length/2).ceil(),
                        itemBuilder: (BuildContext context, int index){
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width*0.45,
                                    height: index%2==0 ? MediaQuery.of(context).size.height*0.40:MediaQuery.of(context).size.height*0.35,
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(Radius.circular(5)),
                                        color: Colors.grey.shade200,
                                        image:  DecorationImage(
                                          image: NetworkImage("${c.read<HomeMainCubit>().topRated[index].itemImage![0]}"),
                                          fit: BoxFit.fitHeight,
                                        )
                                    ),
                                  ),
                                  const SizedBox(height: 10,),
                                   Text("${c.read<HomeMainCubit>().topRated[index].itemPrice} ${"jod".tr()}",style: const TextStyle(fontSize: 20),)
                                ],
                              ),
                              const SizedBox(width: 10,),
                              (c.read<HomeMainCubit>().topRated.length/2).ceil()==index && c.read<HomeMainCubit>().topRated.length%2 != 0 ? Container(): Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width*0.45,
                                    height: index%2==0 ? MediaQuery.of(context).size.height*0.35:MediaQuery.of(context).size.height*0.40,
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(Radius.circular(5)),
                                        color: Colors.grey.shade200,
                                        image:  DecorationImage(
                                          image: NetworkImage("${c.read<HomeMainCubit>().topRated[c.read<HomeMainCubit>().topRated.length-1-index].itemImage![0]}"),
                                          fit: BoxFit.fitHeight,
                                        )
                                    ),
                                  ),
                                  const SizedBox(height: 10,),
                                   Text("${c.read<HomeMainCubit>().topRated[c.read<HomeMainCubit>().topRated.length-1-index].itemPrice} ${"jod".tr()}",style: const TextStyle(fontSize: 20),)
                                ],
                              ),
                            ],
                          );
                        }

                    ),
                  ):const Center(child: CircularProgressIndicator(),),
                ],
              )),
        );
      },
    );
  }
}
