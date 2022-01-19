
import 'package:flutter/material.dart';
import 'package:mobile_test/src/modules/auth/bloc/global_bloc.dart';
import 'package:mobile_test/src/modules/auth/services/auth_services.dart';
import 'package:mobile_test/src/widgets/custom_filed_form.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final _bloc = GlobalAuth.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme:
            IconThemeData(color: Theme.of(context).colorScheme.onSurface),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(30),
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sign In',
                style: Theme.of(context).textTheme.headline5,
              ),
              SizedBox(
                height: 20,
              ),
              CustomFieldForm(
                blocStream: _bloc.userNameStream,
                onChanged: _bloc.changeUserName,
                textInputType: TextInputType.text,
                icon: Icons.person_rounded,
                placeholder: 'Username',
              ),
              CustomFieldForm(
                blocStream: _bloc.passwordStream,
                onChanged: _bloc.changePassword,
                textInputType: TextInputType.text,
                icon: Icons.lock_rounded,
                placeholder: 'Password',
                obscureText: true,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: StreamBuilder(
                        stream: _bloc.formValidStreamLogin.asBroadcastStream(),
                        builder: (context, snapshot) {
                          return ElevatedButton(
                              onPressed:  () async => await AuthService().login(context, userName: _bloc.userName, password: _bloc.password) ,
                              child: Text('LOGIN'));
                        }),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(value: false, onChanged: (value){}),
                  Text('Remember me'),
                  Spacer(),
                  TextButton(onPressed: (){}, child: Text('Forgot password'))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
