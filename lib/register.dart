import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqlflite/login.dart';
import 'package:sqlflite/sqlflite.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  TextEditingController? username;
  TextEditingController? email;
  TextEditingController? password;

  SqlDatabase sqlDatabase = SqlDatabase();

  @override
  void initState() {
    super.initState();
    username = TextEditingController();
    email = TextEditingController();
    password = TextEditingController();
  }

  @override
  dispose() {
    super.dispose();
    username!.dispose();
    email!.dispose();
    password!.dispose();
  }

  void showAlertDialog(BuildContext context, String text, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(text),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Close the dialog
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void register() async {
    if (formstate.currentState!.validate()) {
     
      // ignore: iterable_contains_unrelated_type
     
        int response = await sqlDatabase.insert("users", {
          "username": username!.text,
          "email": email!.text,
          "password": password!.text,
        });
        if (response > 0) {
          print("response ===================================== $response");

          // ignore: use_build_context_synchronously
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const SignIn(),
            ),
          );
        } else {
          // ignore: use_build_context_synchronously
          showAlertDialog(context, "alert", "invalid Register");
        }
    
    } else {
      // ignore: use_build_context_synchronously
      showAlertDialog(context, "alert", "invalid Data");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Form(
          key: formstate,
          child: ListView(
            children: [
              Image.asset(
                "assets/note.png",
                fit: BoxFit.scaleDown,
                color: Colors.redAccent,
                height: 250,
                width: double.infinity,
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Can't be Empty";
                  }
                  return null;
                },
                onSaved: (newValue) => username!.text = newValue!,
                decoration: const InputDecoration(
                  hintText: 'Enter your username',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.lightBlueAccent, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                ),
                controller: username,
              ),
              const SizedBox(
                height: 13,
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "please enter your email ";
                  }
                  return null;
                },
                onSaved: (newValue) => email!.text = newValue!,
                decoration: const InputDecoration(
                  hintText: 'Enter your email',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.lightBlueAccent, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                ),
                controller: email,
              ),
              const SizedBox(
                height: 13,
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "please enter your password ";
                  }
                  return null;
                },
                onSaved: (newValue) => password!.text = newValue!,
                decoration: const InputDecoration(
                  hintText: 'Enter your Password',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.lightBlueAccent, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                ),
                controller: password,
              ),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: const Text("If you Have an account"),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const SignIn(),
                        ),
                      );
                    },
                    child: const Text(
                      "Click Here",
                      style: TextStyle(
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 13),
                    ),
                  ),
                ],
              ),
              Material(
                elevation: 5.0,
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(30.0),
                child: MaterialButton(
                  onPressed: () {
                    register();
                  },
                  child: const Text(
                    "SignUp",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                ),
              ),
              InkWell(
                  onTap: () {
                    sqlDatabase.deleteAllDataBase();
                  },
                  child: Text("Delete database"))
            ],
          ),
        ),
      ),
    );
  }
}
