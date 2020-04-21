import 'package:coffee_app/services/auth.dart';
import 'package:coffee_app/shared/loading.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.green[200],
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        title: Text('Sign up to CoFFee Choices'),
        actions: <Widget>[
          FlatButton.icon(
            onPressed: () {
              widget.toggleView();
            },
            icon: Icon(
              Icons.person,
              color: Colors.white,
            ),
            label: Text(
              'Sign In',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
                      child: Column(
              children: <Widget>[
                SizedBox(height: 20),
                TextFormField(
                  validator: (val) => val.isEmpty ? 'Enter an Email' : null,
                  onChanged: (val) {
                    setState(() {
                      email = val;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Email',
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  validator: (val) =>
                      val.length < 6 ? 'Enter atleast 6 chars.' : null,
                  onChanged: (val) {
                    setState(() {
                      password = val;
                    });
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                  ),
                ),
                SizedBox(height: 20),
                RaisedButton(
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      // print(email);
                      // print(password);
                      setState(() {
                        loading=true;
                      });
                      dynamic result = await _auth.registerWithEmailAndPassword(
                          email, password);
                      if (result == null) {
                        setState(() {
                          error = 'Please enter a valid email/Password';
                          loading=false;
                        });
                      }
                    }
                  },
                  child: Text(
                    'Register',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  color: Colors.green[600],
                ),
                SizedBox(height: 12),
                Text(error,
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
                SizedBox(height: 20),
                Text('Already a User? Sign In Now!')
              ],
            ),
          ),
        ),
      ),
    );
  }
}
