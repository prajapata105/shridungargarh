import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreApi {

  static Future uploadContacts(List<Contact> contacts) async {
    final contactsJson = contacts.map((contact) => contact.toMap()).toList();
    final refUser = FirebaseFirestore.instance.collection('usersmobile');
    await refUser.add({
      'contacts': contactsJson,
    });
  }
}

