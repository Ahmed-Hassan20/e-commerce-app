import 'package:e_commerce/utils/my_theme.dart';
import 'package:flutter/material.dart';

class TextFieldItem extends StatelessWidget {
  String label;
  String hintText;
  Widget? suffixIcon;
  var keyboardtype;
  bool isObsecure;
  TextEditingController controller;
  String? Function(String?) validator;
  TextFieldItem(
      {required this.label,
      required this.hintText,
      this.suffixIcon,
      this.keyboardtype = TextInputType.text,
      this.isObsecure = false,
      required this.controller,
      required this.validator});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          fillColor: mytheme.white,
            suffixIcon:suffixIcon ,
            label: Text(
              label,
              style: TextStyle(color: mytheme.white),
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: mytheme.white, width: 2))),
        keyboardType: keyboardtype,
        obscureText: isObsecure,
        validator: validator,
        
      ),
    );
  }
}
