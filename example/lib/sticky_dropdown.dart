import 'package:dropdown_overlay/dropdown_overlay.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_sticky/keyboard_sticky.dart';

class StickyDropdownExample extends StatefulWidget {
  const StickyDropdownExample({super.key});

  @override
  State<StickyDropdownExample> createState() => _StickyDropdownExampleState();
}

class _StickyDropdownExampleState extends State<StickyDropdownExample> {
  final DropdownController<String> _controller = DropdownController.single(
    items: List.generate(
      15,
      (i) => DropdownItem(value: "Item $i"),
    ),
  );

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardSticky.both(
      fieldBuilder: (context, controller, focusNode) {
        return TextField(
          controller: controller,
          focusNode: focusNode,
          onChanged: (value) {
            if (!_controller.isOpen) {
              _controller.open();
            }

            if (value.isEmpty) {
              _controller.restore();
            } else {
              _controller.search(
                value,
                matcher: (query, ele) => ele.contains(query),
              );
            }
          },
          decoration: const InputDecoration(
            labelText: "Sticky Dropdown",
            border: OutlineInputBorder(),
          ),
        );
      },
      builder: (context, _, field) {
        return SimpleDropdown<String>.list(
          ///! if enabled, the dropdown menu would first insert itself into the overlay,
          ///! consequently, it would effect the visibility calculation of the dropdown menu during resizing.
          ///! no effect if we o not need to resize the dropdown menu to avoid the bottom insets.
          enabled: false,
          controller: _controller,
          menuPosition: const DropdownMenuPosition(
            targetAnchor: Alignment.topLeft,
            anchor: Alignment.bottomLeft,
            offset: Offset(0, -5),
          ),
          menuConstraints: const BoxConstraints(
            maxHeight: 200,
          ),
          menuDecoration: BoxDecoration(
            color: Colors.yellow,
            border: Border.all(color: Colors.black12),
          ),
          builder: (_) => Material(
            elevation: 4,
            child: field,
          ),
          itemBuilder: (_, item) => GestureDetector(
            onTap: () {
              _controller.select(item.value);
              field?.controller?.text = item.value;
              field?.focusNode?.unfocus();
            },
            child: Card(
              margin: const EdgeInsets.all(8),
              color: item.selected ? Colors.green : Colors.grey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2),
              ),
              child: Text(item.value),
            ),
          ),
        );
      },
    );
  }
}
