import 'package:flutter/material.dart';
import 'package:coffee_app/models/coffee.dart';

class CoffeeTile extends StatelessWidget {

  final Coffee coff;
  CoffeeTile({this.coff});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top:10),
        child: Card(
          color: Colors.green[400],
          margin:EdgeInsets.fromLTRB(20, 6, 20, 0),
          child: ListTile(
            leading:CircleAvatar(
              backgroundImage: AssetImage('assets/coffee_icon.png'),
                radius:25 ,
                backgroundColor: Colors.brown[coff.strength] ,
              ),
            title: Text(coff.name,
              style: TextStyle(
                color:Colors.white,
                fontSize: 20,
              ),
            ),
            subtitle: Text('with ${coff.sugar} sugar(s).',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      );
  }
}