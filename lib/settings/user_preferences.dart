import 'dart:math';

import 'package:poke_social/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  Future<UserModel> getUser() async {
    String? firstName = await getFirstName();
    String? lastName = await getFirstName();
    String? email = await getEmail();
    String? profilePicture = await getProfilePicture();
    return UserModel(
        firstName: firstName,
        lastName: lastName,
        email: email,
        profilePicture: profilePicture);
  }

  Future<String?> getProvider() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.containsKey('provider')) {
      return await preferences.getString('provider');
    } else {
      null;
    }
  }

  Future<String?> getFirstName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.containsKey('firstName')) {
      return await preferences.getString('firstName');
    } else {
      null;
    }
  }

  Future<String?> getLastName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.containsKey('lastName')) {
      return await preferences.getString('lastName');
    } else {
      null;
    }
  }

  Future<String?> getEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.containsKey('email')) {
      return await preferences.getString('email');
    } else {
      null;
    }
  }

  Future<String?> getProfilePicture() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.containsKey('profilePicture')) {
      return await preferences.getString('profilePicture');
    } else {
      null;
    }
  }

  Future<void> setProvider(String provider) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('provider', provider);
  }

  Future<void> setFirstName(String firstName) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('firstName', firstName);
  }

  Future<void> setLastName(String lastName) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('lastName', lastName);
  }

  Future<void> setEmail(String email) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('email', email);
  }

  Future<void> setProfilePicture(String profilePicture) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('profilePicture', profilePicture);
  }

  Future<void> setUserModel(UserModel userModel, String? provider) async {
    await setFirstName(userModel.firstName!);
    await setLastName(userModel.lastName ?? 'none');
    await setEmail(userModel.email!);
    await setProfilePicture(userModel.profilePicture!);
    if (provider != null) {
      await setProvider(provider);
    }
  }

  Future<void> logOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove("firstName");
    await preferences.remove("lastName");
    await preferences.remove("email");
    await preferences.remove("profilePicture");
    await preferences.remove("provider");
  }
}
