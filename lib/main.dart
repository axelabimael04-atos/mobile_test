
import 'package:flutter/material.dart';
import 'package:mobile_test/src/modules/auth/auth_provider.dart';
import 'package:mobile_test/src/modules/auth/bloc/global_bloc.dart';
import 'package:mobile_test/src/modules/auth/login_page.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  return runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AuthProvider())],
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GlobalAuth(
      child: MaterialApp(
          title: 'Prueba App',
          debugShowCheckedModeBanner: false,
          home: LoginPage(),
        ),
      
    );
  }
}
