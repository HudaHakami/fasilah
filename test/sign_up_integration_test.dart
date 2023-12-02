import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fasilah_m1/features/registration/sign_up/cubit/sign_up_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  );
  // define the user first
  const String testName = 'Alshaimaa Mazen';
  const String testEmail = 'shai999@gmail.com';
  const String testPassword = 'SomePass074';
  const String testType = 'doctor';

  testWidgets('Sign up integration test', (WidgetTester tester) async {

    await SignUpCubit().signUp(
      name: testName,
      email: testEmail,
      password: testPassword,
      type: testType,
    );

    // Retrieve the user from Firestore
    final userSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: testEmail)
        .get();

    expect(userSnapshot.docs, isNotEmpty);

    final userData = userSnapshot.docs.first.data() as Map<String, dynamic>;
    expect(userData['name'], testName);
    expect(userData['email'], testEmail);
    expect(userData['type'], testType);

   // delete the test user from Firebase
    await FirebaseAuth.instance.currentUser?.delete();
  });
}
