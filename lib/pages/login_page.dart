//Packages
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get_it/get_it.dart';

//Widgets
import '../widgets/custom_input_filed.dart';
import '../widgets/rounded_button.dart';

//Providers
import '../providers/authentication_provider.dart';

//Sevices
import '../services/navigation_service.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  late double _deviceHeight;
  late double _deviceWidth;
  late AuthenticationProvider _auth;
  late NavigationService _navigation;

  late final _loginFormKey = GlobalKey<FormState>();

  String? _email;
  String? _password;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    _auth = Provider.of<AuthenticationProvider>(context);
    _navigation = GetIt.instance.get<NavigationService>();

    return _buildUI();
  }

  Widget _buildUI() {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: _deviceWidth * .03,
          vertical: _deviceHeight * .02,
        ),
        height: _deviceHeight * 0.98,
        width: _deviceWidth * 0.97,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _pageTitle(),
            SizedBox(height: _deviceHeight * 0.04),
            _loginForm(),
            SizedBox(height: _deviceHeight * 0.04),
            _loginButton(),
            SizedBox(height: _deviceHeight * 0.04),

            _registerAccountLink(),
          ],
        ),
      ),
    );
  }

  Widget _pageTitle() {
    return Container(
      height: _deviceHeight * 0.10,
      child: Text(
        'Chatify',
        style: TextStyle(
          color: Color.fromARGB(255, 28, 169, 145),
          fontSize: _deviceWidth * .1,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _loginForm() {
    return Container(
      height: _deviceHeight * 0.21,
      child: Form(
        key: _loginFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomTextFormFiled(
              onSaved: (_value) {
                setState(() {
                  _email = _value;
                });
              },
              hintText: 'Email',
              regEx:
                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
              obscureText: false,
            ),
            CustomTextFormFiled(
              onSaved: (_value) {
                setState(() {
                  _password = _value;
                });
              },
              hintText: 'Password',
              regEx: r".{6,}",
              obscureText: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _loginButton() {
    return RoundedButton(
      name: 'Login',
      height: _deviceHeight * .065,
      width: _deviceWidth * 0.35,
      onPressed: () {
        if (_loginFormKey.currentState!.validate()) {
          //  print("Email is $_email , password is $_password");
          _loginFormKey.currentState!.save();
          _auth.loginWithEmailAndPassword(_email!, _password!);
          //print("Email is $_email , password is $_password");
        }
      },
    );
  }

  Widget _registerAccountLink() {
    return GestureDetector(
      onTap: () => _navigation.navigateToRoute('/register'),
      child: Container(
        child: Text(
          'Dont have an Account',
          style: TextStyle(color: Colors.blueAccent),
        ),
      ),
    );
  }
}
