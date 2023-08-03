import 'package:flutter/material.dart';
import 'package:hospitalappointmentsystem/Auth/registerView.dart';
import 'package:hospitalappointmentsystem/Services/AuthService.dart';
import 'package:hospitalappointmentsystem/constants/constants.dart';
import '../Widgets/Wtextfield.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: Constants.pagepadding,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Expanded(flex: 2, child: Image.asset("assets/gifs/loginScreen2.gif")),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Widget_Textfield(
                hintText: "@mail", controller: _mailController,textInputType: TextInputType.emailAddress),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Widget_Textfield(
              textInputType: TextInputType.visiblePassword,
                hintText: "Şifre",
                controller: _passwordController,
                obscureText: true),
          ),
          ElevatedButton(
              onPressed: () {
                AuthService().signIn(context,
                    email: _mailController.text,
                    password: _passwordController.text);
              },
              child: Text("Giriş Yap")),
          const Divider(
            thickness: 3,
          ),
          Expanded(
              child: TextButton(
                  onPressed: () {
                    Constants().goPage(context, RegisterView());
                  },
                  child: Text("Hesabın yok mu?")))
        ]),
      ),
    );
  }
}
