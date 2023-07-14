import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';


/// The widget that measures the size of the child widget during building the
/// widget tree.
///
/// The [onSizeChanged] and [onSizeUnchanged] methods invoke during building
/// the widget tree, so be sure these callbacks don't invoke [State.setState]
/// method. If you need change the state, do it after drawing the frame using
/// [SchedulerBinding.addPostFrameCallback].
class SizeMeter extends SingleChildRenderObjectWidget
{
  /// The callback fired every time the size of the [child] becomes known or
  /// changes.
  final ValueChanged<Size>? onSizeChanged;

  /// The callback fired every time the [child] rebuilds with the same size.
  final VoidCallback? onSizeUnchanged;

  const SizeMeter({
    super.key,
    super.child,
    this.onSizeChanged,
    this.onSizeUnchanged,
  });

  @override
  RenderObject createRenderObject(final BuildContext context)
  {
    return SizeMeterRenderBox(
      onSizeChanged: onSizeChanged,
      onSizeUnchanged: onSizeUnchanged,
    );
  }

  @override
  void updateRenderObject(final BuildContext context,
    covariant SizeMeterRenderBox renderObject,
  )
  {
    renderObject
      ..onSizeChanged = onSizeChanged
      ..onSizeUnchanged = onSizeUnchanged
    ;
    super.updateRenderObject(context, renderObject);
  }
}


class SizeMeterRenderBox extends RenderProxyBox
{
  ValueChanged<Size>? onSizeChanged;
  VoidCallback? onSizeUnchanged;

  SizeMeterRenderBox({
    final RenderBox? child,
    this.onSizeChanged,
    this.onSizeUnchanged,
  })
  : super(child);

  @override
  void performLayout()
  {
    super.performLayout();
    if (_size == null || _size != size) {
      try {
        onSizeChanged?.call(size);
      } finally {
        _size = size;
      }
    } else {
      onSizeUnchanged?.call();
    }
  }

  Size? _size;
}
