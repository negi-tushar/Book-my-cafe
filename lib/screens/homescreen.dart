import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restroapp/constants/constants.dart';
import 'package:restroapp/provider/location_provider.dart';

import 'package:restroapp/provider/restaurants_provider.dart';
import 'package:restroapp/provider/userProvider.dart';
import 'package:restroapp/screens/restaurants_scree.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const String id = '/HomeScreen';
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final restaurantsData =
        Provider.of<RestaurantsProvider>(context).restaurants;
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: restaurantsData.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
              child: Container(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 5),
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 15),
                        decoration: BoxDecoration(
                          color: Colors.brown.shade100,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hi ${Provider.of<UserProvider>(context).getUser.name}!',
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            kHeightSpacer(5),
                            Row(
                              children: [
                                const Icon(
                                  Icons.pin_drop_rounded,
                                  color: Colors.brown,
                                ),
                                Expanded(
                                  child: Text(
                                    Provider.of<LocationProvider>(context)
                                        .currentAddress!
                                        .placeName,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                        child: Text(
                          'Popular restaurants around you',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: restaurantsData.length,
                        itemBuilder: ((context, index) {
                          var data = restaurantsData[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, RestaurantScreen.id,
                                  arguments: data);
                            },
                            child: Container(
                              //  width: double.infinity,
                              padding: const EdgeInsets.all(8),
                              margin: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.grey,
                                  ),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Image(
                                    image: NetworkImage(
                                        'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80'),
                                    height: 200,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    // color: Colors.black,
                                  ),
                                  kHeightSpacer(20),

                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          data.name,
                                          overflow: TextOverflow.clip,
                                          style: kHeading,
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(1),
                                        width: 55,
                                        height: 22,
                                        decoration: BoxDecoration(
                                            color: Colors.green,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Text(
                                          '${data.rating} ⋆',
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                  //  kHeightSpacer(5),

                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          data.address,
                                          overflow: TextOverflow.ellipsis,
                                          style: kLabel,
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(2),
                                        width: 55,
                                        height: 22,
                                        decoration: BoxDecoration(
                                            color: Colors.grey.shade200,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Text(
                                          '${data.distance} kms',
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 10),
                                        ),
                                      ),
                                    ],
                                  ),

                                  // ListTile(
                                  //   leading: Column(
                                  //       mainAxisAlignment:
                                  //           MainAxisAlignment.center,
                                  //       crossAxisAlignment:
                                  //           CrossAxisAlignment.start,
                                  //       children: [
                                  //         Text(
                                  //           data.name,
                                  //           overflow: TextOverflow.clip,
                                  //           style: kHeading,
                                  //         ),
                                  //         kHeightSpacer(10),
                                  //         Text(
                                  //           data.address,
                                  //           style: kLabel,
                                  //         ),
                                  //       ]),
                                  // ),
                                  //   trailing: Column(
                                  //       mainAxisAlignment: MainAxisAlignment.end,
                                  //       crossAxisAlignment:
                                  //           CrossAxisAlignment.end,
                                  //       children: [
                                  //         Container(
                                  //           padding: const EdgeInsets.all(2),
                                  //           width: 50,
                                  //           height: 22,
                                  //           decoration: BoxDecoration(
                                  //               color: Colors.green,
                                  //               borderRadius:
                                  //                   BorderRadius.circular(5)),
                                  //           child: Text(
                                  //             '${data.rating} ⭐',
                                  //             textAlign: TextAlign.center,
                                  //             style: const TextStyle(
                                  //                 color: Colors.white),
                                  //           ),
                                  //         ),
                                  //         kHeightSpacer(10),
                                  //         Container(
                                  //           padding: const EdgeInsets.all(2),
                                  //           width: 50,
                                  //           height: 22,
                                  //           decoration: BoxDecoration(
                                  //               color: Colors.grey.shade200,
                                  //               borderRadius:
                                  //                   BorderRadius.circular(5)),
                                  //           child: Text(
                                  //             '${data.distance} KM',
                                  //             textAlign: TextAlign.center,
                                  //             style: const TextStyle(
                                  //                 fontSize: 12,
                                  //                 color: Colors.black),
                                  //           ),
                                  //         ),
                                  //       ]),
                                  // ),
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
