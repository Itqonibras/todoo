import 'package:flutter/material.dart';

const InputDecoration commonInputDecoration = InputDecoration(
  filled: true,
  fillColor: Color(0xFFE6E6E6),
  contentPadding: EdgeInsets.all(12),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.transparent,
    ),
    borderRadius: BorderRadius.all(Radius.circular(15)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Color(0xFF5038BC),
    ),
    borderRadius: BorderRadius.all(Radius.circular(15)),
  ),
  disabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.transparent,
    ),
    borderRadius: BorderRadius.all(Radius.circular(15)),
  ),
);