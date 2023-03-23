import 'package:flutter/material.dart';
import 'package:gestionhome/common/Loading.dart';
import 'package:gestionhome/common/constant.dart';
import 'package:gestionhome/views/authenticate/authentification.dart';

class AuthenticateScreen extends StatefulWidget {
  @override
  _AuthenticateScreenState createState() => _AuthenticateScreenState();
}

class _AuthenticateScreenState extends State<AuthenticateScreen> {
  final AuthenticationService _auth = AuthenticationService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  bool showSignIn = true;


  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void toggleView() {
    setState(() {
      _formKey.currentState.reset();
      error='';
      emailController.text = '';
      passwordController.text = '';
      showSignIn = !showSignIn;
    });
  }
  
 @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.blueGrey,
              elevation: 0.0,
              title: Text(
                
                showSignIn
                    ? 'connecter vous'
                    : 'créer compte',
              ),
              actions: <Widget>[
                TextButton.icon(
                  onPressed: () => toggleView(),
                  icon: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  label: Text(
                    showSignIn ? "Senregister" : 'Se connecter',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 30.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: emailController,
                        decoration: TextInputDecoration.copyWith(
                            hintText: 'saisir email'),
                        validator: (value) =>
                            value.isEmpty ? "Entre un email" : null,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        controller: passwordController,
                        decoration: TextInputDecoration.copyWith(
                            hintText: 'saisir password'),
                        obscureText: true,
                        validator: (value) => value!=null && value.length < 6
                            ? "Entrer a password at least 6 character"
                            : null,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      ElevatedButton(
                         child: Text(
                          showSignIn ? "Se connecter" : "Senregister",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() => loading = true);
                            var password = passwordController.value.text;
                            var email = emailController.value.text;
                            
                            dynamic result =showSignIn
                            ? await _auth.signInWithEmailAndPassword(email, password) 
                            : await _auth.registerWithEmailAndPassword(email, password );
                            
                            
                            if (result == null) {
                              setState(() {
                                loading = false;
                                error = 'supply a valid email';
                              });
                            }
                          }
                        },
                      ),
                      SizedBox(height: 10.0,),
                      Text(
                        error,
                        style: TextStyle(color: Colors.red,fontSize: 15.0),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
