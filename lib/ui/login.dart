import 'package:flutter/material.dart';
import 'package:klinik_app/service/login_service.dart';
import 'package:klinik_app/ui/beranda.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _usernameCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Login Admin",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 50),
                Center(
                  child: Form(
                    key: _formKey,
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.3,
                      child: Column(
                        children: [
                          _usernameTextField(),
                          SizedBox(height: 20),
                          _passwordTextField(),
                          SizedBox(
                              height:
                                  20), // Menambahkan jarak antara password dan tombol login
                          _tombolLogin(context), // Melewatkan context
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _usernameTextField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Username"),
      controller: _usernameCtrl,
    );
  }

  Widget _passwordTextField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Password"),
      obscureText: true,
      controller: _passwordCtrl,
    );
  }

  Widget _tombolLogin(BuildContext context) {
    return Container(
      width: double
          .infinity, // Menggunakan double.infinity untuk memastikan tombol mengambil lebar penuh
      child: ElevatedButton(
        child: Text(
          "Login",
          style: TextStyle(color: Colors.white),
        ),
        style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
        onPressed: () async {
          String username = _usernameCtrl.text;
          String password = _passwordCtrl.text;
          bool value = await LoginService().login(username, password);
          if (value) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Beranda()),
            );
          } else {
            AlertDialog alertDialog = AlertDialog(
              content: const Text("Username atau Password Tidak Valid"),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "OK",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.green), // Pindahkan style di luar child
                ),
              ],
            );
            showDialog(
              context: context,
              builder: (context) => alertDialog,
            );
          }
        },
      ),
    );
  }
}
