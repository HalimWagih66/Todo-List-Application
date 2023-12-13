import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_list_application/Features/auth/model/info_user_model.dart';
import 'package:todo_list_application/Features/auth/model/base_user_model.dart';

class UsersDao{
  static CollectionReference<BaseUserModel> getUsersCollection(){
    return FirebaseFirestore.instance.
    collection(InformationUserModel.collectionName)
        .withConverter<BaseUserModel>(
        fromFirestore: (snapshot, options) =>
            InformationUserModel.formFireStore(snapshot.data()),
        toFirestore: (value, options) => value.toFireStore(),
    );
  }
  static Future<void> createUser(BaseUserModel userModel)async{
    var usersCollection = getUsersCollection();
    var doc = usersCollection.doc(userModel.id);
    await doc.set(userModel);
  }
  static Future<void> removeUser(String uId)async{
    var usersCollection = getUsersCollection();
    var doc = usersCollection.doc(uId);
    await doc.delete();
  }
  static Future<BaseUserModel?> getUser(String uid)async{
    var doc = getUsersCollection().doc(uid);
    var docSnapshot = await doc.get();
    return docSnapshot.data();
  }
}