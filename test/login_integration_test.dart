import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mockito/mockito.dart';
import 'package:fasilah_m1/features/registration/login/cubit/login_cubit.dart';

void main() {
  setUpAll(() async {
    await Firebase.initializeApp();
  });

  testWidgets('User authentication test', (WidgetTester tester) async {
    final email = 'leen9@gmail.com';
    final password = '123456789';

    final authService = LoginCubit();

    final mockAuth = MockFirebaseAuth();
    when(mockAuth.signInWithEmailAndPassword(email: email, password: password))
        .thenAnswer((_) async => MockUserCredential());

    // authService.setFirebaseAuth(mockAuth);

    final user = await authService.userLogin(email: email, password: password);

    expect(user, isNotNull);

    // await authService.signOut();
  });
}

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockFirebaseUser extends Mock implements User {}

class MockUserCredential extends Mock implements UserCredential {}
