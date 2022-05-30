import 'package:firebase_auth/firebase_auth.dart';
import 'package:tinder_for_movies/utils/imports.dart';
import 'package:flutterfire_ui/auth.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // User is not signed in
        if (!snapshot.hasData) {
          return SignInScreen(providerConfigs: [
            EmailProviderConfiguration(),
            GoogleProviderConfiguration(
              clientId: '...',
            ),
          ]);
        }

        // Render your application if authenticated
        return MovieHomeWidget();
      },
    );
  }
}
