import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:final_project/AppScreens/HomeScreens/HomeTabs/Home.dart';
import 'package:final_project/AppScreens/HomeScreens/HomeMain.dart';
import 'package:final_project/StateManagemnt/Signup/cubit.dart';
import 'package:final_project/StateManagemnt/Signup/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupAddressPage extends StatefulWidget {
  final String ? id;
   const SignupAddressPage({Key? key,this.id}) : super(key: key);

  @override
  State<SignupAddressPage> createState() => _SignupAddressPageState();
}

class _SignupAddressPageState extends State<SignupAddressPage> {
  final List<String>? items = [
    "Jordan".tr(),
    "Egypt".tr(),
    "Syria".tr(),
    "Lebanon".tr(),
    "Saudi Arabia".tr(),
    "Iraq".tr(),
    "United Arab Emirates".tr(),
    "Qatar".tr(),
    "Palestine".tr(),
  ];
  String ?selectedValue;
  TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (context)=>SignupCubit(),
          child: BlocConsumer<SignupCubit,SignupStates>(
            builder: (context,state){
              if (state is SignupLoadingState){
                return const Center(child: CircularProgressIndicator());
              }
              else{
                return SingleChildScrollView(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
                      child: Column(
                        children: [
                          Text(
                            "signup2".tr(),
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                          ),
                          ButtonTheme(
                            alignedDropdown: true,
                            minWidth: MediaQuery.of(context).size.width,
                            child: DropdownButtonFormField2(
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  )),
                              hint: Text(
                                'country'.tr(),
                                style: Theme.of(context).textTheme.bodySmall,
                                overflow: TextOverflow.ellipsis,
                              ),
                              items: items!
                                  .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ))
                                  .toList(),
                              value: selectedValue,
                              onChanged: (value) {
                                setState(() {
                                  selectedValue = value as String;
                                  print(selectedValue);
                                });
                              },
                              buttonStyleData: ButtonStyleData(
                                height: MediaQuery.of(context).size.height * 0.08,
                                width: MediaQuery.of(context).size.width,
                                padding: const EdgeInsets.only(left: 5, right: 5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(
                                    color: Colors.black54,
                                  ),
                                  color: Colors.white,
                                ),
                                elevation: 0,
                              ),
                              iconStyleData:  const IconStyleData(
                                icon: Icon(
                                  Icons.keyboard_arrow_down_outlined,
                                ),
                                iconSize: 20,
                                iconEnabledColor: Colors.black,
                                iconDisabledColor: Colors.grey,
                              ),
                              dropdownStyleData: DropdownStyleData(
                                maxHeight: 200,
                                width: 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                ),
                                elevation: 8,
                                offset: const Offset(0, 0),
                                scrollbarTheme: ScrollbarThemeData(
                                  radius: const Radius.circular(40),
                                  thickness: MaterialStateProperty.all<double>(6),
                                  thumbVisibility: MaterialStateProperty.all<bool>(true),
                                ),
                              ),
                              menuItemStyleData: const MenuItemStyleData(
                                height: 40,
                                padding: EdgeInsets.only(left: 14, right: 14),
                              ),
                            ),
                          ),
                          TextField(
                            controller: addressController,
                            style: Theme.of(context).textTheme.bodySmall,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              hintText: "address1".tr(),
                              hintStyle: Theme.of(context).textTheme.bodySmall,
                            ),
                            maxLines: 5,
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: (){
                              print(selectedValue);
                              context.read<SignupCubit>().signUpAddress(selectedValue!, addressController.text.toString(), widget.id.toString());
                            },
                            child: Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Colors.pink,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                  child: Text(
                                    "letsGo".tr(),
                                    style: Theme.of(context).textTheme.labelMedium,
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
            },
            listener: (context,state){
              if(state is SignupSuccessState){
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomeMain(id: state.Id!,selectedIndex: 1,)), (route) => false);
              }            },
          ),
        ),
      ),

    );
  }
}
