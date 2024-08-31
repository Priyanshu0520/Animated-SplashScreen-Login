import 'package:flutter/material.dart';

class AnimatedImage extends StatelessWidget {
  final double top;
  final double? right;
  final double? left;
  final bool useBlur;

  const AnimatedImage({
    Key? key,
    required this.top,
    this.right,
    this.left,
    this.useBlur = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      right: right,
      left: left,
      child: ClipRect(
        child: Image.asset(
          'assets/images/blur.png',
          colorBlendMode: useBlur ? BlendMode.darken : BlendMode.srcOver,
        ),
      ),
    );
  }
}
