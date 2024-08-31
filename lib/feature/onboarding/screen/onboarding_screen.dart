import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:healtcare_ai/feature/onboarding/model/item_model.dart';
import 'package:healtcare_ai/feature/onboarding/widgets/gradient_text.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final CarouselSliderController _carouselController =
      CarouselSliderController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
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
        child: ClipRect(
          child: Image.asset(
            'assets/images/blur.png',
            colorBlendMode: BlendMode.darken,
          ),
        ),
      );
    }

    List<Widget> buildAllAnimatedImages() {
      final imagesConfig = [
        {'top': -300.0, 'left': -120.0, 'useBlur': true},
        {'top': -300.0, 'left': -120.0, 'useBlur': true},
        {'top': -300.0, 'right': -230.0},
        {'top': -300.0, 'right': -230.0},
        {'top': 220.0, 'right': 10.0},
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

    final items = [
      CarouselItem(
          image: 'assets/images/img1.png',
          name: 'Accessible',
          description: 'Optimizing the Experience',
          scale: 50),
      CarouselItem(
          image: 'assets/images/img2.png',
          name: 'Accurate',
          description: 'Elevating Precision & Reliability',
          scale: 50),
      CarouselItem(
          image: 'assets/images/img3.png',
          name: 'Equitable',
          description: 'Redefining Patient Care',
          scale: 0),
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          ...buildAllAnimatedImages(),
          Center(
            child: CarouselSlider.builder(
              carouselController: _carouselController,
              itemCount: items.length,
              itemBuilder: (context, index, realIndex) {
                final item = items[index];
                return ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal:  20.0),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: RadialGradient(
                              colors: [
                                const Color.fromARGB(255, 145, 142, 142)
                                    .withOpacity(0.6),
                                const Color.fromARGB(255, 70, 81, 94)
                                    .withOpacity(0.6),
                                Colors.transparent.withOpacity(0.5),
                              ],
                              center: Alignment.center,
                              radius: 1.5,
                              stops: const [0.2, 0.4, 1.0],
                              focal: Alignment.topRight,
                              transform: const GradientRotation(30.5),
                            ),
                            border: Border.all(
                              color: const Color.fromARGB(255, 168, 168, 168),
                              width: 1,
                            ),
                            backgroundBlendMode: BlendMode.plus,
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 35.0),
                            child: GradientText(
                              item.name,
                              gradient: const LinearGradient(
                                colors: [
                                  Colors.white,
                                  Colors.grey,
                                ],
                                stops: [
                                  0.5,
                                  0.6,
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                              style: const TextStyle(
                                fontSize: 50,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal:  20.0),
                            child: GradientText(
                              item.description,
                              gradient: LinearGradient(
                                colors: [
                                  Colors.white,
                                  Colors.grey.shade300,
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                         Padding(
                           padding:  EdgeInsets.only(top: item.scale),
                           child: Image.asset(
                                  item.image,
                                ),
                         ),
                          const Spacer(),
                          Padding(
                            padding:  EdgeInsets.only(bottom: 50.0,top: item.scale),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                items.length,
                                (index) {
                                  bool isSelected = _currentPage == index;
                                  return GestureDetector(
                                    onTap: () {
                                      _carouselController.animateToPage(index);
                                    },
                                    child: AnimatedContainer(
                                      width: isSelected ? 25 : 10,
                                      height: 8,
                                      margin: EdgeInsets.symmetric(
                                          horizontal: isSelected ? 6 : 3),
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? Colors.grey.shade300
                                                .withOpacity(0.5)
                                            : Colors.grey.shade400
                                                .withOpacity(0.5),
                                        borderRadius: BorderRadius.circular(40),
                                      ),
                                      duration: const Duration(milliseconds: 300),
                                      curve: Curves.ease,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
              options: CarouselOptions(
                aspectRatio: 11 / 14,
                viewportFraction: 0.82,
                enableInfiniteScroll: true,
                autoPlay: false,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentPage = index;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

