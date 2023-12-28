import 'package:flutter/material.dart';
import 'package:insurance_app/Model/intro_item_model.dart';
import 'package:insurance_app/Util/get_started_btn.dart';
import 'package:insurance_app/Util/skip_color.dart';
import 'package:insurance_app/View_Model/onboarding_provider.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});
  static String routeName = "On boarding Screen";

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController pageController = PageController();
  OnBoardingProvider onBoardingProvider = OnBoardingProvider();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //var textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: PageView.builder(
                  itemCount: listOfItems.length,
                  physics: BouncingScrollPhysics(),
                  controller: pageController,
                  onPageChanged: (newValue) {
                    context.read<OnBoardingProvider>().changeIndex(newValue);
                  },
                  itemBuilder: (ctx, index) {
                    return SizedBox(
                      width: size.width,
                      height: size.height,
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(15, 40, 15, 10),
                            width: size.width,
                            height: size.height / 2.5,
                            child: onBoardingProvider.animation(
                              index,
                              100,
                              Image.asset(listOfItems[index].img),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 20,
                              bottom: 15,
                            ),
                            child: onBoardingProvider.animation(
                              index,
                              300,
                              Text(
                                listOfItems[index].title,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          ),
                          onBoardingProvider.animation(
                            index,
                            500,
                            Text(
                              listOfItems[index].subTitle,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 26,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SmoothPageIndicator(
                      effect: ExpandingDotsEffect(
                        spacing: 6,
                        radius: 10,
                        dotWidth: 10,
                        dotHeight: 10,
                        dotColor: Colors.grey,
                        expansionFactor: 3.9,
                        activeDotColor: Color.fromARGB(255, 106, 153, 78),
                      ),
                      count: listOfItems.length,
                      controller: pageController,
                      onDotClicked: (newValue) {
                        onBoardingProvider.changeIndex(newValue);
                        pageController.animateToPage(
                          newValue,
                          duration: Duration(microseconds: 500),
                          curve: Curves.ease,
                        );
                      },
                    ),

                    //---------

                    context.watch<OnBoardingProvider>().currentIndex == 2
                        ? GetStartBtn(size: size)
                        : SkipBtn(
                            size: size,
                            onTap: () {
                              pageController.animateToPage(
                                2,
                                duration: Duration(milliseconds: 1000),
                                curve: Curves.fastOutSlowIn,
                              );
                            },
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
