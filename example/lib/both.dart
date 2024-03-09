import 'package:flutter/material.dart';
import 'package:keyboard_sticky/keyboard_sticky.dart';

class BothFieldsExample extends StatelessWidget {
  const BothFieldsExample({super.key});

  @override
  Widget build(BuildContext context) {
    return KeyboardSticky.both(
      builder: (_, controller, field) {
        return Material(
          elevation: 4,
          child: field,
        );
      },
      fieldBuilder: (inner, controller, focusNode) {
        return TextField(
          controller: controller,
          focusNode: focusNode,
          onTapOutside: (_) {
            focusNode.unfocus();
          },
          decoration: const InputDecoration(
            labelText: "Text sync between both fields",
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 2,
              ),
            ),
          ),
        );
      },
      floatingFieldBuilder: (inner, controller, focusNode) {
        return TextField(
          controller: controller,
          focusNode: focusNode,
          onTapOutside: (_) {
            focusNode.unfocus();
          },
          decoration: const InputDecoration(
            labelText: "Text sync between both fields",
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red,
                width: 2,
              ),
            ),
          ),
        );
      },
    );
  }
}
