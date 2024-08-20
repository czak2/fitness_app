import 'package:fitness_app/constants/onboard_data.dart';
import 'package:fitness_app/screens/authen_screen/phone_num_auth.dart';
import 'package:fitness_app/widgets/custom_button.dart';
import 'package:fitness_app/widgets/onboard.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../constants/constants.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late PageController pageController;
  bool isLastPage = false;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0);
  }

  void _onPageChanged(int pageIndex) {
    setState(() {
      isLastPage = pageIndex == dataOnboard.length - 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: Stack(
        children: [
          PageView.builder(
            controller: pageController,
            itemCount: dataOnboard.length,
            onPageChanged: _onPageChanged,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    colorFilter: const ColorFilter.mode(
                      Colors.black38,
                      BlendMode.darken,
                    ),
                    image: AssetImage(images1[index]),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    OnBoardWidget(
                      subtitle: dataOnboard[index].subtitle,
                      title: dataOnboard[index].title,
                    ),
                  ],
                ),
              );
            },
          ),
          Positioned(
            left: 10,
            bottom: 200,
            child: SmoothPageIndicator(
              controller: pageController,
              count: dataOnboard.length,
              effect: SlideEffect(
                activeDotColor: Color.fromRGBO(27, 88, 231, 1),
                dotHeight: 10,
                dotWidth: 20,
              ),
            ),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width / 4,
            bottom: 10,
            child: CustomButon(
              title: isLastPage ? "GET START" : "NEXT",
              onPressed: () {
                if (isLastPage) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VerifyPhone(),
                    ),
                  );
                } else {
                  pageController.nextPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInQuart,
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
