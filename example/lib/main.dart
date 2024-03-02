import 'package:flutter/material.dart';
import 'package:keyboard_sticky/keyboard_sticky.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: const Text("Keyboard Sticky Example"),
        ),
        body: const AttachableTextFieldExample(),
      ),
    );
  }
}

class AttachableTextFieldExample extends StatefulWidget {
  const AttachableTextFieldExample({super.key});

  @override
  State<AttachableTextFieldExample> createState() =>
      _AttachableTextFieldExampleState();
}

class _AttachableTextFieldExampleState
    extends State<AttachableTextFieldExample> {
  final TextEditingController _controllerForOriginal = TextEditingController();
  final TextEditingController _controllerForFloating = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _controllerForOriginal.dispose();
    _controllerForFloating.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("Placeholder"),
        const Spacer(),
        KeyboardSticky.single(
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
                labelText: "Only original",
                border: OutlineInputBorder(),
              ),
            );
          },
          floatingBuilder: (context, controller, field) {
            return InputDecorator(
              decoration: const InputDecoration(
                labelText: "Floating for Single Original",
                border: OutlineInputBorder(),
              ),
              child: ListenableBuilder(
                listenable: _controllerForOriginal,
                builder: (_, __) => Text(_controllerForOriginal.text),
              ),
            );
          },
        ),
        const SizedBox(height: 20),
        KeyboardSticky.single(
          controller: _controllerForFloating,
          forFloating: true,
          builder: (context, controller, field) {
            return GestureDetector(
              onTap: () {
                if (!controller.visible) {
                  controller.showFloating();
                }
              },
              child: InputDecorator(
                decoration: const InputDecoration(
                  labelText: "Original for Single Floating",
                  border: OutlineInputBorder(),
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
                labelText: "Only Floating",
                border: OutlineInputBorder(),
              ),
            );
          },
          floatingBuilder: (context, controller, field) {
            return field!;
          },
        ),
        const SizedBox(height: 20),
        KeyboardSticky.both(
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
                labelText: "Keyboard Sticky 2",
                border: OutlineInputBorder(),
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
                labelText: "Floating 2",
                border: OutlineInputBorder(),
              ),
            );
          },
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
