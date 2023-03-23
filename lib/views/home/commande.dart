import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gestionhome/common/constant.dart';
import 'package:gestionhome/views/home/retraie.dart';
import 'package:intl/intl.dart';

import 'home_screen.dart';

class Commande extends StatefulWidget {  

  static get autrePrecision => null;@override
  _CommandeState createState() => _CommandeState();
}
class _CommandeState extends State<Commande> {
  var listitem = [
    'Porc',
    'Mouton',
    'Belier',
    'Lapin',
    'Poule',
    'Canard',
    'Pintade',
    'Dinde',
    ''
  ];
  var current = '';

  TextEditingController _nomController,
      _typeController,
      _prixController,
      _dateController,
      _heureController,
      _autreController,
      _payeController,
      _resteController,
      _nombreController;

  // ignore: unused_field
  DatabaseReference _ref;
  TimeOfDay time;
  DateTime date = DateTime.now();
  Future<Null> selectTimepicker(BuildContext context) async {
    DateFormat formatter = DateFormat('dd/MM/yy');

    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: DateTime(2020),
        lastDate: DateTime(2030));
    if (picked != null && picked != date) {
      setState(() {
        date = picked;
        _dateController.value =
            TextEditingValue(text: formatter.format(picked));
        print(date.toString());
      });
    }
  }

  Future pickTime(
    BuildContext context,
  ) async {
    final initialTime = TimeOfDay(hour: 9, minute: 0);
    final newTime = await showTimePicker(
      context: context,
      initialTime: time ?? initialTime,
    );

    if (newTime == null) return;

    setState(() {
      time = newTime;
      _heureController.value = TextEditingValue(text: newTime.format(context));
      print(newTime.toString());
    });
  }

  @override
  void initState() {
    super.initState();

    _nomController = TextEditingController();
    _typeController = TextEditingController();
    _nombreController=TextEditingController();
    _prixController = TextEditingController();
    _dateController = TextEditingController();
    _heureController = TextEditingController();
    _autreController = TextEditingController();
    _payeController = TextEditingController();
    _resteController = TextEditingController();

    _ref = FirebaseDatabase.instance.reference().child('retraie');
  }


