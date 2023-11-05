import 'package:e_commerce/domain/repository/repository/auth_repository_contract.dart';
import 'package:e_commerce/domain/use_case/register_use_case.dart';
import 'package:e_commerce/ui/auth/register/cubit/register_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreenViewModel extends Cubit<RegisterStates> {
  RegisterScreenViewModel({required this.registerUseCase})
      : super(RegisterInitialState());
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmationController = TextEditingController();
  var phoneController = TextEditingController();
  var formkey = GlobalKey<FormState>();
  bool isObscure = true;
  RegisterUseCase registerUseCase ;

  void register() async {
    if (formkey.currentState?.validate() == true) {
      emit(RegisterLoadingState(loadingMessage: 'Loading'));
      var either = await registerUseCase.invoke(
          nameController.text,
          emailController.text,
          passwordController.text,
          confirmationController.text,
          phoneController.text);
      either.fold((l){
        emit(RegisterErrorState(errorMessage: l.errorMessage));
      }, (response){
        emit(RegisterSuccessState(response: response));
      });
    }
  }
}
