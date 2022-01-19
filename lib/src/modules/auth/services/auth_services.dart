import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mobile_test/src/modules/auth/widgets/dialogs.dart';
import 'package:mobile_test/src/modules/navigation/home_page.dart';

class AuthService {
  Future<void> login(BuildContext context,
      {@required String userName, @required String password}) async {
    progressIndicatorForAuth(context: context, message: 'Iniciando sesión');

    try {
      Response resp = await get(
        Uri.parse(
            'https://www.mockachino.com/aa9bfef4-60ba-47/login?user=$userName&password=$password'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      Navigator.pop(context);
      if ((resp.statusCode == 200 || resp.statusCode == 201)) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => HomePage()));
      } else {
        throw Exception(resp.statusCode);
      }
    } on Exception {
      alertWithIcon(context,
          title: "Account verification failed",
          message: "Username or password incorrect",
          icon: Icons.person);
    } catch (e) {
      informationAlert(context, title: 'Something went wrong', message: '$e');
    }
  }
}
