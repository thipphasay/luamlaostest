import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class LuamlaosFirebaseUser {
  LuamlaosFirebaseUser(this.user);
  final User user;
  bool get loggedIn => user != null;
}

LuamlaosFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<LuamlaosFirebaseUser> luamlaosFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<LuamlaosFirebaseUser>(
            (user) => currentUser = LuamlaosFirebaseUser(user));
