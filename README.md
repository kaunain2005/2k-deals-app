# deals
@m@zon@2005
Your unique Associate ID is 2kdealsshop-21
A new Flutter project.


import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:deals/screens/product_detection_page.dart';
  Future<void> _takePicture() async {
    // Request permissions
    await _requestPermissions();
    // ProductDetectionPage();

    // final ImagePicker _picker = ImagePicker();
    // // Take a picture and get the file
    // final XFile? image = await _picker.pickImage(source: ImageSource.camera);

    // // if (image != null) {
    // //   // Save the image to gallery
    // //   // await image.saveTo(image.path);
    // //    // Save the image to gallery using gallery_saver
    // // await GallerySaver.saveImage(image.path, albumName: 'YourAlbumName');
    // //   // Show a message or perform any action after taking the picture
    // //   ScaffoldMessenger.of(context).showSnackBar(
    // //     SnackBar(content: Text('Image saved to gallery!')),
    // //   );
    // // }

    // if (image != null) {
    //   // Get the application's documents directory
    //   Directory? appDocDir = await getExternalStorageDirectory(); // For Android
    //   if (Platform.isIOS) {
    //     appDocDir = await getApplicationDocumentsDirectory(); // For iOS
    //   }

    //   // Define a path to save the image in the gallery
    //   String newPath = '${appDocDir?.path}/2Kdeals/Pictures';
    //   print("New path for image storing : " + newPath + ".....");
    //   Directory newDir = Directory(newPath);

    //   if (!newDir.existsSync()) {
    //     print("New directory creating.....");
    //     newDir.createSync(
    //         recursive: true); // Create directory if it doesn't exist
    //   }

    //   // Copy the image to the gallery path
    //   File imageFile = File(image.path);
    //   // print(imageFile);
    //   String fileName = imageFile.uri.pathSegments.last;
    //   print("File name : " + fileName+".....");
    //   File savedImage = await imageFile.copy('${newDir.path}/$fileName');
    //   print("Image saved......");

    //   // Show success message
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text('Image saved to ${savedImage.path}')),
    //   );
    // }
  }



  <!-- flutter_login -->
  import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'login_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  // Mock login function
  Future<String?> _loginUser(LoginData data) async {
    // Simulate a network call
    await Future.delayed(const Duration(seconds: 1));

    // Example logic for login
    if (data.name == 'user' && data.password == 'password') {
      return null; // Return null if login is successful
    } else {
      return 'Incorrect username or password'; // Return error message
    }
  }

  // Mock signup function
  Future<String?> _signupUser(SignupData data) async {
    // Simulate a network call
    await Future.delayed(const Duration(seconds: 1));

    // Example logic for signup
    // if (data.name.isEmpty || data.password.isEmpty || data.confirmPassword.isEmpty) {
    //   return 'Please fill in all fields'; // Return error message if fields are empty
    // }
    
    // if (data.password != data.confirmPassword) {
    //   return 'Passwords do not match'; // Return error message if passwords do not match
    // }

    // You could add additional checks here (e.g., validating email format)

    return null; // Return null if signup is successful
  }

  // Mock password recovery function
  Future<String?> _recoverPassword(String name) async {
    await Future.delayed(const Duration(seconds: 2));
    return null; // Return null if recovery is successful
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'ECORP',
      logo: const AssetImage('assets/images/logo7rm.png'),
      onLogin: _loginUser,
      onSignup: _signupUser, // This now expects SignupData
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ));
      },
      onRecoverPassword: _recoverPassword,
      messages: LoginMessages(
        userHint: 'User',
        passwordHint: 'Pass',
        confirmPasswordHint: 'Confirm',
        loginButton: 'LOG IN',
        signupButton: 'REGISTER',
        forgotPasswordButton: 'Forgot huh?',
        recoverPasswordButton: 'HELP ME',
        goBackButton: 'GO BACK',
        confirmPasswordError: 'Not match!',
        recoverPasswordDescription:
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry',
        recoverPasswordSuccess: 'Password rescued successfully',
      ),
    );
  }
}
