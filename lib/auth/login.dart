import 'package:flutter/material.dart';
import '../socialmedia.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String errormessage = "";
  bool isError = false;

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void checkLogin(String username, String password) {
    setState(() {
      if (username.trim().isEmpty) {
        errormessage = "Please input your username!";
        isError = true;
      } else if (password.trim().isEmpty) {
        errormessage = "Please input your password!";
        isError = true;
      } else {
        errormessage = "";
        isError = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.music_note, size: 64),
                const SizedBox(height: 8),
                Text('TIKTOK', style: txtstyle),
                const SizedBox(height: 30),
                TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: 'Username',
                    prefixIcon: const Icon(Icons.person),
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: 'Enter Password',
                    prefixIcon: const Icon(Icons.lock),
                  ),
                ),
                if (isError) ...[
                  const SizedBox(height: 10),
                  Text(errormessage, style: errortxtstyle),
                ],
                const SizedBox(height: 15),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    checkLogin(
                        usernameController.text, passwordController.text);
                    if (!isError) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Socialmedia()),
                      );
                    }
                  },
                  child: Text('LOGIN', style: txtstyle2),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

var txtstyle = const TextStyle(
  fontWeight: FontWeight.bold,
  letterSpacing: 2,
  fontSize: 38,
);

var registertxtstyle = const TextStyle(
  fontWeight: FontWeight.bold,
  letterSpacing: 2,
  fontSize: 14,
);

var errortxtstyle = const TextStyle(
  fontWeight: FontWeight.bold,
  letterSpacing: 1,
  fontSize: 14,
  color: Colors.red,
);

var txtstyle2 = const TextStyle(
  fontWeight: FontWeight.bold,
  letterSpacing: 2,
  fontSize: 20,
  color: Colors.white,
);