
import 'package:easy_localization/easy_localization.dart';
import 'package:final_project/AppScreens/HomeScreens/HomeTabs/Home.dart';
import 'package:final_project/AppScreens/HomeScreens/HomeMain.dart';
import 'package:final_project/AppScreens/SignupScreens/Signup.dart';
import 'package:final_project/StateManagemnt/Signin/cubit.dart';
import 'package:final_project/StateManagemnt/Signin/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 20),
          child:  BlocProvider(
            create: (context)=>SignInCubit(),
            child: BlocConsumer<SignInCubit,SignInStates>(
              builder: (context,state){
                if(state is SignInLoadingState){
                  return Center(child: CircularProgressIndicator(),);
                }
                else {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "lib/assets/png/LogoClassyCloset.png",
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.13,
                    ),
                    Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          "welcome".tr(),
                          style: Theme.of(context).textTheme.titleLarge,
                        )),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          "login".tr(),
                          style: Theme.of(context).textTheme.titleMedium,
                        )),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    TextField(
                      controller: emailController,
                      style: Theme.of(context).textTheme.bodySmall,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        hintText: "email".tr(),
                        hintStyle: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    TextField(
                      obscureText: true,
                      controller: passwordController,
                      style: Theme.of(context).textTheme.bodySmall,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        hintText: "password".tr(),
                        hintStyle: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Align(
                        alignment: Alignment.bottomRight,
                        child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignupPage()));
                            },
                            child: Text(
                              "noAccount".tr(),
                              style: Theme.of(context).textTheme.bodySmall,
                            ))),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    InkWell(
                      onTap: (){
                        context.read<SignInCubit>().signIn(emailController.text.trim(), passwordController.text.trim());
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
                          "login2".tr(),
                          style: Theme.of(context).textTheme.labelMedium,
                        )),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    Text("or".tr(), style: Theme.of(context).textTheme.bodySmall),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "lib/assets/png/googleIcon.png",
                          width: 40,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.1,
                        ),
                        Image.asset(
                          "lib/assets/png/facebook.png",
                          width: 40,
                        ),
                      ],
                    )
                  ],
                ),
              );
            }
          },
              listener: (context,state){
                if(state is SignInSuccessState){
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomeMain(id: state.Id!,selectedIndex: 1,)), (route) => false);
                }
              },
            ),
          ),
        )
        )
      );
  }
}

