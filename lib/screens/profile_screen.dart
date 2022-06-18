import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:restroapp/constants/constants.dart';
import 'package:restroapp/provider/userProvider.dart';
import 'package:restroapp/services/auth.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userDetail = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Column(children: [
          Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: ListTile(
              title: Text(
                userDetail.name,
                style: kHeading,
              ),
              subtitle: Text(
                userDetail.email,
                style: kLabel,
              ),
              trailing: const CircleAvatar(
                child: const Icon(Icons.person),
                radius: 40,
              ),
            ),
          ),
          if (userDetail.mobile.isNotEmpty)
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              margin: const EdgeInsets.all(10),
              child: ListTile(
                leading: const Icon(Icons.phone),
                title: const Text('Mobile'), subtitle: Text(userDetail.mobile),
                trailing: const Icon(Icons.arrow_right),
                // tileColor: Colors.white,
                onTap: () {},
              ),
            ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            margin: const EdgeInsets.all(10),
            child: ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              trailing: const Icon(Icons.arrow_right),
              // tileColor: Colors.white,
              onTap: () {
                SignIn().signOut();
              },
            ),
          ),
        ]),
      ),
    );
  }
}
