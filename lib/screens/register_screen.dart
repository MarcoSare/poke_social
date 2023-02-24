import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:poke_social/widgets/text_email_widget.dart';
import 'package:poke_social/widgets/text_form_widget.dart';
import 'package:poke_social/widgets/text_pass_widget.dart';

import 'package:social_login_buttons/social_login_buttons.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  textFormField firstName = textFormField("First name", "Enter your first name",
      "Enter your first name", Icons.account_box, 1, 50);
  textFormField lastName = textFormField("Last name", "Enter your last name",
      "Enter your last name", Icons.account_box, 1, 50);
  emailFormField email =
      emailFormField("Email", "Ingresa tu email", "Llene este campo");
  textFieldPass pass = textFieldPass();
  final ImagePicker _picker = ImagePicker();
  var image_selected;
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
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/register_background.jpg"),
              fit: BoxFit.cover),
        ),
        padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
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
                    margin: EdgeInsets.all(30)),
                ClipRRect(
                  borderRadius: BorderRadius.circular(30.0),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(10, 50, 10, 10),
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(30)),
                      child: Column(children: [
                        const Text(
                          "Hello again!",
                          style: TextStyle(
                              fontFamily: 'Quicksand',
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        const Text(
                          "Welcome to the biggest pokemon family in the world",
                          style: TextStyle(
                              fontFamily: 'Quicksand',
                              fontSize: 14,
                              fontWeight: FontWeight.normal),
                          textAlign: TextAlign.center,
                        ),
                        Container(
                          height: 150,
                          width: 150,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/images/PokeBall.png"),
                                fit: BoxFit.fill)
                          ),
                          margin: EdgeInsets.all(5),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              image_selected==null?
                               CircleAvatar(
                                backgroundImage: AssetImage("assets/images/Avatar_man_1.png"),
                                 backgroundColor: Colors.transparent,
                                 radius: 55,
                               )
                              :
                                  CircleAvatar(
                                backgroundImage: FileImage(image_selected),
                                 backgroundColor: Colors.transparent,
                                 radius: 55,
                               ),
                              Positioned(
                                right: -1,
                                bottom: 0,
                                child: CircleAvatar(
                                  backgroundColor:
                                      Color.fromRGBO(23, 32, 42, 1),
                                  radius: 30,
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.add_a_photo,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                    onPressed: () async {
                                       
                                       XFile? image = await _picker.pickImage(source: ImageSource.gallery);
                                      setState(() {
                                        if(image!=null)
                                            image_selected =File(image.path);      
                                      });
                                  
                                      
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        firstName,
                        lastName,
                        email,
                        pass,
                        btnSend,
                      ]),
                    ),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
