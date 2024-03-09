import 'package:flutter/material.dart';
import 'package:keyboard_sticky/keyboard_sticky.dart';

class OnlyOriginalExample extends StatefulWidget {
  const OnlyOriginalExample({super.key});

  @override
  State<OnlyOriginalExample> createState() => _OnlyOriginalExampleState();
}

class _OnlyOriginalExampleState extends State<OnlyOriginalExample> {
  final TextEditingController _controllerForOriginal = TextEditingController();

  @override
  void dispose() {
    _controllerForOriginal.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardSticky.single(
      controller: _controllerForOriginal,
      builder: (context, controller, field) {
        return Material(
          elevation: 4,
          child: field,
        );
      },
      fieldBuilder: (context, controller, focusNode) {
        return TextField(
          controller: controller,
          focusNode: focusNode,
          onTapOutside: (_) {
            focusNode.unfocus();
          },
          decoration: const InputDecoration(
            labelText: "Text sent to floating widget",
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 2,
              ),
            ),
          ),
        );
      },
      floatingBuilder: (context, controller, field) {
        return InputDecorator(
          decoration: const InputDecoration(
            labelText: "Text from original text field",
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red,
                width: 2,
              ),
            ),
          ),
          child: ListenableBuilder(
            listenable: _controllerForOriginal,
            builder: (_, __) => Text(_controllerForOriginal.text),
          ),
        );
      },
    );
  }
}
