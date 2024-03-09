import 'package:example/both.dart';
import 'package:example/only_floating.dart';
import 'package:example/only_original.dart';
import 'package:example/sticky_dropdown.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text("Keyboard Sticky Example"),
        ),
        body: const Padding(
          padding: EdgeInsets.all(15),
          child: AttachableTextFieldExample(),
        ),
      ),
    );
  }
}

class AttachableTextFieldExample extends StatelessWidget {
  const AttachableTextFieldExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Spacer(),
        Text("Text would be sent to the floating widget"),
        SizedBox(height: 5),
        OnlyOriginalExample(),
        SizedBox(height: 20),
        Text("Text would be sent back to the original widget"),
        SizedBox(height: 5),
        OnlyFloatingExample(),
        SizedBox(height: 20),
        Text("Text sync between both fields"),
        SizedBox(height: 5),
        BothFieldsExample(),
        SizedBox(height: 20),
        StickyDropdownExample(),
        SizedBox(height: 20),
        Text("Bottom placeholder"),
      ],
    );
  }
}
