import 'package:flutter/material.dart';

import 'package:restroapp/constants/constants.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField(
      {Key? key,
      required this.textInputType,
      required this.hintText,
      this.isPass = false,
      required this.controller})
      : super(key: key);

  final TextInputType textInputType;
  final String hintText;
  final bool? isPass;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textCapitalization: TextCapitalization.sentences,
      controller: controller,
      style: kFormTextColor,
      obscureText: isPass!,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        isDense: true,
        hintText: hintText,
        hintStyle: kFormTextColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: (val) {
        if (val!.isEmpty) {
          return '$hintText should not be empty!!';
        }
        return null;
      },
    );
  }
}
