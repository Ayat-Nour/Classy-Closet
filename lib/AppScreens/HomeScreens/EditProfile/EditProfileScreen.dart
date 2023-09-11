import 'package:easy_localization/easy_localization.dart';
import 'package:final_project/StateManagemnt/EditProfile/cubit.dart';
import 'package:final_project/StateManagemnt/EditProfile/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title:  Text("settings".tr(),style: Theme.of(context).appBarTheme.titleTextStyle),
        elevation: 0,
         leading: InkWell(
             onTap: (){
               Navigator.pop(context);
             },
             child:  Icon(Icons.arrow_back,color:  Theme.of(context).appBarTheme.iconTheme?.color,)),
      ),
      body: SafeArea(
        child: BlocConsumer<EditProfileCubit,EditProfileStates>(
          listener: (c,state){},
          builder: (c,state){
            return ListView(
              children:  [
                const SizedBox(height: 15,),
                Container(
                  width: MediaQuery.of(context).size.width,
                  color: Theme.of(context).colorScheme.background,
                  child: Column(
                    children:  [
                       ListTile(
                         onTap: (){

                           EasyLocalization.of(context)!.currentLocale.toString()== "ar_DZ" ?  EasyLocalization.of(context)!.setLocale(const Locale('en','US')) : EasyLocalization.of(context)!.setLocale(const Locale('ar','DZ'));
                           print(EasyLocalization.of(context)!.currentLocale);
                         },
                        leading: const Icon(Icons.language_outlined),
                        title: Text("changeLang".tr(),style:Theme.of(context).textTheme.bodyMedium),
                      ),
                      const Divider(thickness: 2,),
                      InkWell(
                        onTap: (){
                          setState(() {
                            c.read<EditProfileCubit>().changeMode();
                          });
                        },
                        child:  ListTile(
                          leading: const Icon(Icons.dark_mode_outlined),
                          title: Text("changeMode".tr(),style: Theme.of(context).textTheme.bodyMedium,),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15,),
                Container(
                  width: MediaQuery.of(context).size.width,
                  color: Theme.of(context).colorScheme.background,
                  child: Column(
                    children:  [
                      ListTile(
                        leading: const Icon(Icons.edit_location_outlined),
                        title: Text("editAddress".tr(),style: Theme.of(context).textTheme.bodyMedium),
                      ),
                      const Divider(thickness: 2,),
                      ListTile(
                        leading: const Icon(Icons.edit_outlined),
                        title: Text("editPhone".tr(),style: Theme.of(context).textTheme.bodyMedium),
                      ),
                      const Divider(thickness: 2,),
                      ListTile(
                        leading: const Icon(Icons.person_outline),
                        title: Text("editPhoto".tr(),style:Theme.of(context).textTheme.bodyMedium),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15,),
                Container(
                  width: MediaQuery.of(context).size.width,
                  color: Theme.of(context).colorScheme.background,
                  child: Column(
                    children:  [
                      ListTile(
                        leading: const Icon(Icons.help_outline_outlined),
                        title: Text("helpCenter".tr(),style: Theme.of(context).textTheme.bodyMedium),
                      ),
                      const Divider(thickness: 2,),
                      ListTile(
                        leading: const Icon(Icons.info_outline),
                        title: Text("about".tr(),style: Theme.of(context).textTheme.bodyMedium),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15,),
                Container(
                  width: MediaQuery.of(context).size.width,
                  color: Theme.of(context).colorScheme.background,
                  child: Column(
                    children:  [
                      ListTile(
                        leading: const Icon(Icons.logout,color: Colors.red,),
                        title: Text("logout".tr(),style: const TextStyle(fontSize: 16,color: Colors.red),),
                      ),

                    ],
                  ),
                ),



              ],
            );
          },

        ),
      ),

    );
  }
}
