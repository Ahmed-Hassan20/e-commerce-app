import 'package:e_commerce/domain/use_case/login_use_case.dart';
import 'package:e_commerce/ui/auth/login/cubit/login_screen_view_model.dart';
import 'package:e_commerce/ui/auth/login/cubit/login_states.dart';
import 'package:e_commerce/utils/TextFormField.dart';
import 'package:e_commerce/utils/dialog_utils.dart';
import 'package:e_commerce/utils/my_theme.dart';
import 'package:e_commerce/ui/auth/register/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatefulWidget {
  static const String routename = "login";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginScreenViewModel viewmodel =
      LoginScreenViewModel(loginUseCase: injectLoginUseCase());

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginScreenViewModel, LoginStates>(
      bloc: viewmodel,
      listener: (context, state) {
        if (state is LoginLoadingState) {
          DialogUtils.showLoading(context, state.loadingMessage!);
        } else if (state is LoginErrorState) {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(context, state.errorMessage!,
              posActionName: 'Ok', title: 'error');
        } else if (state is LoginSuccessState) {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(
              context, state.response.userEntity?.name ?? '',
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
                  padding: EdgeInsets.only(
                      top: 130.h, bottom: 46.h, left: 97.h, right: 97.h),
                  child: Image.asset(
                    'assets/images/route.png',
                  ),
                ),
                Text(
                  'Welcome Back to Route',
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  'Please Sign in with your e-mail',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Form(
                    key: viewmodel.formkey,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(
                              height: MediaQuery.of(context).size.height * 0.1),
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
                                return 'Please Enter Password';
                              }
                              if (text.length < 6) {
                                return 'Password should be at least 6 chars';
                              }
                              return null;
                            },
                            hintText: '',
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                                onPressed: () {
                                  viewmodel.login();
                                },
                                child: Text(
                                  'Login',
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                )),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.08,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account? ",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(color: mytheme.white),
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushNamed(RegisterScreen.routename);
                                  },
                                  child: Text('SignUp',
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
}
