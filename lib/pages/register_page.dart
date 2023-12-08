import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:finstagram/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RegisterPageState();
  }
}

class _RegisterPageState extends State<RegisterPage> {
  double? _deviceHeight, _deviceWidth;
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  String? _name, _email, _password;
  File? _image;

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

      void dispose() {
        _nameController.dispose();
    _emailController.dispose();
   _passwordController.dispose();
    super.dispose();
  }

  FireBaseService? _firebaseService;

  @override
  void initState() {
    super.initState();
    _firebaseService = GetIt.instance.get<FireBaseService>();
  }


  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: _deviceWidth! * 0.05,
          ),
          child: SingleChildScrollView(
            reverse: true,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _createCaption(),
                SizedBox(height: _deviceHeight! * 0.05),
                _profileImage(),
                SizedBox(height: _deviceHeight! * 0.05),
                _registrationForm(),
                SizedBox(height: _deviceHeight! * 0.05),
                _registerButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _createCaption() {
    return const Column(
      children: [
        Text(
          "Create a New Account",
          style: TextStyle(
            color: Colors.black,
            fontSize: 35,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          "Create an account to share your amazing photos to your friends",
          style: TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _profileImage() {
    var _imageProvider = _image != null
        ? FileImage(_image!)
        : const NetworkImage("https://i.pravatar.cc/300");
    return GestureDetector(
      onTap: () {
        FilePicker.platform.pickFiles(type: FileType.image).then((_result) {
          setState(() {
            _image = File(_result!.files.first.path!);
          });
        });
      },
      child: Container(
        height: _deviceHeight! * 0.15,
        width: _deviceHeight! * 0.15,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: _imageProvider as ImageProvider,
          ),
        ),
        child: Align(
          alignment: Alignment.bottomRight,
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.red, borderRadius: BorderRadius.circular(100)),
            child: const Icon(
              Icons.edit,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _registrationForm() {
    return SizedBox(
      height: _deviceHeight! * 0.35,
      child: Form(
        key: _registerFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _textField(_nameController, "Name", _name, false),
            _textField(_emailController, "Email Address", _email, false),
            _textField(_passwordController, "Password", _password, true),
          ],
        ),
      ),
    );
  }

  Widget _textField(TextEditingController myController, String hintText,
      String? _textValue, bool _isPassword) {
    return TextFormField(
      controller: myController,
      obscureText: _isPassword,
      decoration: InputDecoration(
        border: InputBorder.none,
        filled: true,
        labelText: hintText,
        labelStyle: const TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.w200,
        ),
        fillColor: Colors.grey.shade200,
      ),
      onSaved: (_value) {
        setState(() {
          _textValue = _value;
        });
      },
      validator: (_value) {
        bool _result;
        if (hintText == "Name") {
          return _value!.length > 0 ? null : "Please enter a name";
        } else if (hintText == "Email Address") {
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

  Widget _registerButton() {
    return MaterialButton(
      onPressed: _registerUser,
      color: Colors.red,
      minWidth: _deviceHeight,
      height: _deviceHeight! * 0.06,
      child: const Text(
        "Create Account",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  void _registerUser() async {
    if (_registerFormKey.currentState!.validate() && _image != null) {
      _registerFormKey.currentState!.save();
      _name = _nameController.text;
      _email = _emailController.text;
      _password = _passwordController.text;
      bool _result = await _firebaseService!.registerUser(
        name: _name!,
        email: _email!,
        password: _password!,
        image: _image!,
      );
      if (_result) Navigator.pop(context);
    }
  }
}
