import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restroapp/provider/location_provider.dart';
import 'package:restroapp/provider/restaurants_provider.dart';
import 'package:restroapp/provider/userProvider.dart';
import 'package:restroapp/screens/homescreen.dart';
import 'package:restroapp/screens/login_screen.dart';
import 'package:restroapp/screens/restaurants_scree.dart';
import 'package:restroapp/screens/signup_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:restroapp/widgets/bottom_navigationbar.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LocationProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => RestaurantsProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Book My Cafe',
        theme: ThemeData(
          primarySwatch: Colors.brown,
        ),
        home: StreamBuilder(
          stream: auth.authStateChanges(),
          builder: (context, snap) {
            //print(snap.data);
            if (snap.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snap.hasData) {
              return const MyBottomNavigationBar();
            }
            if (snap.hasError) {
              return const LoginScreen();
            }
            return const LoginScreen();
          },
        ),
        routes: {
          LoginScreen.id: (context) => const LoginScreen(),
          SignupScreen.id: (context) => const SignupScreen(),
          HomeScreen.id: (context) => const HomeScreen(),
          RestaurantScreen.id: (context) => const RestaurantScreen(),
          MyBottomNavigationBar.id: (context) => MyBottomNavigationBar(),
        },
      ),
    );
  }
}
