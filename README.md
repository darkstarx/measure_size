# measure_size

A stateful widget that measures the size of a child widget immediately after it is rendered.

__CAUTION__: Does not work with `PreferredSizeWidget`

```dart
MeasureSize(
    onSizeChange: (newSize) {
        /// [newSize] will be the displayed size of [Widget child]
    },
    onSizeUnchanged: () {
        /// Fired whenever the widget is rendered with the previous size.
    }
    child: Text('Lorem ipsum dolor sit amet'),
);
```

## `MeasureSize`

#### __Required__
- **`Widget child`** - This widget will be displayed and measured.

#### __Optional__
- **`void onSizeChange(Size newSize)`** - A callback fired every time after rendering when the size of the [child] becomes known or changes.

#### __Optional__
- **`void onSizeUnchange()`** - A callback fired every time after rendering the [child] if it's size remains the same.
