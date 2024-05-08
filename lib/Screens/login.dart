import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_app/Screens/homeBodt.dart';
import 'package:food_app/Screens/singup.dart';
import 'package:food_app/StateManagment/cubit/login_cubit.dart';
import 'package:food_app/constant.dart';
import 'package:food_app/holper.dart';
import 'package:food_app/widgets/customeButton.dart';
import 'package:get/get.dart';

class login extends StatelessWidget {
  login({super.key});
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  GlobalKey<FormState> form = new GlobalKey<FormState>();
  bool isLoading = false;
  bool visibality = true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
          child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            Get.back();
            Get.offAll(() => homeBody());
          } else if (state is LoginLoading)
            helper().Loading();
          else if (state is LoginFaluier) {
            Get.back();
            helper().error(error: state.error);
          }
        },
        builder: (context, state) {
          return Stack(children: [
            Container(
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Welcome again",
                      style:
                          Text_Style.splashFont.copyWith(color: Colors.white),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text("Let's login",
                        style: Text_Style.splashFont
                            .copyWith(color: Colors.white)),
                    SvgPicture.asset(
                      'assets/loginLogo.svg',
                      height: 150,
                    )
                  ],
                ),
              ),
              color: Colors.black,
              width: MediaQuery.sizeOf(context).width,
              height: 300,
            ),
            Container(
              margin: EdgeInsets.only(top: 280),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Form(
                  key: form,
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Center(
                              child: Text('Login Page',
                                  style: Text_Style.splashFont
                                      .copyWith(color: Colors.black))),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                                labelText: 'Email',
                                labelStyle: TextStyle(fontFamily: 'NotoSerif'),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                prefixIcon: Icon(
                                  Icons.email_outlined,
                                )),
                            controller: email,
                            validator: (val) {
                              if (val == '') {
                                return 'Required field';
                              }
                              if (val!.contains('@gmail.com') == false) {
                                return 'This email is not recognized';
                              }
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          BlocConsumer<LoginCubit, LoginState>(
                            listener: (context, state) {
                              if (state is UpdateVisablePass) {
                                visibality = state.visible;
                              }
                            },
                            builder: (context, state) {
                              return TextFormField(
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    labelText: 'Password',
                                    labelStyle:
                                        TextStyle(fontFamily: 'NotoSerif'),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        if (visibality == false)
                                          BlocProvider.of<LoginCubit>(context)
                                              .emit(UpdateVisablePass(
                                                  visible: true));
                                        else
                                          BlocProvider.of<LoginCubit>(context)
                                              .emit(UpdateVisablePass(
                                                  visible: false));
                                      },
                                      icon: visibality
                                          ? Icon(Icons.visibility)
                                          : Icon(Icons.visibility_off),
                                    )),
                                obscureText: visibality,
                                controller: pass,
                                validator: (txt) {
                                  if (txt == '') {
                                    return 'Required field';
                                  }
                                  if (txt!.length < 8) {
                                    return 'The password cannot be less than 8 letters';
                                  }
                                },
                              );
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '- - - - - - - - - - -',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              InkWell(
                                onTap: () {
                                  print('%%%%%%%%%%%%%');
                                  Get.to(() => singin());
                                },
                                child: Text(
                                  ' Sing Up ',
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 18,
                                      fontFamily: 'NotoSerif'),
                                ),
                              ),
                              Text(
                                '- - - - - - - - - - -',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          customeButton(
                            colortext: Colors.white,
                            title: 'Login',
                            colorBack: Colors.black,
                            onTap: () async {
                              print('###############');
                              if (form.currentState!.validate()) {
                                BlocProvider.of<LoginCubit>(context).LodIn(
                                    username: email.text, pass: pass.text);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  )),
            )
          ]);
        },
      )),
    );
  }
}
