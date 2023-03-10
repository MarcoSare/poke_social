import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:poke_social/responsive.dart';
import 'package:poke_social/widgets/text_email_widget.dart';
import 'package:poke_social/widgets/text_pass_widget.dart';

import 'package:social_login_buttons/social_login_buttons.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  emailFormField email =
      emailFormField("Email", "Ingresa tu email", "Llene este campo");
  textFieldPass pass = textFieldPass();
  final btnGoogle = SocialLoginButton(
    buttonType: SocialLoginButtonType.google,
    onPressed: () {},
    mode: SocialLoginButtonMode.single,
    borderRadius: 15,
    width: 77,
    text: "",
  );

  final btnFacebook = SocialLoginButton(
    buttonType: SocialLoginButtonType.facebook,
    onPressed: () {},
    mode: SocialLoginButtonMode.single,
    borderRadius: 15,
    width: 77,
    text: "",
  );

  final btnGitHub = SocialLoginButton(
    buttonType: SocialLoginButtonType.github,
    onPressed: () {},
    mode: SocialLoginButtonMode.single,
    borderRadius: 15,
    width: 77,
    text: "",
  );

  final btnForgotPass = TextButton(
      onPressed: () {},
      child: Container(
          width: double.infinity,
          padding: EdgeInsets.zero,
          child: const Text(
            "Forgot your password?",
            style: TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.right,
          )));

  @override
  Widget build(BuildContext context) {
    final btnSend = SocialLoginButton(
      buttonType: SocialLoginButtonType.generalLogin,
      onPressed: () {
        Navigator.pushNamed(context, '/dashBoard');
      },
      mode: SocialLoginButtonMode.single,
      borderRadius: 15,
      backgroundColor: Theme.of(context).primaryColor,
    );

    final rowBtnSocial = SizedBox(
      width: 250,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [btnGoogle, btnFacebook, btnGitHub]),
    );

    final rowRegister = Row(children: [
      const Text("Do you have an acount?"),
      Expanded(
          child: TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
              child: const Text(
                "Create your acount",
                style: TextStyle(fontWeight: FontWeight.bold),
              )))
    ]);

    return Scaffold(
      //appBar: AppBar(title: Text("Login")),
      body: Responsive(
        mobile: MobileLoginScreen(
          dataLogin:
              dataLogin(context, btnSend, rowBtnSocial, rowRegister, false),
        ),
        tablet: TabletLoginScreen(
            dataLogin:
                dataLogin(context, btnSend, rowBtnSocial, rowRegister, true)),
        desktop: DesktopLoginScreen(
          dataLogin:
              dataLogin(context, btnSend, rowBtnSocial, rowRegister, false),
        ),
      ),
    );
  }

  Widget dataLogin(BuildContext context, SocialLoginButton btnSend,
      SizedBox rowBtnSocial, Row rowRegister, bool isTablet) {
    // ignore: unused_local_variable
    double screenWidth = MediaQuery.of(context).size.width;
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              height: 100,
              width: 290,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/pokemon_logo.png"),
                    fit: BoxFit.fill),
              ),
              margin: EdgeInsets.all(30)),
          ClipRRect(
            borderRadius: BorderRadius.circular(30.0),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
              child: Container(
                padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                margin: isTablet
                    ? EdgeInsets.only(
                        left: screenWidth * 0.15, right: screenWidth * 0.15)
                    : EdgeInsets.all(0),
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(30)),
                child: Column(children: [
                  const Text(
                    "Hello again!",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Welcome to the biggest pokemon family in the world",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  email,
                  pass,
                  btnForgotPass,
                  btnSend,
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Or continue with",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                  ),
                  rowBtnSocial,
                  rowRegister
                ]),
              ),
            ),
          ),
        ]);
  }
}

class MobileLoginScreen extends StatelessWidget {
  const MobileLoginScreen({
    Key? key,
    required this.dataLogin,
  }) : super(key: key);

  final Widget dataLogin;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/login_background.jpg"),
            fit: BoxFit.cover),
      ),
      padding: EdgeInsets.all(20),
      child: SingleChildScrollView(child: dataLogin),
    );
  }
}

class TabletLoginScreen extends StatelessWidget {
  const TabletLoginScreen({
    Key? key,
    required this.dataLogin,
  }) : super(key: key);

  final Widget dataLogin;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/login_background.jpg"),
            fit: BoxFit.cover),
      ),
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(child: dataLogin),
    );
  }
}

class DesktopLoginScreen extends StatelessWidget {
  const DesktopLoginScreen({
    Key? key,
    required this.dataLogin,
  }) : super(key: key);

  final Widget dataLogin;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Container(
                decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/login_background.jpg"),
                  fit: BoxFit.cover),
            )),
          ),
          Expanded(
            flex: 1,
            child: Container(
              child: SingleChildScrollView(child: dataLogin),
            ),
          ),
        ],
      ),
    );
  }
}
