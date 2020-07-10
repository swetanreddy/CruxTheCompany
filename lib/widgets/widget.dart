import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget appBarMain(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.amber,
    title: Title(color: Colors.white,
        child: Text("CRUX",
            style: GoogleFonts.poppins(
              fontSize: 40,
            )
        )
    ),
  );
}

InputDecoration textFieldInputDecoration(String hintText) {
  return InputDecoration(
    hintText: hintText,
    hintStyle: TextStyle(
      color: Colors.grey.shade800,
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.amber),
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.amber),
    ),
  );
}

TextStyle simpleTextFieldStyle() {
  return TextStyle(
    color: Colors.grey.shade800,
    fontSize: 16,
  );
}

// ignore: non_constant_identifier_names
TextStyle ButtonStyle() {
  return TextStyle(
    color: Colors.grey.shade800,
    fontSize: 18,
  );
}

