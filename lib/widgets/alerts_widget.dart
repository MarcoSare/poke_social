import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

class AlertsWidget {
  Future<bool?> show(BuildContext context, String title, String msg) =>
      showDialog<bool>(
          context: context,
          builder: (context) => StatefulBuilder(
                builder: (context, setState) => AlertDialog(
                  backgroundColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  content: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                      child: Container(
                          height: 300,
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(20)),
                          padding: EdgeInsets.all(20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(title,
                                  style: const TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold)),
                              Text(
                                msg,
                                style: const TextStyle(fontSize: 14),
                                textAlign: TextAlign.center,
                              ),
                              SocialLoginButton(
                                buttonType: SocialLoginButtonType.generalLogin,
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                text: "Ok",
                                mode: SocialLoginButtonMode.single,
                                borderRadius: 15,
                                backgroundColor: Theme.of(context).primaryColor,
                              )
                            ],
                          )),
                    ),
                  ),
                ),
              ));
}
