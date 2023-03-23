import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gestionhome/models/user.dart';
import 'package:gestionhome/views/authenticate/Splashscreen_wrapper.dart';
import 'package:gestionhome/views/authenticate/authentification.dart';
import 'package:provider/provider.dart';

 
void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
} 
 
class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  
  Widget build(BuildContext context) {
    return StreamProvider<AppUser>.value(
      value: AuthenticationService().user,
      initialData: null,
      child: MaterialApp(
      title: 'Material App',
      home:SplashScreenWrapper(),
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
    ),
    );
  }
}
