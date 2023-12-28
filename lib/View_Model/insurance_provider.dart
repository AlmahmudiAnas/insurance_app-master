import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class InsuranceProvider extends ChangeNotifier {
  bool isLoading = false;

  String generateRandomInsuranceNumber() {
    final random = Random();
    final digits =
        random.nextInt(900000) + 100000; // Generate a 6-digit random number
    final insuranceNumber =
        'INS-$digits'; // Combine random digits with a timestamp

    return insuranceNumber;
  }

  Future<String?> uploadPdfToFirebase(
      File pdfFile, String uniqueFilename) async {
    try {
      // Create a reference to the PDF file in Firebase Storage
      final storageReference =
          FirebaseStorage.instance.ref().child(uniqueFilename);
      isLoading = true;
      notifyListeners();
      // Upload the PDF file to Firebase Storage
      final uploadTask = storageReference.putFile(pdfFile);
      final snapshot = await uploadTask.whenComplete(() {});

      // Check if the upload was successful
      if (snapshot.state == TaskState.success) {
        // Get the download URL of the uploaded PDF
        final downloadURL = await storageReference.getDownloadURL();
        // Fluttertoast.showToast(
        //   msg: "Paid and Successfully uploaded pdf",
        //   toastLength: Toast.LENGTH_LONG,
        //   backgroundColor: Colors.black,
        // );
        isLoading = false;
        notifyListeners();
        return downloadURL;
      } else {
        isLoading = false;
        notifyListeners();
        return null;
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "$e",
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.red,
      );
      isLoading = false;
      notifyListeners();
      print('Error uploading PDF: $e');
      return null;
    }
  }

  Future<File> getTemporaryPdfFile() async {
    final output = await getTemporaryDirectory();
    final outputFile = File('${output.path}/filled_form.pdf');
    return outputFile;
  }

  Future<void> deleteDocumentFromFirebase(pdfUrl, documentId) async {
    isLoading = true;
    notifyListeners();
    try {
      final storageReference = FirebaseStorage.instance.refFromURL(pdfUrl);
      await FirebaseFirestore.instance
          .collection('Insurances')
          .doc(documentId)
          .delete();

      await storageReference.delete();
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

  void checkExpirationDates() {
    Timer.periodic(Duration(hours: 1), (Timer timer) async {
      final currentDate = DateTime.now();

      final snapshot =
          await FirebaseFirestore.instance.collection('Insurances').get();

      for (final document in snapshot.docs) {
        final expirationDate = document['expirationDate'];

        if (expirationDate != null && currentDate.isAfter(expirationDate)) {
          // Insurance has expired, delete it from Firestore
          await document.reference.delete();
        }
      }
    });
  }
}
