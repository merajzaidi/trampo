import 'package:Trampo/screens/login_screen.dart';
import 'package:Trampo/screens/phone.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:Trampo/screens/auth_screen.dart';
import 'package:Trampo/screens/register_screen.dart';
import './providers/auth.dart';
import './constants/colorConstant.dart';
import './screens/HomePage_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Auth(),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light().copyWith(
            primaryColor: kprimaryColor,
            appBarTheme: AppBarTheme(
              elevation: 3.0,
            ),
          ),
          home: auth.isAuth ? HomePage() : PhoneAuthentication(),
          routes: {
            HomePage.routeName: (context) => HomePage(),
          },
        ),
      ),
    );
  }
}
