import 'package:flutter/material.dart';
import 'package:hospitalappointmentsystem/Auth/loginView.dart';
import 'package:hospitalappointmentsystem/Services/AuthService.dart';
import 'package:hospitalappointmentsystem/Widgets/Wtextfield.dart';
import 'package:hospitalappointmentsystem/constants/constants.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final TextEditingController _nameController = TextEditingController();
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
        child: Column(children: [
          Expanded(
              flex: 2, child: Image.asset("assets/gifs/registerScreen.gif")),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Widget_Textfield(
              hintText: "Ad",
              controller: _nameController,
        
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Widget_Textfield(
              hintText: "Email",
              controller: _mailController,
                 textInputType: TextInputType.emailAddress,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Widget_Textfield(
              hintText: "Şifre",
              controller: _passwordController,
              obscureText: true,
                 textInputType: TextInputType.visiblePassword,
            ),
          ),
          ElevatedButton(
              onPressed: () {
                AuthService().signUp(
                  context,
                  name: _nameController.text,
                  email: _mailController.text,
                  password: _passwordController.text,
                );
              },
              child: Text("Kayıt Ol")),
          const Divider(
            thickness: 3,
          ),
          Expanded(
              child: TextButton(
                  onPressed: () {
                    Constants().goPage(context, LoginView());
                  },
                  child: Text("Zaten Hesabın Var mı?")))
        ]),
      ),
    );
  }
}
