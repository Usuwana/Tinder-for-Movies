import 'package:firebase_auth/firebase_auth.dart';
import 'package:tinder_for_movies/utils/fire_auth.dart';
import 'package:tinder_for_movies/utils/imports.dart';
import 'package:tinder_for_movies/utils/validator.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _registerFormKey = GlobalKey<FormState>();

  final _nameTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  final _focusName = FocusNode();
  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();

  bool _isProcessing = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusName.unfocus();
        _focusEmail.unfocus();
        _focusPassword.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.blueAccent,
            title: Center(child: Text("AIDBox Companion"))),
        body: SingleChildScrollView(
          child: Form(
            key: _registerFormKey,
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Admin Registration",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 50.0),
                Padding(
                  padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                  child: TextFormField(
                    controller: _emailTextController,
                    focusNode: _focusEmail,
                    validator: (value) => Validator.validateEmail(
                      email: value as String,
                    ),
                    decoration: InputDecoration(
                      labelText: "Email...",
                      errorBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(6.0),
                        borderSide: BorderSide(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 50.0),
                Padding(
                  padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                  child: TextFormField(
                    controller: _nameTextController,
                    focusNode: _focusName,
                    validator: (value) => Validator.validateName(
                      name: value as String,
                    ),
                    decoration: InputDecoration(
                      labelText: "Name...",
                      errorBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(6.0),
                        borderSide: BorderSide(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 50.0),
                Padding(
                  padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                  child: TextFormField(
                    controller: _passwordTextController,
                    focusNode: _focusPassword,
                    obscureText: true,
                    validator: (value) => Validator.validatePassword(
                      password: value as String,
                    ),
                    decoration: InputDecoration(
                      labelText: "Password...",
                      errorBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(6.0),
                        borderSide: BorderSide(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 50.0),
                _isProcessing
                    ? CircularProgressIndicator()
                    : TextButton(
                        onPressed: () async {
                          setState(() {
                            _isProcessing = true;
                          });

                          if (_registerFormKey.currentState!.validate()) {
                            User? user =
                                await FireAuth.registerUsingEmailPassword(
                              name: _nameTextController.text,
                              email: _emailTextController.text,
                              password: _passwordTextController.text,
                            );

                            setState(() {
                              _isProcessing = false;
                            });

                            if (user != null) {
                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (context) {},
                                ),
                                ModalRoute.withName('/'),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          'Successfully created new admin')));
                            }
                          }
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
