
import 'package:flutter/material.dart';
import 'package:poke_social/screens/register_screen.dart';


Map<String, WidgetBuilder> getAplicationRoutes(){
  return <String, WidgetBuilder>{
    '/register': (BuildContext context) => RegisterScreen(),
  };
}