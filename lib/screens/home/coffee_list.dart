import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coffee_app/models/coffee.dart';
import 'package:coffee_app/screens/home/coffee_tile.dart';


class CoffeeList extends StatefulWidget {
  @override
  _CoffeeListState createState() => _CoffeeListState();
}

class _CoffeeListState extends State<CoffeeList> {
  @override
  Widget build(BuildContext context) {

    final coffee = Provider.of<List<Coffee>>(context) ?? [];
    coffee.forEach((coff){
      print(coff.name);
      print(coff.strength);
      print(coff.strength);
    });

    return ListView.builder(
      itemBuilder: (context,index){
        return CoffeeTile(coff:coffee[index]);
      },
      itemCount: coffee.length,
      );
  }
}