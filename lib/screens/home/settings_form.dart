import 'package:coffee_app/services/databse.dart';
import 'package:coffee_app/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:coffee_app/models/user.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formkey = GlobalKey<FormState>();
  final List<String> sugars = ['0','1','2','3','4','5'];

  String _currentName;
  String _currentSugar;
  int _currentStrength;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid:user.uid).userData,
      builder: (context, snapshot) {
        if(snapshot.hasData){

          UserData userData = snapshot.data;

          return Form(
            key: _formkey,
            child: Column(
              children:<Widget>[
                Text('Update your Coffee Preferences',
                  style: TextStyle(
                    fontSize: 20
                  ),   
                ),
                SizedBox(height:20),
                TextFormField(
                  initialValue: userData.name,
                  validator: (val) => val.isEmpty ? 'Enter your Name' : null,
                  decoration: InputDecoration(
                    labelText: 'Name',
                  ),
                  onChanged: (val) {
                    setState(() {
                      _currentName = val;
                    });
                  }
                ),
                SizedBox(height:20),
                DropdownButtonFormField(
                  value: _currentSugar ?? userData.sugar,
                  decoration: InputDecoration(
                    labelText: 'Sugars',
                  ),
                  items: sugars.map((sugar) {
                    return DropdownMenuItem(
                      value: sugar,
                      child: Text('$sugar tsp'),
                    );
                  }).toList(),
                  onChanged: (val) => setState(() => _currentSugar = val ),
                ),
                SizedBox(height:20),
                Slider(
                  label: 'Strength',
                  activeColor: Colors.brown[_currentStrength ?? userData.strength],
                  inactiveColor: Colors.brown[_currentStrength ?? userData.strength],
                  min: 100,
                  max: 900,
                  divisions: 8,
                  onChanged: (val){
                    setState(() {
                      _currentStrength=val.round();
                    });
                  },
                  value:(_currentStrength??userData.strength).toDouble() ,
                ),
                RaisedButton(
                  color:Colors.red ,
                  child: Text('Update',
                    style: TextStyle(color:Colors.white),
                  ),    
                  onPressed: () async{
                    // print(_currentName);
                    // print(_currentStrength);
                    // print(_currentSugar);
                    if(_formkey.currentState.validate()){
                      await DatabaseService(uid:user.uid).updateUserData(
                        _currentSugar ?? userData.sugar,
                        _currentName ?? userData.name, 
                        _currentStrength ?? userData.strength
                      );
                    Navigator.pop(context);
                    }
                  },
                )
              ]
            ),      
          );
        }
        else{
          return Loading();
        }
        
      }
    );
  }
}