import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/user.dart';
import 'message.dart';

class FirebaseProvider extends ChangeNotifier {
  ScrollController scrollController = ScrollController();
  List<UserModel> users = [];
  UserModel? user;
  UserModel? cUser;
  List<Message> messages = [];
  static Future<Message?> getLatestMessageForUser(String userId) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection("user")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("chat")
        .doc(userId)
        .collection("messages")
        .orderBy("sentTime", descending: true)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      return Message.fromJson(querySnapshot.docs.first.data());
    }
    return null;
  }
  // List<UserModel> search = [];
  // Map<String, String> latestMessages = {};
  // void fetchLatestMessage() {
  //   final currentUserUid = FirebaseAuth.instance.currentUser!.uid;
  //   for (var user in users) {
  //     FirebaseFirestore.instance
  //         .collection("user")
  //         .doc(user.uid)
  //         .collection('chat')
  //         .doc(FirebaseAuth.instance.currentUser!.uid)
  //         .collection('messages')
  //         .orderBy("sentTime", descending: true)
  //         .limit(1)
  //         .snapshots(includeMetadataChanges: true)
  //         .listen((messages) {
  //       if (messages.docs.isNotEmpty) {
  //         if (messages.docs.isNotEmpty &&
  //             messages.docs.first['senderId'] != currentUserUid) {
  //           latestMessages[user.uid] = messages.docs.first['content'];
  //         } else {
  //           latestMessages[user.uid] =
  //               ""; // Set an empty string if no message received
  //         }
  //         notifyListeners();
  //       }
  //     });
  //   }
  // }

  List<UserModel> getAllUsers() {
    FirebaseFirestore.instance
        .collection('user')
        .snapshots(includeMetadataChanges: true)
        .listen((users) {
      this.users =
          users.docs.map((doc) => UserModel.fromJson(doc.data())).toList();
      notifyListeners();
    });
    return users;
  }

  UserModel? getUserById(String userId) {
    FirebaseFirestore.instance
        .collection('user')
        .doc(userId)
        .snapshots(includeMetadataChanges: true)
        .listen((user) {
      this.user = UserModel.fromJson(user.data()!);
      notifyListeners();
    });
    return user;
  }

  UserModel? currentUser(String uid) {
    FirebaseFirestore.instance
        .collection('user')
        .doc(uid)
        .snapshots(includeMetadataChanges: true)
        .listen((cUser) {
      this.cUser = UserModel.fromJson(cUser.data()!);
      notifyListeners();
    });
    return cUser;
  }

  List<Message> getMessages(String receiverId) {
    FirebaseFirestore.instance
        .collection('user')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('chat')
        .doc(receiverId)
        .collection('messages')
        .orderBy("sentTime", descending: false)
        .snapshots(includeMetadataChanges: true)
        .listen((messages) {
      this.messages =
          messages.docs.map((doc) => Message.fromJson(doc.data())).toList();
      notifyListeners();
      scrollDown();
    });
    return messages;
  }

  void scrollDown() => WidgetsBinding.instance.addPostFrameCallback((_) {
        if (scrollController.hasClients) {
          scrollController.jumpTo(scrollController.position.maxScrollExtent);
        }
      });

  // Future<void> searchUser(String name) async {
  //   search =
  //       await FirebaseFirestoreService.searchUser(name);
  //   notifyListeners();
  // }
}
