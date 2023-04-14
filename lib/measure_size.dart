import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';


/// A stateful widget that measures the size of a child widget immediately after
/// it is rendered.
class MeasureSize extends StatefulWidget
{
  /// A [Widget] to be rendered and measured
  final Widget child;

  /// A callback fired every time after rendering when the size of the [child]
  /// becomes known or changes.
  final ValueChanged<Size>? onSizeChanged;

  /// A callback fired every time after rendering the [child] if it's size
  /// remains the same.
  final VoidCallback? onSizeUnchanged;

  const MeasureSize({
    super.key,
    required this.child,
    required this.onSizeChanged,
    this.onSizeUnchanged,
  });

  @override
  State<MeasureSize> createState() => _MeasureSizeState();
}


class _MeasureSizeState extends State<MeasureSize>
{
  final widgetKey = GlobalKey();

  Size? oldSize;

  @override
  Widget build(BuildContext context)
  {
    SchedulerBinding.instance.addPostFrameCallback(postFrameCallback);
    return Container(
      key: widgetKey,
      child: widget.child,
    );
  }

  void postFrameCallback(_)
  {
    final context = widgetKey.currentContext;
    if (context != null) {
      final newSize = context.size;
      if (newSize != null) {
        if (oldSize != newSize) {
          oldSize = newSize;
          widget.onSizeChanged?.call(newSize);
        } else {
          widget.onSizeUnchanged?.call();
        }
      }
    }
  }
}
