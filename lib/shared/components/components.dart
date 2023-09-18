import 'package:fasilah_m1/shared/styles/images.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import '../styles/colors.dart';
import '../styles/styles.dart';
import 'constants.dart';

// ignore: must_be_immutable
class ButtonTemplate extends StatelessWidget {
  ButtonTemplate({
    Key? key,
    required this.color,
    required this.text1,
    required this.onPressed,
    this.text2 = "",
    this.text3 = "",
    this.minwidth,
    this.fontSize = 18,
  }) : super(key: key);
  Color color;
  String text1;
  String text2;
  String text3;
  double? minwidth;
  double fontSize;
  void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: MaterialButton(
        minWidth: minwidth,
        height: 50,
        onPressed: onPressed,
        color: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: RichText(
            text: TextSpan(
                text: "",
                style: TextStyle(color: Colors.white, fontSize: fontSize),
                children: [
              TextSpan(text: text1, style: AppTextStyles.button),
              TextSpan(text: text2),
              TextSpan(
                  text: text3,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            ])),
      ),
    );
  }
}

// ignore: must_be_immutable
class SmallButtonTemplate extends StatelessWidget {
  SmallButtonTemplate({
    Key? key,
    required this.color,
    required this.text1,
    required this.onPressed,
    this.text2 = "",
    this.text3 = "",
    this.minwidth,
    this.minHeight,
    this.fontSize = 18,
  }) : super(key: key);
  Color color;
  String text1;
  String text2;
  String text3;
  double? minwidth;
  double? minHeight;
  double fontSize;
  void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: MaterialButton(
        minWidth: minwidth,
        height: minHeight,
        onPressed: onPressed,
        color: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: RichText(
            text: TextSpan(
                text: "",
                style: TextStyle(color: Colors.white, fontSize: fontSize),
                children: [
              TextSpan(text: text1, style: AppTextStyles.button),
              TextSpan(text: text2),
              TextSpan(
                  text: text3,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            ])),
      ),
    );
  }
}

// ignore: must_be_immutable
class TextFieldTemplate extends StatelessWidget {
  TextFieldTemplate(
      {Key? key,
      required this.hintText,
      required this.labelText,
      this.controller,
      this.obscureText = false,
      this.readOnly = false,
      this.validator,
      this.icon,
      this.keyType,
      this.lines})
      : super(key: key);

  String hintText;
  String labelText;
  TextEditingController? controller;
  bool obscureText;
  Function? validator;
  IconData? icon;
  int? lines;
  TextInputType? keyType;
  bool readOnly;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextButton.icon(
            label: Text(labelText,
                style: GoogleFonts.tajawal(
                    fontSize: 18,
                    color: AppColors.black,
                    fontWeight: FontWeight.w600)),
            icon: Icon(
              icon!,
              color: AppColors.black,
              size: 20,
            ),
            onPressed: null,
          ),
          TextFormField(
            obscureText: obscureText,
            maxLines: lines,
            controller: controller,
            validator: (value) => validator!(value),
            keyboardType: keyType,
            readOnly: readOnly,
            decoration: InputDecoration(
                hintText: hintText,
                border: InputBorder.none,
                filled: true,
                fillColor: AppColors.white2,
                hintStyle:
                    const TextStyle(color: AppColors.greyDark, fontSize: 15),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.grey, width: 1.5),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.grey, width: 1.5),
                ),
                errorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.grey, width: 1.5),
                ),
                disabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.grey, width: 1.5),
                )),
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class ItemBox extends StatelessWidget {
  String? text;
  void Function()? onPressed;
  String? icon;
  bool? uploaded = false;

  ItemBox(
      {required this.onPressed,
      required this.text,
      required this.icon,
      this.uploaded,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height(context, 11),
      width: width(context, 1),
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
          color: AppColors.white2,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: AppColors.green, width: 1.5),
          boxShadow: const [
            BoxShadow(
                color: AppColors.lightGrey, blurRadius: 1, spreadRadius: 1)
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text!,
            style: AppTextStyles.name,
          ),
          IconButton(
              onPressed: onPressed,
              icon: uploaded == true
                  ? const ImageIcon(AssetImage(certificate))
                  : ImageIcon(AssetImage(icon!)))
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class Box extends StatelessWidget {
  double? height;
  double? width;
  String? text;
  TextStyle? style;
  Color? color;
  AlignmentGeometry? dirction;

  Box(
      {this.color,
      this.style,
      this.width,
      this.height,
      this.text,
      this.dirction,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      alignment: dirction,
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      child: Text(
        text!,
        style: style,
      ),
    );
  }
}

// ignore: must_be_immutable
class DataItem extends StatelessWidget {
  String? image;
  String? text;
  TextStyle? textStyle;

  DataItem(
      {required this.text, required this.image, this.textStyle, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
      child: Row(
        children: [
          ImageIcon(
            AssetImage(image!),
            size: 20,
          ),
          const SizedBox(
            width: 15,
          ),
          Text(
            text!,
            style: textStyle,
          ),
        ],
      ),
    );
  }
}

showToast({
  required String text,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: chooseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0);

//enum (if there many choices)
enum ToastStates { success, error, warning }

Color? chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.success:
      color = Colors.green;
      break;
    case ToastStates.error:
      color = Colors.red;
      break;
    case ToastStates.warning:
      color = Colors.amber;
      break;
  }
  return color;
}

// ignore: must_be_immutable
class BackgroundBox extends StatelessWidget {
  Widget? widget;
  BackgroundBox({required this.widget, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          color: AppColors.lightGreen,
          alignment: Alignment.topCenter,
          height: MediaQuery.of(context).size.height,
          width: width(context, 1),
        ),
        Container(
            width: width(context, 1),
            height: MediaQuery.of(context).size.height / 1,
            decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20))),
            child: widget),
        // Expanded(child: NavigationFile()),
      ],
    );
  }
}
