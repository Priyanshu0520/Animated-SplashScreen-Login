import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:gif/gif.dart';
import 'package:healtcare_ai/feature/splashscreen/widgets/login_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _fastController;
  late AnimationController _finalController;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _imageAnimation;
  late Animation<Alignment> _alignmentAnimation;
  late Animation<Alignment> _fastAlignmentAnimation;
  late Animation<Offset> _finalOffsetAnimation;
  late Animation<double> _finalScaleAnimation;
  final  _passwordController = TextEditingController();
  late GifController _gifController;
  late Animation<Offset> _finalOffsetAnimationTxt;
  late Animation<double> _finalScaleAnimationTxt;

  bool _isHeadingInPlace = false;
  bool _hasStartedGif = false;


  @override
  void initState() {
    super.initState();
    _passwordController.addListener(() {
      setState(() {});
    });
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _fastController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _finalController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _gifController = GifController(vsync: this);

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _imageAnimation =
        Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _alignmentAnimation = Tween<Alignment>(
      begin: const Alignment(0.0, 1.0),
      end: const Alignment(0.0, 0.0),
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _fastAlignmentAnimation = Tween<Alignment>(
      begin: const Alignment(0.0, 1.0),
      end: const Alignment(0.0, 0.2),
    ).animate(
      CurvedAnimation(parent: _fastController, curve: Curves.easeInOut),
    );

    _finalOffsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0.0, -4.5),
    ).animate(
      CurvedAnimation(parent: _finalController, curve: Curves.easeInOut),
    );

    _finalScaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.5,
    ).animate(
      CurvedAnimation(parent: _finalController, curve: Curves.easeInOut),
    );
    _finalOffsetAnimationTxt = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0.0, -11.5),
    ).animate(
      CurvedAnimation(parent: _finalController, curve: Curves.easeInOut),
    );

    _finalScaleAnimationTxt = Tween<double>(
      begin: 3,
      end: 1,
    ).animate(
      CurvedAnimation(parent: _finalController, curve: Curves.easeInOut),
    );

    _controller.forward().then((value) {
      setState(() {
        _isHeadingInPlace = true;
        _fastController.forward();
      });
      if (!_hasStartedGif) {
        _gifController.reset();
        _gifController.forward();
        _hasStartedGif = true;
      }
    }).then((_) async {
      // Add a 3-second delay before starting the final animation

      await Future.delayed(const Duration(seconds: 2));
      _finalController.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _fastController.dispose();
    _finalController.dispose();
    _gifController.dispose();
    super.dispose();
  }

  Widget buildAnimatedImage({
    required double top,
    double? right,
    double? left,
    double? width,
    double? height,
    bool useBlur = false,
  }) {
    return Positioned(
      top: top,
      right: right,
      left: left,
      width: width,
      height: height,
      child: SlideTransition(
        position: _imageAnimation,
        child: useBlur
            ? ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 20.0),
                  child: Image.asset(
                    'assets/images/blur.png',
                  ),
                ),
              )
            : Image.asset(
                'assets/images/blur.png',
              ),
      ),
    );
  }

  List<Widget> buildAllAnimatedImages() {
    final imagesConfig = [
      {'top': -300.0, 'left': -120.0, 'useBlur': true},
      {'top': -300.0, 'right': -230.0},
      {'top': 220.0, 'right': 70.0},
      {'top': 600.0, 'right': -100.0},
    ];

    return imagesConfig.map<Widget>((config) {
      return buildAnimatedImage(
        top: config['top'] as double,
        right: config['right'] as double?,
        left: config['left'] as double?,
        useBlur: config['useBlur'] as bool? ?? false,
      );
    }).toList();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          ...buildAllAnimatedImages(),
          Center(
            child: SizedBox(
              height: 160,
              width: 160,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: AnimatedBuilder(
                  animation: _finalController,
                  builder: (context, child) {
                    return Hero(
                      tag: 'logo',
                      child: Transform.scale(
                        scale: _finalScaleAnimation.value,
                        child: SlideTransition(
                          position: _finalOffsetAnimation,
                          child: Gif(
                            image: const AssetImage("assets/images/Logo.gif"),
                            controller: _gifController,
                            autostart: Autostart.no,
                            placeholder: (context) => const Text('Loading...'),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          // Animated text 'AAVAAZ'
          Align(
            alignment: _alignmentAnimation.value,
            child: AnimatedOpacity(
              opacity: _opacityAnimation.value,
              duration: const Duration(seconds: 1),
              child: Padding(
                padding: const EdgeInsets.only(top: 180),
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, 3),
                        end: const Offset(0, 0),
                      ).animate(_fastController),
                      child: Material(
                        color: Colors.transparent,
                        child: AnimatedBuilder(
                          animation: _finalController,
                          builder: (context, child) {
                            return SlideTransition(
                              position: _finalOffsetAnimationTxt,
                              child: Text(
                                'AAVAAZ',
                                style: TextStyle(
                                  fontSize: 20 * _finalScaleAnimationTxt.value,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 5,
                                  color: Colors.white.withOpacity(
                                    _opacityAnimation.value.clamp(0.1, 1.0),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          if (_isHeadingInPlace)
            AnimatedBuilder(
              animation: _fastController,
              builder: (context, child) {
                final finalOpacity =
                    Tween<double>(begin: 1.0, end: 0).animate(_finalController);
                return FadeTransition(
                  opacity: finalOpacity,
                  child: Align(
                    alignment: _fastAlignmentAnimation.value,
                    child: const Padding(
                      padding: EdgeInsets.only(top: 150),
                      child: Hero(
                        tag: 'subtitle',
                        child: Material(
                          color: Colors.transparent,
                          child: Text(
                            'Bringing the Patient’s Voice to Life',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),

          Positioned(
            left: 0,
            right: 0,
            bottom: 30,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 5),
                end: const Offset(0, -0.3),
              ).animate(_finalController),
              child: const LoginWidget()
            ),
          ),
        ],
      ),
    );
  }
}
