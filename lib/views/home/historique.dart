import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
class Historique extends StatefulWidget {
  
  @override
  _HistoriqueState createState() => _HistoriqueState();
}

class _HistoriqueState extends State<Historique> {
// ignore: unused_field
Query _ref;
    DatabaseReference reference =
      FirebaseDatabase.instance.reference().child('historique');
    
  @override
  void initState() { 
    super.initState();
    _ref = FirebaseDatabase.instance.reference().child('historique');
  }
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: Text('Historique'),
        ),
        body:Container(
         
          child: Container(
             decoration: BoxDecoration(
    border: Border(
      bottom: BorderSide(
        color: Theme.of(context).primaryColor,
        width: 3.0,
      ),)
  ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
              child:Row(
                children: [
                   Text('dario',
                   style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 20),),
                   SizedBox(width: 20),
                   Text('validé',style: TextStyle(color:Theme.of(context).primaryColor,fontSize: 20),),
                   SizedBox(width: 20),
                   Text('heure:22h19',style: TextStyle(color:Theme.of(context).primaryColor,fontSize: 20),),
                
                ],
              ),
                    
            ),
          ),
        ),
    );
  }
}