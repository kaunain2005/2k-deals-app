import 'package:deals/screens/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'auth_service.dart'; // Import your auth service


class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

// Create an instance of AuthService
  final AuthService authService = AuthService();

  // Mock login function
  Future<String?> _loginUser(LoginData data) async {
    // Simulate a network call
    await Future.delayed(const Duration(seconds: 1));

    // Example logic for login
    if (data.name == 'user@gmail.com' && data.password == 'pass123') {
      return null; // Return null if login is successful
    } else {
      return 'Incorrect username or password'; // Return error message
    }
  }

  // Mock signup function
  Future<String?> _signupUser(SignupData data) async {
    // Simulate a network call
    await Future.delayed(const Duration(seconds: 2));

    // Example logic for signup
    if (data.name!.isEmpty || data.password!.isEmpty) {
      return 'Please fill in all fields'; // Return error message if fields are empty
    }

    // if (data.password != data.confirmPassword) {
    //   return 'Passwords do not match'; // Return error message if passwords do not match
    // }

    // You could add additional checks here (e.g., validating email format)

    return null; // Return null if signup is successful
  }

  // Mock password recovery function
  Future<String?> _recoverPassword(String name) async {
    await Future.delayed(const Duration(seconds: 1));
    return null; // Return null if recovery is successful
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      logo: const AssetImage('assets/images/logo7rm.png'),
      navigateBackAfterRecovery: true,
      onLogin: _loginUser,
      onSignup: _signupUser, // This now expects SignupData
      additionalSignupFields: const [
        UserFormField(
          keyName: 'username',
          displayName: 'Username',
        ),
        UserFormField(
          keyName: 'phone',
          displayName: 'Phone Number',
        ),
      ],
      loginProviders: <LoginProvider>[
          LoginProvider(
            button: Buttons.google, // Use built-in Google button
            label: 'Google',
            callback: () async {
              // debugPrint('start google sign in');
              // await Future.delayed(loginTime);
              // debugPrint('stop google sign in');
              return null;
            },
          ),
          LoginProvider(
            button: Buttons.facebook,
            label: 'Facebook',
            callback: () async {
              // debugPrint('start facebook sign in');
              // await Future.delayed(loginTime);
              // debugPrint('stop facebook sign in');
              return null;
            },
          ),
        ],
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => MainPage(),
        ));
      },
      
      onRecoverPassword: _recoverPassword,
      messages: LoginMessages(
        userHint: 'Email',
        passwordHint: 'Password',
        confirmPasswordHint: 'Confirm',
        loginButton: 'LOG IN',
        signupButton: 'REGISTER',
        forgotPasswordButton: 'Forgot password?',
        recoverPasswordButton: 'RECOVER',
        goBackButton: 'GO BACK',
        confirmPasswordError: 'Not match!',
        recoverPasswordDescription:
            'We will send a recovery link to your email.',
        recoverPasswordSuccess: 'Password rescued successfully',
      ),
      theme: LoginTheme(
        primaryColor: Color.fromARGB(255, 21, 0, 139),
        errorColor: Color.fromARGB(255, 255, 0, 0),
        buttonTheme: LoginButtonTheme(
          backgroundColor: Color.fromARGB(255, 21, 0, 139),
          elevation: 5.0,
        ),
      ),
      userValidator: (value) {
        if (!value!.contains('@') || !value.endsWith('.com')) {
          return "Email must contain '@' and end with '.com'";
        }
        return null;
      },
      passwordValidator: (value) {
        if (value!.isEmpty) {
          return 'Password is empty';
        }
        return null;
      },
    );
  }
}

class CustomGoogleButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(FontAwesomeIcons.google, color: Colors.red), // Custom icon and color
      onPressed: () {
        // Handle button press
      },
    );
  }
}

