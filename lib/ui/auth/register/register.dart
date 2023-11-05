import 'package:e_commerce/data/repository/auth_repository/repository/auth_repository_Impl.dart';
import 'package:e_commerce/domain/use_case/register_use_case.dart';
import 'package:e_commerce/ui/auth/login/Login%20Screen.dart';
import 'package:e_commerce/ui/auth/register/cubit/register_screen_view_model.dart';
import 'package:e_commerce/ui/auth/register/cubit/register_states.dart';
import 'package:e_commerce/utils/TextFormField.dart';
import 'package:e_commerce/utils/dialog_utils.dart';
import 'package:e_commerce/utils/my_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterScreen extends StatefulWidget {
  static const String routename = "register";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  RegisterScreenViewModel viewmodel = RegisterScreenViewModel(
      registerUseCase:injectRegisterUseCase() );
  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterScreenViewModel, RegisterStates>(
      bloc: viewmodel,
      listener: (context, state) {
        if (state is RegisterLoadingState) {
          DialogUtils.showLoading(context, state.loadingMessage!);
        } else if (state is RegisterErrorState) {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(context, state.errorMessage!,
              posActionName: 'Ok',title: 'error');
        } else if (state is RegisterSuccessState) {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(context, state.response.userEntity?.name ?? '',
              posActionName: 'ok', title: 'success');
        }
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          color: mytheme.primarycolor,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 90.h, left: 97.h, right: 97.h),
                  child: Image.asset(
                    'assets/images/route.png',
                  ),
                ),
                Form(
                    key: viewmodel.formkey,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.08),
                          TextFieldItem(
                            label: 'Full Name',
                            controller: viewmodel.nameController,
                            validator: (text) {
                              if (text == null || text.trim().isEmpty) {
                                return 'Please Enter User Name';
                              }
                              return null;
                            },
                            hintText: '',
                          ),
                          TextFieldItem(
                            label: 'Email Address',
                            controller: viewmodel.emailController,
                            validator: (text) {
                              if (text == null || text.trim().isEmpty) {
                                return 'Please Enter Email Address';
                              }
                              bool emailValid = RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(text);
                              if (!emailValid) {
                                return 'Please Enter Valid Email';
                              }
                              return null;
                            },
                            hintText: '',
                          ),
                          TextFieldItem(
                            label: 'Password',
                            controller: viewmodel.passwordController,
                            isObsecure: viewmodel.isObscure,
                            keyboardtype: TextInputType.phone,
                            suffixIcon: InkWell(
                              child: viewmodel.isObscure
                                  ? Icon(
                                      Icons.visibility_off,
                                      color: Colors.white,
                                    )
                                  : Icon(
                                      Icons.visibility,
                                      color: Colors.white,
                                    ),
                              onTap: () {
                                if (viewmodel.isObscure) {
                                  viewmodel.isObscure = false;
                                } else {
                                  viewmodel.isObscure = true;
                                }
                                setState(() {});
                              },
                            ),
                            validator: (text) {
                              if (text == null || text.trim().isEmpty) {
                                return 'Please Enter Password';
                              }
                              if (text.length < 6) {
                                return 'Password should be at least 6 chars';
                              }
                              return null;
                            },
                            hintText: '',
                          ),
                          TextFieldItem(
                            label: 'Confirmation Password',
                            controller: viewmodel.confirmationController,
                            isObsecure: viewmodel.isObscure,
                            suffixIcon: InkWell(
                              child: viewmodel.isObscure
                                  ? Icon(
                                      Icons.visibility_off,
                                      color: Colors.white,
                                    )
                                  : Icon(
                                      Icons.visibility,
                                      color: Colors.white,
                                    ),
                              onTap: () {
                                if (viewmodel.isObscure) {
                                  viewmodel.isObscure = false;
                                } else {
                                  viewmodel.isObscure = true;
                                }
                                setState(() {});
                              },
                            ),
                            keyboardtype: TextInputType.phone,
                            validator: (text) {
                              if (text == null || text.trim().isEmpty) {
                                return 'Please Enter Confirmation Password';
                              }
                              if (text != viewmodel.passwordController.text) {
                                return "Password doesn't Match";
                              }
                              return null;
                            },
                            hintText: '',
                          ),
                          TextFieldItem(
                            label: 'Phone',
                            keyboardtype: TextInputType.phone,
                            controller: viewmodel.phoneController,
                            validator: (text) {
                              if (text == null || text.trim().isEmpty) {
                                return 'Enter phone number';
                              }
                              if (text.trim().length < 11) {
                                return 'Please enter correct phone number';
                              }
                              if (text.trim().length > 11) {
                                return 'Please enter correct phone number';
                              }
                              return null;
                            },
                            hintText: '',
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                                onPressed: () {
                                  viewmodel.register();
                                },
                                child: Text(
                                  'Register',
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                )),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Already have an account? ",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(color: mytheme.white),
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushNamed(LoginScreen.routename);
                                  },
                                  child: Text('SignIn',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(color: mytheme.white)))
                            ],
                          )
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> register() async {
    if (viewmodel.formkey.currentState!.validate() == true) {
      // dialogUtils.showLoading(context, 'Loading...');
      // try {
      //   final credential =
      //       await FirebaseAuth.instance.createUserWithEmailAndPassword(
      //     email: emailController.text,
      //     password: passwordController.text,
      //   );
      //   MyUser myUser = MyUser(
      //       id: credential.user?.uid,
      //       name: nameController.text,
      //       email: emailController.text);
      //   var authprovider = Provider.of<AuthProvider>(context, listen: false);
      //   authprovider.updateUser(myUser);
      //   await firebaseutils.addUsertofirebase(myUser);
      //   dialogUtils.hideLoading(context);
      //   dialogUtils.showMessage(
      //       context,
      //       title: 'Success',
      //       'Register Succeussfully',
      //       posActionName: 'Ok', posAction: () {
      //     Navigator.of(context).pushReplacementNamed(homescreen.routename);
      //   });
      // } on FirebaseAuthException catch (e) {
      //   String errorMessage = 'Something went wrong';
      //
      //   if (e.code == 'weak-password') {
      //     dialogUtils.hideLoading(context);
      //     errorMessage = 'The password provided is too weak.';
      //     dialogUtils.showMessage(context, errorMessage);
      //   } else if (e.code == 'email-already-in-use') {
      //     dialogUtils.hideLoading(context);
      //     errorMessage = 'The account already exists for that email.';
      //     dialogUtils.showMessage(context, errorMessage);
      //   }
      // } catch (e) {
      //   dialogUtils.hideLoading(context);
      //   dialogUtils.showMessage(context, e.toString());
      // }
    }
  }
}
