<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

A UI component allowing sticky widget on the top of soft keyboard.

## Features

> Only the soft keyboard is shown and the original widget is overlapped, the sticky widget will be shown.

> If no soft keyboard or the original widget is not overlapped, the sticky widget will not be shown.

- Sticky a floating `TextField` and syncing the text with the original `TextField`

    <div style="float:left">
      <img src="https://github.com/SimonWang9610/keyboard_sticky/blob/main/snapshots/both.gif" width=400>
    </div>

- Sticky a custom widget and syncing the text with the original `TextField`

    <div style="float:left">
      <img src="https://github.com/SimonWang9610/keyboard_sticky/blob/main/snapshots/only-original.gif" width=400>
    </div>

- Sticky a `TextField` and syncing its text with the original non-TextField widget

    <div style="float:left">
      <img src="https://github.com/SimonWang9610/keyboard_sticky/blob/main/snapshots/only-floating.gif" width=400>
    </div>

- Sticky a search bar on the top of the keyboard and syncing the selected item with the original widget/`TextField`

    <div style="float:left">
      <img src="https://github.com/SimonWang9610/keyboard_sticky/blob/main/snapshots/dropdown.gif" width=400>
    </div>

## Getting started

```dart
import 'package:keyboard_sticky/keyboard_sticky.dart';
```

## Usage

````dart

### Only Single `TextField`

```dart
  /// A shortcut to create a [KeyboardSticky] that only shows one [TextField] either in the original or floating widget.
  ///
  /// if [floating] is true, [fieldBuilder] will be used to build a [TextField] used by [builder];
  /// otherwise, [fieldBuilder] will be used to build a [TextField] used by [floatingBuilder].
  ///
  /// The original widget built from [builder] will be shown when the keyboard is not visible.
  /// The floating widget built from [floatingBuilder] will be shown when the keyboard is visible and the original widget is not visible.
  ///
  /// [controller] would be bound with [fieldBuilder] if provided.
  ///
  /// [focusNode] would be bound with [fieldBuilder] if provided and [floating] is false.
  ///
  /// [floatingFocusNode] would be bound with [floatingBuilder] if provided and [floating] is true.
  ///
  /// Please be sure to use the given [FocusNode] in the [TextField] built from [fieldBuilder],
  /// so as to listen to the focus changes and then show/hide the floating widget automatically.
  /// Through this way, you do not need to manage the floating widget manually via [KeyboardStickyController].
  KeyboardSticky.single({
    super.key,
    FocusNode? focusNode,
    TextEditingController? controller,
    FocusNode? floatingFocusNode,
    bool floating = false,
    this.useMaterial = true,
    required KeyboardStickyWrapperBuilder builder,
    required KeyboardStickyWrapperBuilder floatingBuilder,
    required KeyboardStickyFieldBuilder fieldBuilder,
  });
````

### Both `TextField`

```dart
  /// A shortcut to create a [KeyboardSticky] that shows two [TextField]s in both the original and floating widgets.
  ///
  /// If [floatingBuilder] is not provided, [builder] will also be used to build the floating widget.
  /// If [floatingFieldBuilder] is not provided, [fieldBuilder] will also be used to build the floating [TextField].
  ///
  /// The original/floating [TextField] should share the same [controller] so that they can share the same text value.
  /// Therefore, [controller] would be used by both [fieldBuilder] and [floatingFieldBuilder] if provided;
  /// otherwise, a default [TextEditingController] will be created for them.
  ///
  /// However, the two [TextField]s should have different [FocusNode]s so that they can be focused separately.
  /// Therefore, [focusNode] would be used by [fieldBuilder] if provided, while [floatingFocusNode] would be used by [floatingFieldBuilder] if provided.
  ///
  /// Please be sure to use the given [FocusNode] in the [TextField] built from [fieldBuilder]/[floatingFieldBuilder].
  KeyboardSticky.both({
    super.key,
    FocusNode? focusNode,
    TextEditingController? controller,
    FocusNode? floatingFocusNode,
    TextEditingController? floatingController,
    this.useMaterial = true,
    required KeyboardStickyWrapperBuilder builder,
    required KeyboardStickyFieldBuilder fieldBuilder,
    KeyboardStickyWrapperBuilder? floatingBuilder,
    KeyboardStickyFieldBuilder? floatingFieldBuilder,
  })
```

### `KeyboardStickyController`

```dart
/// [KeyboardStickyController] is a mixin class that provides the ability to show/hide the floating widget manually.
abstract mixin class KeyboardStickyController {
  /// whether the original widget is visible
  bool get visible;

  /// the current height of the keyboard
  double get keyboardHeight;

  /// show the floating widget manually
  void showFloating();

  /// hide the floating widget manually
  void hideFloating();
}
```
