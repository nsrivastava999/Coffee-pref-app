import 'package:coffee_app/models/user.dart';
import 'package:coffee_app/services/databse.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Create user object based on firebase user(only with uid)
  User _userFromFirebaseUser(FirebaseUser user){
    return user != null ? User(uid:user.uid) : null;
  }

  //AuthChanged user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged
    .map( _userFromFirebaseUser);  
  }

  //Sigin Anonimously
  Future signInAnon() async{
    try{
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user) ;
    }
    catch(e){
      print(e.toString());
      return null;
    }
  } 

  //Signin with email and password
  Future signInWithEmailAndPassword(String email, String password) async{
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }

  //Registering with email and password
  Future registerWithEmailAndPassword(String email, String password) async{
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      
      //creating a new document for the user with uid
      await DatabaseService(uid:user.uid).updateUserData('0', 'neww member', 100);

      return _userFromFirebaseUser(user);
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }

  //Signout
  Future signOut() async{
    try{
      return await _auth.signOut();
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }
}