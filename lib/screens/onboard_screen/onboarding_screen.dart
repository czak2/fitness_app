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
    pageController = PageController(initialPage: 0);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List myList = Set.from(images1).toList();
    return Scaffold(
      backgroundColor: Colors.black12,
      body: Stack(
        children: [
          PageView.builder(
            allowImplicitScrolling: true,
            onPageChanged: (value) {
              setState(() {
                isLastPage = value == 3;
              });
            },
            controller: pageController,
            itemCount: dataOnboard.length,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        colorFilter: const ColorFilter.mode(
                            Colors.black38, BlendMode.darken),
                        image: AssetImage(images1[index]),
                        fit: BoxFit.cover)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    OnBoardWidget(
                        subtitle: dataOnboard[index].subtitle,
                        title: dataOnboard[index].title),
                    // SizedBox(
                    //   height: MediaQuery.of(context).size.height * 0.001,
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 10),
                    //   child: SmoothPageIndicator(
                    //       effect: const SlideEffect(
                    //         activeDotColor: Colors.blue,
                    //         dotHeight: 15,
                    //         dotWidth: 20,
                    //       ),
                    //       controller: pageController,
                    //       count: dataOnboard.length),
                    // ),
                    // SizedBox(
                    //   height: MediaQuery.of(context).size.height * 0.002,
                    // ),
                    // SizedBox(
                    //   width: double.infinity,
                    //   height: 150,
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       isLastPage
                    //           ? ElevatedButton(
                    //               style: ElevatedButton.styleFrom(
                    //                   shape: BeveledRectangleBorder(),
                    //                   minimumSize: Size(150, 70),
                    //                   backgroundColor: Colors.blue),
                    //               onPressed: () {
                    //                 Navigator.pushReplacement(context,
                    //                     MaterialPageRoute(
                    //                   builder: (context) {
                    //                     return VerifyPhone();
                    //                   },
                    //                 ));
                    //               },
                    //               child: const Text(
                    //                 "Get Start",
                    //                 style: TextStyle(
                    //                     fontSize: 18,
                    //                     fontWeight: FontWeight.bold,
                    //                     color: Colors.white),
                    //               ))
                    //           :
                    //           // Container(
                    //           //     child: CustomPaint(
                    //           //       size: Size(
                    //           //           200,
                    //           //           (200 * 0.625)
                    //           //               .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                    //           //       painter: RPSCustomPainter(),
                    //           //     ),
                    //           //   )
                    //           CustomButon(
                    //               title: "NEXT",
                    //               onPressed: () {
                    //                 Navigator.push(
                    //                     context,
                    //                     MaterialPageRoute(
                    //                       builder: (context) => VerifyPhone(),
                    //                     ));
                    //               },
                    //             )
                    //       // ElevatedButton(
                    //       //     style: ElevatedButton.styleFrom(
                    //       //         shape: BeveledRectangleBorder(),
                    //       //         minimumSize: Size(150, 70),
                    //       //         backgroundColor: Colors.blue),
                    //       //     onPressed: () {
                    //       //       pageController.nextPage(
                    //       //           duration: const Duration(milliseconds: 500),
                    //       //           curve: Curves.bounceIn);
                    //       //     },
                    //       //     child: const Text("Next",
                    //       //         style: TextStyle(
                    //       //             fontSize: 18,
                    //       //             color: Colors.white,
                    //       //             fontWeight: FontWeight.bold)))
                    //     ],
                    //   ),
                    // )
                  ],
                ),
              );
            },
          ),
          // Positioned(child: Container(
          //   child: Row(
          //     children: List.generate(images1.length, (index) => Container(
          //       height: 10,
          //     )),
          //   ),
          // )),
          Positioned(
            left: 10,
            bottom: 200,
            child: SmoothPageIndicator(
                effect: SlideEffect(
                  activeDotColor: Color.fromRGBO(27, 88, 231, 1),
                  dotHeight: 10,
                  dotWidth: 20,
                ),
                controller: pageController,
                count: dataOnboard.length),
          ),
          Positioned(
              left: MediaQuery.of(context).size.width / 4,
              bottom: 10,
              child: isLastPage
                  ? CustomButon(
                      title: "GET START",
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VerifyPhone(),
                            ));
                      })
                  : CustomButon(
                      title: "NEXT",
                      onPressed: () {
                        pageController.nextPage(
                            duration: Duration(milliseconds: 10),
                            curve: Curves.easeInQuart);
                      }))
        ],
      ),
    );
  }
}