@override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            title: Center(
              child: Text(
                'Commande',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            )),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                    controller: _nomController,
                    decoration: InputDecoration(
                        labelText: 'nom',
                        prefixIcon: Icon(
                          Icons.person,
                          size: 20,
                        ),
                        labelStyle: MyDeco,
                        border: OutlineInputBorder())),
                SizedBox(
                  height: 20,
                ),
                
 DropdownButtonFormField<String>(
                    value: current,
                    icon: Icon(Icons.keyboard_arrow_down),
                    items: listitem.map((String listitem) {
                      return DropdownMenuItem(
                          value: listitem, child: Text('$listitem'));
                    }).toList(),
                    decoration: InputDecoration(
                        labelText: 'type',
                        labelStyle: MyDeco,
                        prefixIcon: Icon(
                          Icons.merge_type_outlined,
                          size: 20,
                        ),
                        border: OutlineInputBorder(),
                        fillColor: Colors.blue[200]),
                    onChanged: (value) {
                      setState(() {
                       
                        current = value;
                        _typeController.value=TextEditingValue(text: value);
                      });
                    }
                  ),
                  SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _nombreController,
                  decoration: InputDecoration(
                      labelText:'nombre de type',
                      labelStyle: MyDeco,
                      prefixIcon: Icon(
                        Icons.money_off,
                        size: 20,
                      ),
                      border: OutlineInputBorder()),
                  keyboardType: TextInputType.number,
                ),
              

                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _prixController,
                  decoration: InputDecoration(
                      // labelText: ('prix'),
                       labelText: ('prix'),
                      labelStyle: MyDeco,
                      prefixIcon: Icon(
                        Icons.monetization_on_sharp,
                        size: 20,
                      ),
                      border: OutlineInputBorder()),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  child: TextFormField(
                    controller: _dateController,
                    onTap: () {
                      selectTimepicker(context);
                    },
                    decoration: InputDecoration(
                        labelText: 'Date de retraie',
                        labelStyle: MyDeco,
                        prefixIcon: Icon(
                          Icons.date_range_rounded,
                          size: 20,
                        ),
                        border: OutlineInputBorder()),
                    keyboardType: TextInputType.datetime,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),

                // pour heure
                GestureDetector(
                  child: TextFormField(
                    controller: _heureController,
                    onTap: () {
                      pickTime(
                        context,
                      );
                      MediaQuery.of(context)
                          .copyWith(alwaysUse24HourFormat: true);
                    },
                    decoration: InputDecoration(
                        labelText: 'heure de retraie',
                        labelStyle: MyDeco,
                        prefixIcon: Icon(
                          Icons.time_to_leave,
                          size: 20,
                        ),
                        border: OutlineInputBorder()),
                    keyboardType: TextInputType.datetime,
                  ),
                ),

                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _autreController,
                  decoration: InputDecoration(
                      labelText: 'Autre Precision',
                      labelStyle: MyDeco,
                      prefixIcon: Icon(
                        Icons.note,
                        size: 20,
                      ),
                      border: OutlineInputBorder()),
                ),

                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _payeController,
                  decoration: InputDecoration(
                      labelText: 'Payé',
                      labelStyle: MyDeco,
                      prefixIcon: Icon(
                        Icons.monetization_on_rounded,
                        size: 20,
                      ),
                      border: OutlineInputBorder()),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _resteController,
                  decoration: InputDecoration(
                      labelText: 'Reste a Payé',
                      labelStyle: MyDeco,
                      prefixIcon: Icon(
                        Icons.money_off,
                        size: 20,
                      ),
                      border: OutlineInputBorder()),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 5,
                    ),
                    FloatingActionButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return HomeScreen();
                        }));
                      },
                      child: Icon(
                        Icons.arrow_back,
                      ),
                      backgroundColor: Colors.blueGrey,
                    ),
                    SizedBox(
                      width: 220,
                    ),
                    FloatingActionButton(
                      onPressed: () {
                        sauvegarde();
                      },
                      child: Icon(Icons.save),
                      backgroundColor: Colors.blueGrey,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void sauvegarde() {
    // ignore: unused_local_variable
    String nom = _nomController.text;
    // ignore: unused_local_variable
    String type = _typeController.text;
    // ignore: unused_local_variable
    String nombre = _nombreController.text;
    // ignore: unused_local_variable
    String prix = _prixController.text;
    // ignore: unused_local_variable
    String date = _dateController.text;
    // ignore: unused_local_variable
    String heure = _heureController.text;
    // ignore: unused_local_variable
    String autre = _autreController.text;
    // ignore: unused_local_variable
    String paye = _payeController.text;
    // ignore: unused_local_variable
    String reste = _resteController.text;

    Map<String, dynamic> commande = {
      'nom': _nomController.text,
      'type': _typeController.text,
      'nombre': _nombreController.text,
      'prix': _prixController.text,
      'date': _dateController.text,
      'heure': _heureController.text,
      'autre': _autreController.text,
      'paye': _payeController.text,
      'reste': _resteController.text
    };

    //effacer les controller apres avoir enregistrer
    _nomController.clear();
    _autreController.clear();
    _dateController.clear();
    _nombreController.clear();
    _heureController.clear();
    _payeController.clear();
    _prixController.clear();
    _resteController.clear();
    _typeController.clear();

    _ref.push().set(commande).then((value) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Enregistrement reussi')));
    });
    Navigator.push(context, MaterialPageRoute(builder: (context) => Retraie()));
    setState(() {
      Navigator.push(context, MaterialPageRoute(builder: (_) {
        return Retraie();
      }));
    });
  }

  // onSelect(BuildContext context, item) {
  //   switch (item) {
  //     case 0:

  //       break;
  //     case 1:
        
  //       break;
  //   }
  // }

//creation de fonction

// Widget _commandeFonction({
// @required String label,
// @required IconData icon,
// @required double size,
// }){
//   return Container(
//     child: Row(children: [
//       Container(
//         width: size,

//       )
//     ],),
//   );
// }
}

