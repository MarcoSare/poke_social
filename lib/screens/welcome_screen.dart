import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:poke_social/responsive.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  late PageController _pageController;
  int _pageIndex = 0;
  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Responsive(
        desktop: const DesktopLoginScreen(),
        tablet: MobileRegisterScreen(dataOnBoarding: dataOnBoarding(true)),
        mobile: MobileRegisterScreen(dataOnBoarding: dataOnBoarding(false)),
      ),
    );
  }

  Widget dataOnBoarding(bool isTablet) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Column(
          children: [
            Expanded(
              child: PageView.builder(
                  itemCount: demoData.length,
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _pageIndex = index;
                    });
                  },
                  itemBuilder: (context, index) => OnboardContent(
                      title: demoData[index].title,
                      descripcion: demoData[index].description,
                      image: demoData[index].image,
                      isTablet: isTablet)),
            ),
          ],
        ),
        Container(
            height: 100,
            width: 290,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                      "assets/images/pokemon_logo.png"), //fixe resolutions
                  fit: BoxFit.fill),
            ),
            margin: EdgeInsets.all(30)),
        Positioned(
            bottom: 0,
            child: Container(
              height: 250,
              width: MediaQuery.of(context).size.width,
              child: LottieBuilder.asset("assets/lotties/background_1.json",
                  fit: BoxFit.fill),
            )),
        Positioned(
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                padding: const EdgeInsets.only(right: 30, left: 30),
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    ...List.generate(
                        demoData.length,
                        ((index) => Padding(
                            padding: EdgeInsets.only(right: 5),
                            child: DotIndicator(
                                isActivate: index == _pageIndex)))),
                    Spacer(),
                    SizedBox(
                      width: 50,
                      height: 50,
                      child: ElevatedButton(
                          onPressed: () {
                            _pageController.nextPage(
                                duration: Duration(seconds: 1),
                                curve: Curves.decelerate);
                            if (_pageIndex == 2) {
                              Navigator.pushNamed(context, '/login');
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(),
                              primary: Theme.of(context).primaryColorDark),
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                          )),
                    ),
                  ],
                ),
              ),
            )),
      ],
    );
  }
}

class DotIndicator extends StatelessWidget {
  const DotIndicator({Key? key, this.isActivate = false}) : super(key: key);
  final bool isActivate;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(seconds: 1),
      height: isActivate ? 25 : 15,
      width: 5,
      decoration: BoxDecoration(
          color: isActivate ? Colors.white : Colors.white.withOpacity(0.4),
          borderRadius: BorderRadius.all(Radius.circular(12))),
    );
  }
}

class OnboardContent extends StatelessWidget {
  const OnboardContent(
      {Key? key,
      required this.title,
      required this.descripcion,
      required this.image,
      required this.isTablet})
      : super(key: key);
  final String title, descripcion, image;
  final bool isTablet;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.center,
          colors: [Colors.black, Colors.black26],
        )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Expanded(
                    flex: 3,
                    child: FadeInDown(
                      delay: Duration(microseconds: 700),
                      child: Text(
                        title,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: isTablet ? 38 : 30,
                            fontWeight: FontWeight.bold),
                      ),
                    )),
                Expanded(flex: 1, child: SizedBox())
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: FadeInLeftBig(
                    delay: Duration(microseconds: 700),
                    child: Text(
                      descripcion,
                      style: TextStyle(
                          color: Colors.white, fontSize: isTablet ? 24 : 18),
                    ),
                  ),
                ),
                Expanded(flex: 1, child: SizedBox())
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardContentDesktop extends StatelessWidget {
  const OnboardContentDesktop(
      {Key? key,
      required this.title,
      required this.descripcion,
      required this.image,
      required this.btnNext})
      : super(key: key);
  final String title, descripcion, image;
  final Widget btnNext;
/*
 Container(
            height: MediaQuery.of(context).size.width,
            width: 300,
            child: LottieBuilder.asset("assets/lotties/background_2.json",
                fit: BoxFit.fill),
          )
*/
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
      ),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  height: 150,
                  width: 400,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/pokemon_logo.png"),
                        fit: BoxFit.fill),
                  ),
                  margin: EdgeInsets.all(30)),
              const SizedBox(
                height: 70,
              ),
              Center(
                child: FadeInDown(
                  delay: Duration(microseconds: 700),
                  child: Text(
                    title,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 48,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: 500,
                padding: EdgeInsets.all(20),
                child: FadeInLeftBig(
                  delay: Duration(microseconds: 700),
                  child: Text(
                    descripcion,
                    style: TextStyle(color: Colors.white, fontSize: 28),
                  ),
                ),
              ),
              SizedBox(height: 20),
              btnNext,
            ],
          ),
          Positioned(
              bottom: 0,
              left: 0,
              child: Container(
                height: 200,
                width: MediaQuery.of(context).size.width / 2,
                child: LottieBuilder.asset("assets/lotties/background_2.json",
                    fit: BoxFit.fill),
              ))
        ],
      ),
    );
  }
}

