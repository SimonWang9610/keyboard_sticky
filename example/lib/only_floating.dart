import 'package:flutter/material.dart';
import 'package:keyboard_sticky/keyboard_sticky.dart';

class OnlyFloatingExample extends StatefulWidget {
  const OnlyFloatingExample({super.key});

  @override
  State<OnlyFloatingExample> createState() => _OnlyFloatingExampleState();
}

class _OnlyFloatingExampleState extends State<OnlyFloatingExample> {
  final TextEditingController _controllerForFloating = TextEditingController();

  @override
  void dispose() {
    _controllerForFloating.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardSticky.single(
      floating: true,
      controller: _controllerForFloating,
      builder: (context, controller, field) {
        return GestureDetector(
          onTap: () {
            print("show floating");
            controller.showFloating();
          },
          child: InputDecorator(
            decoration: const InputDecoration(
              labelText: "Text from floating text field",
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black,
                  width: 2,
                ),
              ),
            ),
            child: ListenableBuilder(
              listenable: _controllerForFloating,
              builder: (_, __) => Text(_controllerForFloating.text),
            ),
          ),
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
            labelText: "Text sent to original widget",
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red,
                width: 2,
              ),
            ),
          ),
        );
      },
      floatingBuilder: (context, controller, field) {
        return field!;
      },
    );
  }
}
