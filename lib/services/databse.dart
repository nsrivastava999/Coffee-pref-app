import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_app/models/coffee.dart';
import 'package:coffee_app/models/user.dart';

class DatabaseService {

  final String uid ;
  DatabaseService({this.uid});

  //collection Reference
  final CollectionReference coffeeCollection = Firestore.instance.collection('coffees');

  Future updateUserData(String sugar, String name, int strength) async{
    return await coffeeCollection.document(uid).setData({
      'sugar' : sugar,
      'name' : name,
      'strength' : strength
    }) ;
  }

  //making coffee list from snapshots
  List<Coffee> _coffeeListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Coffee(
        name: doc['name'] ?? '',
        sugar: doc['sugar'] ?? '0',
        strength: doc['strength'] ?? 0,
      );
    }).toList();
  }

  //snapshot to userdata function
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
    return UserData(
      uid:uid,
      name:snapshot.data['name'],
      sugar:snapshot.data['sugar'],
      strength:snapshot.data['strength']
    );
  }

  //get coffee stream
  Stream<List<Coffee>> get coffee {
    return coffeeCollection.snapshots()
    .map(_coffeeListFromSnapshot);
  }

  //getting user document as a stream
  Stream<UserData> get userData{
    return coffeeCollection.document(uid).snapshots()
    .map(_userDataFromSnapshot);
  }

}