class MobileRegisterScreen extends StatelessWidget {
  const MobileRegisterScreen({
    Key? key,
    required this.dataOnBoarding,
  }) : super(key: key);

  final Widget dataOnBoarding;
  @override
  Widget build(BuildContext context) {
    return dataOnBoarding;
  }
}

class DesktopLoginScreen extends StatefulWidget {
  const DesktopLoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<DesktopLoginScreen> createState() => _DesktopLoginScreenState();
}

class _DesktopLoginScreenState extends State<DesktopLoginScreen> {
  late PageController _pageController;
  int _pageIndex = 0;
  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final btnNext = Container(
      width: 70,
      height: 70,
      child: ElevatedButton(
          onPressed: () {
            _pageController.nextPage(
                duration: Duration(seconds: 1), curve: Curves.decelerate);
            if (_pageIndex == 2) {
              Navigator.pushNamed(context, '/login');
            }
          },
          style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              primary: Theme.of(context).primaryColorDark),
          child: Icon(
            Icons.arrow_forward_ios,
            color: Colors.white,
            size: 30,
          )),
    );
    return Container(
      child: PageView.builder(
          itemCount: demoDataDesk.length,
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _pageIndex = index;
            });
          },
          itemBuilder: (context, index) => OnboardContentDesktop(
                title: demoDataDesk[index].title,
                descripcion: demoDataDesk[index].description,
                image: demoDataDesk[index].image,
                btnNext: btnNext,
              )),
    );
    /* 
    
    PageView.builder(
                  itemCount: demoData.length,
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _pageIndex = index;
                    });
                  },
                  itemBuilder: (context, index) => OnboardContent(
                        title: demoData[index].title,
                        descripcion: demoData[index].description,
                        image: demoData[index].image,
                      )),
    */
  }
}

class Onboard {
  final String image, title, description;
  Onboard(
      {required this.image, required this.title, required this.description});
}

final List<Onboard> demoData = [
  Onboard(
      image: "assets/images/welcome_page_1.jpeg",
      title: "WELCOME TO OUR COMMUNITY",
      description:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua"),
  Onboard(
      image: "assets/images/welcome_page_2.jpeg",
      title: "enjoy the experience",
      description:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua"),
  Onboard(
      image: "assets/images/welcome_page_3.jpeg",
      title: "WELCOME TO OUR COMMUNITY x3",
      description:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua")
];

final List<Onboard> demoDataDesk = [
  Onboard(
      image: "assets/images/welcome_page_desktop_1.jpeg",
      title: "WELCOME TO OUR COMMUNITY",
      description:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua"),
  Onboard(
      image: "assets/images/welcome_page_desktop_2.jpeg",
      title: "enjoy the experience",
      description:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua"),
  Onboard(
      image: "assets/images/welcome_page_desktop_3.jpeg",
      title: "WELCOME TO OUR COMMUNITY x3",
      description:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua")
];


/*
const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 50,
                width: 100,
                decoration: BoxDecoration(color: Colors.red),
              ),
              SizedBox(
                width: 50,
                height: 50,
                child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        primary: Theme.of(context).primaryColorDark),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    )),
              )
            ],
          )
*/