import 'package:finstagram/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
  double? _deviceHeight, _deviceWidth;
  FireBaseService? _firebaseService;
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  String? _email, _password;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  late Size _mediaSize;

  @override
  void initState() {
    super.initState();
    _firebaseService = GetIt.instance.get<FireBaseService>();
  }

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
              fontFamily: 'Vidaloka-Regular',
              color: Colors.white,
              fontSize: 50,
              fontWeight: FontWeight.w500,
            ),
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
    return Container(
      child: Form(
        key: _loginFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                "Welcome!",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 40,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            SizedBox(height: _deviceHeight! * 0.05),
            _buildInputField(
              _emailController,
              'Email',
              const Icon(
                Icons.email_outlined,
                color: Colors.grey,
              ),
              _email,
              false,
            ),
            SizedBox(height: _deviceHeight! * 0.02),
            _buildInputField(
              _passwordController,
              'Password',
              const Icon(
                Icons.lock_outline,
                color: Colors.grey,
              ),
              _password,
              true,
            ),
            _buildForgotPassword(),
            _buildLoginButton(),
            _buildRegister(),
          ],
        ),
      ),
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

  Widget _buildInputField(TextEditingController myController, String hintText,
      Icon logo, String? _textValue, bool _isPassword) {
    return TextFormField(
      controller: myController,
      obscureText: _isPassword,
      decoration: InputDecoration(
        border: InputBorder.none,
        filled: true,
        labelText: hintText,
        fillColor: Colors.grey.shade200,
        prefixIcon: logo,
      ),
      onSaved: (_value) {
        setState(() {
          _textValue = _value;
        });
      },
      validator: (_value) {
        bool _result;
        if (_isPassword == false) {
          _result = _value!.contains(
            RegExp(
                r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"),
          );
          return _result ? null : "Please enter a valid email";
        } else {
          return _value!.length > 6
              ? null
              : "Please enter a password greater than 6 characters";
        }
      },
    );
  }

  Widget _buildGreyText(String text, Color color,
      [FontWeight? fontWeight, TextDecoration? textDecoration]) {
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
      onPressed: _loginUser,
      color: Colors.red,
      minWidth: _deviceHeight,
      height: _deviceHeight! * 0.06,
      child: const Text(
        "Sign In",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildRegister() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildGreyText(
            "Didn't have any account?", Colors.grey, FontWeight.w100),
        TextButton(
            onPressed: () => Navigator.pushNamed(context, 'register'),
            style: TextButton.styleFrom(
              foregroundColor: Colors.green,
            ),
            child: _buildGreyText(
              "Sign Up Here",
              Colors.black,
              FontWeight.w800,
              TextDecoration.underline,
            )),
      ],
    );
  }

  void _loginUser() async {
    if (_loginFormKey.currentState!.validate()) {
      _loginFormKey.currentState!.save();
      _email = _emailController.text;
      _password = _passwordController.text;
      bool _result = await _firebaseService!
          .loginUser(email: _email!, password: _password!);
      if (_result) {
        Navigator.popAndPushNamed(context, 'home');
      } else {}
    }
  }
}
