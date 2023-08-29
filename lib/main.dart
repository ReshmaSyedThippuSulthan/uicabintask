import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ReportNote(),
  ));
}

class ReportNote extends StatefulWidget {
  const ReportNote({super.key});

  @override
  State<ReportNote> createState() => _ReportNoteState();
}

class _ReportNoteState extends State<ReportNote> {
  List<Map> carequipment = [
    {"title": "Steering", "Icon": "assets/images/steering.png"},
    {"title": "Wipers", "Icon": "assets/images/wiper.png"},
    {"title": "Washers", "Icon": "assets/images/washer.png"},
    {"title": "Horn", "Icon": "assets/images/horn.png"},
    {"title": "Breakes inc ABS/EBS", "Icon": "assets/images/breaker.png"},
    {"title": "Mirrors/Glass/Visibility", "Icon": "assets/images/mirror.png"},
    {
      "title": "Truck interior/Seat belts",
      "Icon": "assets/images/truckinterior.png"
    },
    {"title": "Warning Lamps/MIL", "Icon": "assets/images/warning.png"}
  ];
  List<bool> check = [];
  File? image;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    check = List.generate(carequipment.length, (index) => false);
    print(check);
  }

  Future pickImage(ImageSource source) async {
    try {
      final images = await ImagePicker().pickImage(source: source);
      if (images == null) return;
      final imageTemp = File(images.path);
      setState(() => image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: const Icon(
          Icons.arrow_back_ios_new,
          color: Color.fromARGB(255, 135, 14, 5),
        ),
        title: const Center(
            child: Text(
          "INSPECTION",
          style: TextStyle(
            fontSize: 25,
            color: Color.fromARGB(255, 135, 14, 5),
          ),
        )),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //  image != null? Image.file(image!): SizedBox(),
              const SizedBox(
                height: 40,
              ),
              const Text("Cabin Check",
                  style: TextStyle(
                    color: Color.fromARGB(255, 135, 14, 5),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
              const SizedBox(
                height: 15,
              ),
              Expanded(
                child: ListView.builder(
                  //shrinkWrap: true,
                  itemCount: carequipment.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      elevation: 10,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image(
                                    image: AssetImage(
                                        carequipment[index]["Icon"])),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  carequipment[index]["title"],
                                  style: const TextStyle(
                                      fontSize: 15,
                                      color: Color.fromARGB(255, 121, 10, 10)),
                                )
                              ],
                            ),
                            const Spacer(),
                            SizedBox(
                              height: 60,
                              // decoration:
                              // const BoxDecoration(color: Colors.green),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  check[index]
                                      ? IconButton(
                                          onPressed: () {
                                            setState(() {
                                              check[index] = !check[index];
                                            });
                                            print(check);
                                          },
                                          icon: const Icon(
                                            Icons.done,
                                            color: Colors.red,
                                            size: 38,
                                          ))
                                      : IconButton(
                                          onPressed: () {
                                            setState(() {
                                              check[index] = !check[index];
                                            });
                                            print(check);
                                          },
                                          icon: const Icon(
                                            Icons.cancel_outlined,
                                            color: Colors.red,
                                            size: 35,
                                          )),
                                  const SizedBox(width: 15),
                                  InkWell(
                                    child: const Image(
                                        image: AssetImage(
                                            "assets/images/camera.jpg")),
                                    onTap: () {
                                      showModalBottomSheet<void>(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return SizedBox(
                                            height: 200,
                                            child: Center(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  const Text(
                                                      'Choose Camera or gallery'),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      IconButton(
                                                          onPressed: () {
                                                            pickImage(
                                                                ImageSource
                                                                    .camera);
                                                          },
                                                          icon: const Icon(
                                                              Icons.camera)),
                                                      IconButton(
                                                          onPressed: () {
                                                            pickImage(
                                                                ImageSource
                                                                    .gallery);
                                                          },
                                                          icon: const Icon(
                                                              Icons.image)),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                  const SizedBox(width: 20),
                                  InkWell(
                                    child: const Image(
                                      image: AssetImage(
                                          "assets/images/comments.png"),
                                      width: 35,
                                      height: 35,
                                      fit: BoxFit.cover,
                                    ),
                                    onTap: () async {
                                      TextEditingController commentscontroller =
                                          TextEditingController();
                                      final result = await showModalBottomSheet(
                                          isScrollControlled: true,
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Container(
                                              // height: 200,

                                              padding: EdgeInsets.only(
                                                  bottom: MediaQuery.of(context)
                                                      .viewInsets
                                                      .bottom),
                                              decoration: BoxDecoration(
                                                  color: Colors.grey[100]),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                  Text(
                                                    "${carequipment[index]["title"]} Comments",
                                                    style: const TextStyle(
                                                        fontSize: 25),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: TextField(
                                                      controller:
                                                          commentscontroller,
                                                      decoration: const InputDecoration(
                                                          border: OutlineInputBorder(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          25)))),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 15,
                                                  ),
                                                  ElevatedButton(
                                                      style: ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                              const Color
                                                                  .fromARGB(255,
                                                                  135, 14, 5),
                                                          shape: const RoundedRectangleBorder(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          60)))),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop(
                                                          [
                                                            commentscontroller
                                                                .text
                                                          ],
                                                        );
                                                      },
                                                      child: const Text(
                                                        "Add Comments",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ))
                                                ],
                                              ),
                                            );
                                          });
                                      print(result);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: SizedBox(
                    height: 60,
                    width: 250,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 135, 14, 5),
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(60)))),
                        onPressed: () {},
                        child: const Text("NEXT",
                            style: TextStyle(color: Colors.white)))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
