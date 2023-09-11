import 'package:easy_localization/easy_localization.dart';
import 'package:final_project/AppScreens/SignupScreens/SignupAddress.dart';
import 'package:final_project/StateManagemnt/Signup/cubit.dart';
import 'package:final_project/StateManagemnt/Signup/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocProvider(
          create: (context)=>SignupCubit(),
          child: BlocConsumer<SignupCubit,SignupStates>(
            listener: (context,state){
              if(state is SignupSuccessState){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupAddressPage(id: state.Id,)));
              }
            },
            builder: (context,state){
              if(state is SignupLoadingState){
                return const Center(child: CircularProgressIndicator(),);
             }
              else {
                return SingleChildScrollView(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
                          child: Column(

                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                "signup".tr(),
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height * 0.05,
                              ),
                              TextField(
                                controller: phoneController,
                                style: Theme.of(context).textTheme.bodySmall,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  hintText: "phoneNo".tr(),
                                  hintStyle: Theme.of(context).textTheme.bodySmall,
                                ),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height * 0.03,
                              ),
                              TextField(
                                controller: nameController,
                                style: Theme.of(context).textTheme.bodySmall,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  hintText: "name".tr(),
                                  hintStyle: Theme.of(context).textTheme.bodySmall,
                                ),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height * 0.03,
                              ),
                              TextField(
                                controller: emailController,
                                style: Theme.of(context).textTheme.bodySmall,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  hintText: "email".tr(),
                                  hintStyle: Theme.of(context).textTheme.bodySmall,
                                ),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height * 0.03,
                              ),
                              TextField(
                                controller: passwordController,
                                obscureText: true,
                                style: Theme.of(context).textTheme.bodySmall,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  hintText: "password".tr(),
                                  hintStyle: Theme.of(context).textTheme.bodySmall,
                                ),
                              ),
                              Spacer(),
                              InkWell(
                                onTap: (){
                                  context.read<SignupCubit>().signUp(nameController.text, passwordController.text.trim(), emailController.text.trim(), phoneController.text.trim());
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
                                        "continue".tr(),
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
          ),
        ),
      ),
    );
  }
}
