import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
  double? _deviceHeight, _deviceWidth;
  late Size _mediaSize;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    _mediaSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.red,
          child: Center(
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Stack(children: [
                Positioned(top: 80, child: _appTitle()),
                Positioned(bottom: 0, child: _appLoginPart()),
              ]),
            ),
          ),
        ),
      ),
    );
  }

  Widget _appTitle() {
    return SizedBox(
      width: _mediaSize.width,
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Finstagram",
            style: TextStyle(
                color: Colors.white,
                fontSize: 50,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }

  Widget _appLoginPart() {
    return SizedBox(
      width: _mediaSize.width,
      child: Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        )),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: _buildForm(),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Center(
          child: Text(
            "Welcome!",
            style: TextStyle(
              color: Colors.black,
              fontSize: 50,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        SizedBox(height: _deviceHeight! * 0.10),
        _buildInputField(
            'Email',
            const Icon(
              Icons.email_outlined,
              color: Colors.grey,
            )),
        SizedBox(height: _deviceHeight! * 0.03),
        _buildInputField(
            'Password',
            const Icon(
              Icons.lock_outline,
              color: Colors.grey,
            )),
        SizedBox(height: _deviceHeight! * 0.03),
        _buildForgotPassword(),
         SizedBox(height: _deviceHeight! * 0.03),
        _buildLoginButton(),
        SizedBox(height: _deviceHeight! * 0.03),
        _buildRegister(),
      ],
    );
  }

  Widget _buildForgotPassword() {
    return TextButton(
      onPressed: () {},
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
      ),
      child: _buildGreyText(
        "Forgot Password?",
        Colors.black,
        FontWeight.w800,
      ),
    );
  }

  Widget _buildInputField(String hintText, Icon logo) {
    return TextFormField(
      decoration: InputDecoration(
        border: InputBorder.none,
        filled: true,
        labelText: hintText,
        fillColor: Colors.grey.shade200,
        prefixIcon: logo,
      ),
    );
  }

  Widget _buildGreyText(String text, Color color, [FontWeight? fontWeight,TextDecoration? textDecoration]) {
    return Center(
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontWeight: fontWeight,
          decoration: textDecoration,
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return MaterialButton(
      onPressed: () {},
      color: Colors.red,
      minWidth: _deviceHeight,
      height: _deviceHeight! * 0.08,
      child: const Text("Sign In",style: TextStyle(color: Colors.white),),
    );
  }

  Widget _buildRegister() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
      _buildGreyText("Didn't have any account?", Colors.grey,FontWeight.w100),
      TextButton(
      onPressed: () {},
      style: TextButton.styleFrom(
        foregroundColor: Colors.green,
      ),
      child: _buildGreyText(
        "Sign Up Here",
        Colors.black,
        FontWeight.w800,
        TextDecoration.underline,
      )),
    ],);
  }



}
