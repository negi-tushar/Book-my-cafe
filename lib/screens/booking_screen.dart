import 'package:flutter/material.dart';
import 'package:restroapp/constants/constants.dart';

import 'package:restroapp/services/booking_methods.dart';
import 'package:intl/intl.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Booking History'),
        ),
        body: StreamBuilder(
          stream: BookingMethods().bookingHistory,
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: (snap.data! as dynamic).docs.length,
                itemBuilder: (context, index) {
                  var data = (snap.data! as dynamic).docs[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                        tileColor: Colors.white,
                        leading: const CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/images/background.jpg'),
                          radius: 40,
                        ),
                        title: Text(
                          data['restaurantName'],
                          style: kHeading,
                        ),
                        subtitle: Text(
                          'Booking for : ${DateFormat.yMMMEd().format(data['date'].toDate())}'
                              .toString(),
                          style: kLabel,
                        ),
                        trailing: data['booking_Status'] == "Success"
                            ? const CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.green,
                                child: Icon(Icons.done, color: Colors.white),
                              )
                            : const CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.red,
                                child: Icon(
                                  Icons.do_disturb,
                                  color: Colors.white,
                                ),
                              )),
                  );
                });
          },
        ));
  }
}
