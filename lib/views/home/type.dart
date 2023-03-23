import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:gestionhome/views/home/date.dart';
import 'package:gestionhome/views/home/retraie.dart';

class Filter extends StatefulWidget {
  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter> {
Query _ref;
  DatabaseReference reference =
      FirebaseDatabase.instance.reference().child('retraie');
 

  @override
  void initState() {
    super.initState();
    _ref = FirebaseDatabase.instance.reference().child('retraie').orderByChild('type');
  }
  Widget _buildRetraieItem({Map commande}) {
    return Container(
      height: 110,
      child: Card(
        elevation: 10,
        child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 50,
                      decoration: BoxDecoration(
                          color: Colors.blue[400],
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      child: 
                      TextButton(
                          onPressed: () {},
                          child: Text(commande['id'].toString(),
                              style: TextStyle(
                                color: Colors.white,
                              ))),
                    ),
                    SizedBox(width: 5),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _elementTile(
                          textValue: commande['nom'],
                          icon: Icons.person,
                          width: 150,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                            width: 150,
                            child: Row(
                              children: [
                                _elementTile(
                                  textValue: commande['nombre'],
                                  icon: Icons.countertops,
                                  width: 40,
                                ),
                                Text(
                                  commande['type'],
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 15),
                                )
                              ],
                            )),
                        Container(
                          child: _elementTile(
                            textValue: commande['date'],
                            icon: Icons.date_range,
                            width: 150,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    _elementTile(
                      textValue: commande['prix'],
                      icon: Icons.money,
                      width: 70,
                    ),
                    Padding(
                      padding: EdgeInsets.all(0),
                      child: Column(
                        children: [
                          GestureDetector(
                              onTap: () {
                                _showDetailDialog(commande: commande);
                              },
                              child: Icon(
                                Icons.article,
                                color: Theme.of(context).primaryColor,
                              )),
                          SizedBox(
                            height: 30,
                          ),
                          GestureDetector(
                            onTap: () {
                              _showDeleteDialog(commande: commande);
                            },
                            child: Icon(
                              Icons.task_alt,
                              color: Colors.red[300],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
   _showDeleteDialog({Map commande}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Validé Retraie ${commande['nom']}'),
            content: Text('est_vous sûr de validé?'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Retour')),
              TextButton(
                onPressed: () {
                  reference.child(commande['key']).remove().whenComplete(() =>
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Retraie())));
                },
                child: Text('Validé'),
              )
            ],
          );
        });
  }
   _showDetailDialog({Map commande}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Detail'),
            actions: <Widget>[
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _elementTile(
                        textValue: commande['autre'],
                        icon: Icons.info,
                        width: 220),
                    SizedBox(
                      height: 20,
                    ),
                    _elementTile(
                        textValue: commande['heure'],
                        icon: Icons.time_to_leave,
                        width: 100),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: _elementTile(
                          textValue: commande['paye'],
                          icon: Icons.paid,
                          width: 100),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    _elementTile(
                        textValue: commande['reste'],
                        icon: Icons.money_off,
                        width: 100),
                  ],
                ),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'retour',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  )),
            ],
          );
        });
  }
  Widget _elementTile({
    @required String textValue,
    @required IconData icon,
    @required double width,
  }) {
    return SingleChildScrollView(
      child: Row(children: [
        Container(
          width: width,
          child: Row(
            children: [
              Icon(
                icon,
                color: Theme.of(context).primaryColor,
                size: 20,
              ),
              Text(textValue,
                  style: TextStyle(
                      fontSize: 15,
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ]),
    );
  }
  @override
  Widget build(BuildContext context) {
    int number = 0;
    return Scaffold(
      appBar: AppBar(
        title: Text('Retraie par type'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
            ),
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearch(),
              );
            },
          ),
          PopupMenuButton(
              onSelected: (item) => onSelect(context, item),
              itemBuilder: (context) => [
                    PopupMenuItem<int>(
                      value: 0,
                      child: Text('By Date'),
                    ),
                    PopupMenuItem<int>(
                      value: 1,
                      child: Text('By Type'),
                    ),
                  ])
        ],
      ),
      body: Container(
        height: double.infinity,
        child: FirebaseAnimatedList(
          query: _ref,
          itemBuilder: (BuildContext context, DataSnapshot snapshot,
              Animation<double> animation, int index) {
            number++;
            Map commande = snapshot.value;
            commande['key'] = snapshot.key;
            commande['id'] = number;
            print(commande);
            return _buildRetraieItem(commande: commande);
          },
        ),
      ),
    );
  }
onSelect(BuildContext context, item) {
    // ignore: unused_local_variable
    int number = 0;
    switch (item) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Date(),
          ),
        );

        break;
      case 1:
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Filter(),
          ),
        );
        break;
    }
    setState(() {});
  }
}

class CustomSearch extends SearchDelegate<Retraie> {
  List<Retraie> newList = [];
  final recent = [];
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: AnimatedIcon(
          icon: AnimatedIcons.arrow_menu,
          progress: transitionAnimation,
        ));
  }

  @override
  // ignore: missing_return
  Widget buildResults(BuildContext context) {}

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggest = query.isEmpty ? recent : newList;
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        leading: Icon(Icons.check),
        title: Text(suggest[index]),
      ),
      itemCount: suggest.length,
    );
  }

  
}