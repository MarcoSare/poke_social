import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:poke_social/widgets/alerts_widget.dart';
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
  String avatarName = "man_1";
  @override
  Widget build(BuildContext context) {
    AlertsWidget alertsWidget = AlertsWidget();
    final btnSend = SocialLoginButton(
      buttonType: SocialLoginButtonType.generalLogin,
      text: "Register now",
      onPressed: () async {
        if (validar()) {
          await alertsWidget.show(context, "Welcome",
              "A confirmation email has been sent to you \nConfirm your identity to continue");
          Navigator.pop(context);
        }
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
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
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
                    margin: const EdgeInsets.all(20)),
                ClipRRect(
                  borderRadius: BorderRadius.circular(30.0),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(30)),
                      child: Column(children: [
                        const Text(
                          "Join us!",
                          style: TextStyle(
                              fontSize: 28, fontWeight: FontWeight.bold),
                        ),
                        const Text(
                          "Be part of our great community",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.normal),
                          textAlign: TextAlign.center,
                        ),
                        Container(
                          height: 150,
                          width: 150,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage("assets/images/PokeBall.png"),
                                  fit: BoxFit.fill)),
                          margin: const EdgeInsets.all(5),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              image_selected == null
                                  ? CircleAvatar(
                                      backgroundImage: AssetImage(
                                          "assets/images/Avatar_$avatarName.png"),
                                      backgroundColor: Colors.transparent,
                                      radius: 55,
                                    )
                                  : CircleAvatar(
                                      backgroundImage:
                                          FileImage(image_selected),
                                      backgroundColor: Colors.transparent,
                                      radius: 55,
                                    ),
                              Positioned(
                                right: -1,
                                bottom: 0,
                                child: CircleAvatar(
                                  backgroundColor:
                                      const Color.fromRGBO(23, 32, 42, 1),
                                  radius: 30,
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.add_a_photo,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                    onPressed: () async {
                                      await openDialog();
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

  Future<bool?> openDialog() => showDialog<bool>(
      context: context,
      builder: (context) => StatefulBuilder(
            builder: (context, setState) => AlertDialog(
              backgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: const Text(
                "Select avatar",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
              content: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(20)),
                      //padding: EdgeInsets.all(0),
                      height: 200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ListTile(
                            title: const Text("Select avatar"),
                            leading: const Icon(Icons.account_circle),
                            onTap: () async {
                              await openDialog2();
                            },
                          ),
                          ListTile(
                            title: const Text("Select from galery"),
                            leading: const Icon(Icons.collections),
                            onTap: () async {
                              await seleFromGalery();
                            },
                          ),
                          ListTile(
                            title: const Text("Select from camera"),
                            leading: const Icon(Icons.camera),
                            onTap: () async {
                              await seleFromCamera();
                            },
                          )
                        ],
                      )),
                ),
              ),
            ),
          ));

  Future<bool?> openDialog2() => showDialog<bool>(
      context: context,
      builder: (context) => StatefulBuilder(
            builder: (context, setState) => AlertDialog(
              backgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: const Text(
                "chose avatar",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
              content: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(20)),
                      //padding: EdgeInsets.all(0),
                      height: 200,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return cardAvatar(index + 1);
                          },
                          itemCount: 10)),
                ),
              ),
            ),
          ));

  Widget cardAvatar(int index) {
    String gener = index > 5 ? "woman" : "man";
    index = index > 5 ? index - 5 : index;
    return GestureDetector(
      onTap: () {
        setState(() {
          avatarName = "${gener}_$index";
          image_selected = null;
          Navigator.pop(context);
          Navigator.pop(context);
        });
      },
      child: Container(
        height: 150,
        width: 150,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/PokeBall.png"),
                fit: BoxFit.fill)),
        child: Stack(alignment: Alignment.center, children: [
          CircleAvatar(
            backgroundImage:
                AssetImage("assets/images/Avatar_${gener}_$index.png"),
            backgroundColor: Colors.transparent,
            radius: 60,
          ),
          Positioned(
            right: -1,
            bottom: 0,
            child: CircleAvatar(
                backgroundColor:
                    gener == "woman" ? Colors.pink : Colors.blueAccent,
                radius: 30,
                child: const Icon(
                  Icons.catching_pokemon,
                  color: Colors.white,
                  size: 30,
                )),
          ),
        ]),
      ),
    );
  }

  Future<void> seleFromGalery() async {
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (image != null) {
        image_selected = File(image.path);
        Navigator.pop(context);
      }
    });
  }

  Future<void> seleFromCamera() async {
    XFile? image = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (image != null) {
        image_selected = File(image.path);
        Navigator.pop(context);
      }
    });
  }

  bool validar() {
    if (firstName.formKey.currentState!.validate()) {
      if (lastName.formKey.currentState!.validate()) {
        if (email.formKey.currentState!.validate()) {
          if (pass.formKey.currentState!.validate()) return true;
        }
      }
    }
    return false;
  }
}
