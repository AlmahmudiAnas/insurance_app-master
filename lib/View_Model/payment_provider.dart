import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PaymentProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool isLoading = false;

  Future<void> simulatePaymentProcess(String userUid, context) async {
    try {
      isLoading = true;
      notifyListeners();

      // Check if the user has a card in the "card" collection
      final cardSnapshot = await _firestore
          .collection('card')
          .where('uid', isEqualTo: userUid)
          .get();

      if (cardSnapshot.docs.isNotEmpty) {
        // User has a card, simulate the payment process
        await Future.delayed(Duration(seconds: 2));

        // Generate a random payment status (true for success, false for failure)
        // bool isPaymentSuccessful = Random().nextBool();

        bool isPaymentSuccessful = true;

        if (isPaymentSuccessful) {
          // Payment was successful

          // Display a payment confirmation message
          Fluttertoast.showToast(
            msg: "Payment successful!",
            toastLength: Toast.LENGTH_LONG,
            backgroundColor: Colors.green,
          );
        } else {
          // Payment failed
          // Display a payment failure message
          Fluttertoast.showToast(
            msg: "Payment failed. Please try again.",
            toastLength: Toast.LENGTH_LONG,
            backgroundColor: Colors.red,
          );
        }
      } else {
        // User does not have a card, display a message to add a card
        Fluttertoast.showToast(
          msg: "Please add a card before making a payment.",
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: Colors.yellow,
        );
      }

      isLoading = false;
      notifyListeners();
    } catch (error) {
      // Handle any errors that occur during the payment simulation
      print('Error simulating payment process: $error');
      throw error;
    }
  }

  Future<void> addCardData(
    String userUid,
    String nameOnCard,
    String cardNumber,
    String cvcNumber,
    String expireDate,
  ) async {
    try {
      isLoading = true;
      notifyListeners();
      await _firestore.collection('card').add({
        'uid': userUid,
        'nameOnCard': nameOnCard,
        'cardNumber': cardNumber,
        'cvcNumber': cvcNumber,
        'expireDate': expireDate,
      });
      Fluttertoast.showToast(
        msg: "Card added succefully",
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.green,
      );
      isLoading = false;
      notifyListeners();
    } catch (error) {
      // Handle any errors that occur during the data upload
      print('Error adding card data: $error');
      throw error;
    }
  }

  CollectionReference userCard = FirebaseFirestore.instance.collection('card');
  String docId = '';

  Future<DocumentSnapshot<Map<String, dynamic>>> getCardData(
      String userUid) async {
    final QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
        .collection('card')
        .where('uid', isEqualTo: userUid)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      final DocumentSnapshot<Map<String, dynamic>> snapshot =
          querySnapshot.docs.first;
      final String documentId = snapshot.id;
      docId = documentId;
      print(snapshot);
      return snapshot;
    }

    throw Exception('No card data found');
  }

  Future<void> deleteDocumentFromFirebase() async {
    isLoading = true;
    notifyListeners();
    try {
      print(docId);
      await FirebaseFirestore.instance.collection('card').doc(docId).delete();

      print('Document deleted successfully');
      Fluttertoast.showToast(
        msg: "Document has been Deleted",
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.white,
      );
      isLoading = false;
      notifyListeners();
    } catch (error) {
      print('Failed to delete document: $error');
      Fluttertoast.showToast(
        msg: "$error",
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.white,
      );
      isLoading = false;
      notifyListeners();
    }
  }
}
