
import 'package:flutter/material.dart';
import 'package:mobile_test/src/modules/auth/bloc/auth_bloc.dart';

class GlobalAuth extends InheritedWidget{

  static GlobalAuth _instancia;
  final authBloc = AuthBloc();

  factory GlobalAuth({Key key, Widget child}){

    if(_instancia == null){
      _instancia = new GlobalAuth._internal(key: key, child: child,);
    }

    return _instancia;
  }

  GlobalAuth._internal({Key key, Widget child})
    : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

    static AuthBloc of ( BuildContext context ){
      return context.dependOnInheritedWidgetOfExactType<GlobalAuth>().authBloc;
    }
    
  }

