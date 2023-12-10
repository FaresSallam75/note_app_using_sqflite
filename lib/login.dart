import 'package:flutter/material.dart';
import 'package:sqlflite/main.dart';
import 'package:sqlflite/register.dart';
import 'package:sqlflite/sqlflite.dart';
import 'package:sqlflite/viewnotes.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  TextEditingController? email;
  TextEditingController? password;

  SqlDatabase sqlDatabase = SqlDatabase();

  @override
  void initState() {
    super.initState();
    email = TextEditingController();
    password = TextEditingController();
  }

  @override
  dispose() {
    super.dispose();
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

  void login() async {
    //if (formstate.currentState!.validate()) {
    List<Map> response = await sqlDatabase.readData(''' 
                    SELECT * FROM users WHERE 
                    email    = "${email!.text}" And 
                    password = "${password!.text}" 
                    ''');
    if (response.isNotEmpty) {
      print(
          "response ================================================== $response ");
      /* SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance(); */

      sharedPreferences!.setString("id", response[0]['id'].toString());
      sharedPreferences!.setString("email", email!.text);
      sharedPreferences!.setString("password", password!.text);
      print(
          "email =================== ${sharedPreferences!.getString("email")}");
      print("id =================== ${response[0]['id']} ");
      print(
          "password =================== ${sharedPreferences!.getString("password")}");
      // ignore: use_build_context_synchronously
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const ViewNotes()),
          (route) => false);
    } else {
      // ignore: use_build_context_synchronously
      showAlertDialog(context, "alert", "invalid login");
    }
    // }
    /* else {
      // ignore: use_build_context_synchronously
      showAlertDialog(context, "alert !!", "invalid Data");
    } */
  }

  /*  Future setSP(UserModel user) async {
    final SharedPreferences sp = await _pref;
    sp.setString("email", user.email!);
    sp.setString("password", user.password!);
  } */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign in", style: TextStyle(color: Colors.white)),
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
                color: Colors.redAccent,
                height: 250,
                width: double.infinity,
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please Enter Your Email ";
                  } else {
                    return null;
                  }
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
                    return "Please Enter Your password";
                  } else {
                    return null;
                  }
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
                    child: const Text("If you Have Not an account"),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const SignUp(),
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
                    login();
                  },
                  child: const Text(
                    "Sign In",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
