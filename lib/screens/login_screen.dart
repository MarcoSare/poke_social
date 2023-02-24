import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:poke_social/widgets/text_email_widget.dart';
import 'package:poke_social/widgets/text_pass_widget.dart';

import 'package:social_login_buttons/social_login_buttons.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  emailFormField email = emailFormField("Email", "Ingresa tu email", "Llene este campo");
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

  final btnForgotPass = TextButton(onPressed: (){},
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.zero,
                          child: Text("Forgot your password?", style: TextStyle(color: Colors.black), textAlign: TextAlign.right,)));

   
  

  @override
  Widget build(BuildContext context) {

       final btnSend = SocialLoginButton(
                    buttonType: SocialLoginButtonType.generalLogin,
                    onPressed: () {
                      Navigator.pushNamed(context, '/register');
                    },
                    mode: SocialLoginButtonMode.single,
                    borderRadius: 15,
                    backgroundColor: Theme.of(context).primaryColor,
                  );

      final rowBtnSocial = Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
            btnGoogle,
            btnFacebook,
            btnGitHub
        ]);

        final rowRegister = Row(
          
          children: [
            Text("Do you have an acount?"),
            Expanded(
              child:  TextButton(
              onPressed: (){}, 
              child: Text("Create your acount", style: TextStyle(color: Colors.red),)))
           
          ]); 

    return Scaffold(
      //appBar: AppBar(title: Text("Login")),
      body: Container(
        width: double.infinity,
        height: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
              image: AssetImage("assets/images/login_background.jpg"),
              fit: BoxFit.cover),
              ),
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
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
              margin: EdgeInsets.all(30)
              ),
             
              
        
             ClipRRect(
               borderRadius: BorderRadius.circular(30.0),
                child:  BackdropFilter(
                  filter:  ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                  child:  Container(
                    padding: EdgeInsets.fromLTRB(10, 50, 10, 10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(30)
                    ),
                    child: Column(children: [
                      const Text("Hello again!", style: TextStyle(fontFamily: 'Quicksand', fontSize: 16, fontWeight: FontWeight.bold),),
                      const Text("Welcome to the biggest pokemon family in the world", style: TextStyle(fontFamily: 'Quicksand', fontSize: 14, fontWeight: FontWeight.normal),textAlign: TextAlign.center,),
                      email,
                      pass,
                      btnForgotPass,
                      btnSend,
                      Text("Or continue with", style: TextStyle(fontFamily: 'Quicksand', fontSize: 14),),
                      rowBtnSocial,
                      rowRegister
                    ]),
                  ),),),
        
        
                  
          ]),
        ),

      ),
    );
  }
}


