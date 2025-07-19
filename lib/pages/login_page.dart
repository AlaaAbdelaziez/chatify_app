//Packages
import 'package:flutter/material.dart';
//Widgets
import '../widgets/custom_input_filed.dart';
import '../widgets/rounded_button.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  late double _deviceHeight;
  late double _deviceWidth;

  final _loginFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

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
              onSaved: (_value) {},
              hintText: 'Email',
              regEx:
                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
              obscureText: false,
            ),
            CustomTextFormFiled(
              onSaved: (_value) {},
              hintText: 'Password',
              regEx: r".{8,}",
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
      onPressed: () {},
    );
  }

  Widget _registerAccountLink() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        child: Text(
          'Dont have an Account',
          style: TextStyle(color: Colors.blueAccent),
        ),
      ),
    );
  }
}
