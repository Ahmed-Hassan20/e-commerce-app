import 'package:e_commerce/domain/use_case/register_use_case.dart';
import 'package:e_commerce/ui/auth/register/cubit/register_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/use_case/login_use_case.dart';
import 'login_states.dart';

class LoginScreenViewModel extends Cubit<LoginStates> {
  LoginScreenViewModel({required this.loginUseCase})
      : super(LoginInitialState());
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formkey = GlobalKey<FormState>();
  bool isObscure = true;
  LoginUseCase loginUseCase ;

  void login() async {
    if (formkey.currentState?.validate() == true) {
      emit(LoginLoadingState(loadingMessage: 'Loading'));
      var either = await loginUseCase.invoke(
          emailController.text,
          passwordController.text,
         );
      either.fold((l){
        emit(LoginErrorState(errorMessage: l.errorMessage));
      }, (response){
        emit(LoginSuccessState(response: response));
      });
    }
  }
}
