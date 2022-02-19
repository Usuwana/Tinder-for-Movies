import 'package:firebase_auth/firebase_auth.dart';
import 'package:tinder_for_movies/screens/signup.dart';
import 'package:tinder_for_movies/utils/fire_auth.dart';
import 'package:tinder_for_movies/utils/imports.dart';
import 'package:tinder_for_movies/utils/validator.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();

  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  FocusNode _focusEmail = new FocusNode();
  FocusNode _focusPassword = new FocusNode();

  /*Future<FirebaseApp> _initializeFirebase() async {
    //FirebaseApp firebaseApp = await Firebase.initializeApp();

    //return firebaseApp;
      FirebaseApp firebaseApp = await Firebase.initializeApp();
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => ProfilePage(
              user: user,
            ),
          ),
        );
      }
      return firebaseApp;

  }*/

  @override
  Widget build(BuildContext context) {
    Future<FirebaseApp> _initializeFirebase() async {
      //FirebaseApp firebaseApp = await Firebase.initializeApp();

      //return firebaseApp;
      FirebaseApp firebaseApp = await Firebase.initializeApp();
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => ProfilePage(
              user: user,
            ),
          ),
        );
      }
      return firebaseApp;
    }

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          title: Center(child: Text("AIDBox Companion"))),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: _initializeFirebase(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Column(
                children: [
                  SizedBox(height: 50.0),
                  Text('Login',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                  SizedBox(height: 50.0),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 30.0, right: 30.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: "Email...",
                            ),
                            controller: _emailTextController,
                            focusNode: _focusEmail,
                            validator: (value) =>
                                Validator.validateEmail(email: value as String),
                          ),
                        ),
                        SizedBox(height: 50.0),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 30.0, right: 30.0),
                          child: TextFormField(
                            decoration:
                                InputDecoration(labelText: "Password..."),
                            controller: _passwordTextController,
                            focusNode: _focusPassword,
                            obscureText: true,
                            validator: (value) => Validator.validatePassword(
                                password: value as String),
                          ),
                        ),
                        SizedBox(height: 50.0),
                        TextButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              User? user =
                                  await FireAuth.signInUsingEmailPassword(
                                email: _emailTextController.text,
                                password: _passwordTextController.text,
                                context: context,
                              );
                              if (user != null) {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ProfilePage(user: user)),
                                );
                              }
                            }
                          },
                          child: Text(
                            'Sign-in',
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.blueAccent),
                              padding: MaterialStateProperty.all(
                                  EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 80)),
                              textStyle: MaterialStateProperty.all(
                                  TextStyle(fontSize: 18))),
                        ),
                        SizedBox(height: 50.0),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => SignUp()),
                            );
                          },
                          child: Text(
                            'Register',
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.blueAccent),
                              padding: MaterialStateProperty.all(
                                  EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 80)),
                              textStyle: MaterialStateProperty.all(
                                  TextStyle(fontSize: 18))),
                        ),
                        SizedBox(height: 50.0),
                        TextButton(
                          onPressed: () async {
                            await FirebaseAuth.instance.sendPasswordResetEmail(
                                email: _emailTextController.text);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('Password Reset Email Sent!')));
                          },
                          child: Text(
                              'Forgot Password? Make sure you have typed in the email address field'),
                        )
                      ],
                    ),
                  )
                ],
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
