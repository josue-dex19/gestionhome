import 'package:flutter/material.dart';
import 'package:gestionhome/views/authenticate/authenticate_screen.dart';
import 'package:gestionhome/views/home/commande.dart';
import 'package:gestionhome/views/home/historique.dart';
import 'package:gestionhome/views/authenticate/authentification.dart';
import 'package:gestionhome/views/home/retraie.dart';

class HomeScreen extends StatelessWidget {
  final AuthenticationService _auth = AuthenticationService();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
              backgroundColor: Theme.of(context).primaryColor,
              title: Center(
                  child: Text(
                'Chez Le Bon Mechoui',
                style: TextStyle(color: Colors.white),
              ))),
          body: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 50.0),
              child: Column(
                children: <Widget>[
                  Icon(
                    Icons.home,
                    size: 100.0,
                    color: Theme.of(context).primaryColor,
                  ),
                  TextButton.icon(
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor,
                        fixedSize: Size.fromWidth(350),
                        minimumSize: Size.fromHeight(70),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Commande(),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.shopping_cart,
                        size: 40,
                        color: Colors.blue.shade50,
                      ),
                      label: Text(
                        'Passe Commande',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontStyle: FontStyle.italic,
                        ),
                      )),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextButton.icon(
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor,
                        fixedSize: Size.fromWidth(350),
                        minimumSize: Size.fromHeight(70),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Retraie(),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.approval_rounded,
                        size: 40,
                        color: Colors.blue.shade50,
                      ),
                      label: Text(
                        'Retraie Commande',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 23,
                          fontStyle: FontStyle.italic,
                        ),
                      )),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextButton.icon(
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor,
                        fixedSize: Size.fromWidth(350),
                        minimumSize: Size.fromHeight(70),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Historique(),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.book,
                        size: 40,
                        color: Colors.blue.shade50,
                      ),
                      label: Text(
                        'Historique',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontStyle: FontStyle.italic,
                        ),
                      )),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextButton.icon(
                    style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor,
                        fixedSize: Size.fromWidth(350),
                        minimumSize: Size.fromHeight(70)),
                    onPressed: () async {
                      await _auth.signOut();
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>AuthenticateScreen()),);
                    },
                    icon: Icon(
                      Icons.person,
                      size: 40,
                      color: Colors.blue.shade50,
                    ),
                    label: Text('deconnection',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontStyle: FontStyle.italic,
                        )),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
