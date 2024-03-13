import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TaskTextField extends StatelessWidget {
  TaskTextField({super.key, TextEditingController? controller});
  TextEditingController? controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
    );
  }
}
