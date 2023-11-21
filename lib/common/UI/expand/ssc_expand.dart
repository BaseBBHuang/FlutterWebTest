import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SSCExpand extends StatefulWidget {
  /// 是否为展开
  bool expand;

  /// 子 Widget
  final Widget child;

  ///
  final Widget content;
  final Duration? expandTime;
  final Function? onTap;
  AnimationController? animationController;

  SSCExpand({
    super.key,
    this.expand = false,
    required this.child,
    required this.content,
    this.onTap,
    this.animationController,
    this.expandTime,
  });

  @override
  State<StatefulWidget> createState() => _SSCExpand();
}

class _SSCExpand extends State<SSCExpand> with SingleTickerProviderStateMixin {
  static final Animatable<double> _easeInTween =
      CurveTween(curve: Curves.easeIn);
  static final Animatable<double> _opacity =
      Tween<double>(begin: 0.0, end: 1.0);

  late AnimationController _controller;
  late Animation<double> _heightFactor;
  late Animation<double> _opacityFactor;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.expandTime ?? const Duration(milliseconds: 200),
      vsync: this,
    );

    _heightFactor = _controller.drive(_easeInTween);
    _opacityFactor = _controller.drive(_opacity);

    _isExpanded = widget.expand;

    if (_isExpanded) {
      _controller.value = 1.0;
      widget.animationController?.forward();
      _controller.forward();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller.view,
      builder: (context, child) {
        return _buildChildren(context, child);
      },
      child: Offstage(
        offstage: !_isExpanded && _controller.isCompleted,
        child: widget.child,
      ),
    );
  }

  Widget _buildChildren(BuildContext context, child) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: () {
            setState(
              () {
                _isExpanded = !_isExpanded;

                if (_isExpanded) {
                  widget.animationController?.forward();
                  _controller.forward();
                } else {
                  widget.animationController?.reverse().then<void>(
                    (void value) {
                      safeSate();
                    },
                  );

                  _controller.reverse().then<void>(
                    (void value) {
                      safeSate();
                    },
                  );
                }
              },
            );

            if (widget.onTap != null) {
              widget.onTap!();
            }
          },
          child: widget.content,
        ),
        Align(
          alignment: Alignment.center,
          heightFactor: _heightFactor.value,
          child: Opacity(
            opacity: _opacityFactor.value,
            child: child,
          ),
        ),
      ],
    );
  }

  void safeSate() {
    if (mounted) {
      setState(() {});
    }
  }
}
