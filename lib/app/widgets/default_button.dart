import 'package:flutter/material.dart';
import '/core/values/constant.dart';
import '/core/utils/size_config.dart';

class DefaultButton extends Container {
  final String? text;
  final callback;
  final IconData? icon;
  DefaultButton({
    super.key,
    this.text,
    this.callback,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: getProportionateScreenHeight(56),
      child: ElevatedButton.icon(
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateColor.resolveWith((states) => kPrimaryColor),
              shadowColor:
                  MaterialStateColor.resolveWith((states) => Colors.black),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: const BorderSide(color: kPrimaryColor),
              ))),
          icon: Icon(icon),
          label: Text(
            text!,
            style: TextStyle(
                fontSize: getProportionateScreenWidth(18), color: Colors.white),
          ),
          onPressed: () => callback()),
    );
  }
}
