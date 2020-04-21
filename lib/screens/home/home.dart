import 'package:coffee_app/models/coffee.dart';
import 'package:coffee_app/screens/home/settings_form.dart';
import 'package:coffee_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:coffee_app/services/databse.dart';
import 'package:provider/provider.dart';
import 'package:coffee_app/screens/home/coffee_list.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel(){
      showModalBottomSheet(context: context, builder:(context){
        return Container(
          padding: EdgeInsets.symmetric(vertical:20,horizontal:50),
          color: Colors.green[300],
          child: SettingsForm(),
        );
      });
    }

    return StreamProvider<List<Coffee>>.value(
      value: DatabaseService().coffee,
      child: Scaffold(
        backgroundColor: Colors.green[200],
        appBar: AppBar(
          title: Text('Coffee Choices'),
          backgroundColor: Colors.green[700],
          actions: <Widget>[
            FlatButton.icon(
                onPressed: () async {
                  await _auth.signOut();
                },
                icon: Icon(Icons.person, color: Colors.white),
                label: Text(
                  'Log Out',
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
        body: Container(
          child: CoffeeList(),
          // decoration: BoxDecoration(
          //   image:DecorationImage(
          //     image:AssetImage('assets/coffee_bg.png'),
          //     fit:BoxFit.cover,
          //   )
          // ),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed:() => _showSettingsPanel(),
            backgroundColor: Colors.green[700],
            child: Icon(Icons.settings),
          ),
      ),
    );
  }
}
