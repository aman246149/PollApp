import 'package:flutter/material.dart';

showSnackbar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 2),
      content: Container(
        padding: EdgeInsets.all(10),
        color: Colors.red,
        child: Text(
          content,
          style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              shadows: [BoxShadow(blurRadius: 40, spreadRadius: 8)]),
        ),
      ),
    ),
  );
}


//input field from homepage

class CustomTextInputField extends StatelessWidget {
  const CustomTextInputField({
    Key? key,
    required this.questioncontroller,
    required this.hintText,
  }) : super(key: key);

  final TextEditingController questioncontroller;
  final String hintText;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: questioncontroller,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.white,
          )),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.white),
          fillColor: Colors.white),
    );
  }
}
