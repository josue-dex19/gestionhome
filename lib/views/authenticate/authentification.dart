import 'package:firebase_auth/firebase_auth.dart';
import 'package:gestionhome/models/user.dart';

class AuthenticationService{

  // instanciation de firebase

  final FirebaseAuth _auth= FirebaseAuth.instance;

  AppUser _userFromfirebaseUser(User user){
    return user !=null ? AppUser(uid: user.uid): null;
  }

 Stream<AppUser> get user {
   return _auth.authStateChanges().map(_userFromfirebaseUser);
 }

  // utilisateur deja inscrit dans la base de firebase

  Future signInWithEmailAndPassword( String email, String passeword) async{
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: passeword);
    User user = result.user;
    return _userFromfirebaseUser(user);
    }catch(exception){
      print(exception.toString());
      return null;
    }
  }

  // nouveau inscrit dans la base de firebase

  Future registerWithEmailAndPassword(String email, String passeword) async{
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: passeword);
    User user = result.user;

    return _userFromfirebaseUser(user);
    }catch(exception){
      print(exception.toString());
      return null;
    }
  }

// methode de deconnection

  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(exception){
      print(exception.toString());
      return null;
    }
  }
  //methode de verification
  // Future <bool> Connect(Stream<AppUser>stream)async{
  //   dynamic Connect =true;
  //   if (user == Connect) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }
}