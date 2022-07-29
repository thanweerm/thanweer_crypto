import 'package:cryptonew/authenticaiton/data/providers/authentication_firebase_provider.dart';
import 'package:cryptonew/authenticaiton/data/providers/google_sign_in_provider.dart';
import 'package:cryptonew/authenticaiton/models/authentication_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationRepository {
  //authentication and google sign in
  final AuthenticationFirebaseProvider _authenticationFirebaseProvider;
  final GoogleSignInProvider _googleSignInProvider;
  AuthenticationRepository(
      {required AuthenticationFirebaseProvider authenticationFirebaseProvider,
      required GoogleSignInProvider googleSignInProvider})
      : _googleSignInProvider = googleSignInProvider,
        _authenticationFirebaseProvider = authenticationFirebaseProvider;

  Stream<AuthenticationModel> getAuthDetailStream() {
    return _authenticationFirebaseProvider.getAuthStates().map((user) {
      return _getAuthCredentialFromFirebaseUser(user: user);
    });
  }

  Future<AuthenticationModel> authenticateWithGoogle() async {
    // authentication with google
    User? user = await _authenticationFirebaseProvider.login(
        credential: await _googleSignInProvider.login());
    return _getAuthCredentialFromFirebaseUser(user: user);
  }

  Future<void> unAuthenticate() async {
    await _googleSignInProvider.logout();
    await _authenticationFirebaseProvider.logout();
  }

  AuthenticationModel _getAuthCredentialFromFirebaseUser(
      {required User? user}) {
    AuthenticationModel authDetail;
    if (user != null) {
      authDetail = AuthenticationModel(
        isValid: true,
        name: user.displayName,
      );
    } else {
      authDetail = AuthenticationModel(isValid: false);
    }
    return authDetail;
  }
}
