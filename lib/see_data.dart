import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SeeData extends StatefulWidget {
  const SeeData({Key? key}) : super(key: key);

  @override
  SeeDataState createState() => SeeDataState();
}

class SeeDataState extends State<SeeData> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('users').snapshots();

  bool? selected;
  Map<int, bool> selectedFlags = {};
  bool selectedMode = false;
  var customersList = [];
  var dataList = [];
  bool check = true;
  bool isSearching = false;
  @override
  Widget build(BuildContext context) {
    selectedMode = selectedFlags.containsValue(true);

    print('////////////////$selectedMode///////////////////');
    check ? getData() : null;
    print(selectedFlags);

    print('$dataList//////data///////${dataList.length}');
    print('$customersList//////customer///////${customersList.length}');
    return Scaffold(
      appBar: AppBar(
          elevation: 0.0,
          title: isSearching
              ? TextFormField(
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                      hintText: 'Search',
                      contentPadding: const EdgeInsets.all(5.0),
                      filled: true,
                      fillColor: Colors.white,
                      constraints:
                          const BoxConstraints(maxHeight: 40, maxWidth: 200),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                )
              : const Text('Retrieved Data'),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0, left: 0.0),
              child: IconButton(
                onPressed: () {
                  setState(() {
                    isSearching = !isSearching;
                  });
                },
                icon: const Icon(Icons.search),
              ),
            ),
            selectedMode
                ? Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {
                              setState(() {
                                deleteCustomers();
                                check = true;
                                //  selectedFlags.updateAll((key, value) => false);
                              });
                            },
                            icon: const Icon(Icons.delete)),
                        InkWell(
                            onTap: () {
                              if (selectedFlags.containsValue(false)) {
                                setState(() {
                                  selectedFlags.updateAll((key, value) => true);
                                  customersList = [];
                                  customersList = dataList;
                                  //  deleteCustomers = dataList;
                                });
                              } else {
                                setState(() {
                                  selectedFlags
                                      .updateAll((key, value) => false);
                                  customersList = [];
                                });
                              }
                            },
                            child: !(selectedFlags.containsValue(false))
                                ? const Icon(
                                    Icons.check_box,
                                    color: Colors.white,
                                    // size: 20,
                                  )
                                : const Icon(Icons.select_all_sharp)),
                        Text(
                          ' ${customersList.length}',
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  )
                : const Text(''),
          ]),
      backgroundColor: Colors.grey.shade200,
      body: StreamBuilder<QuerySnapshot>(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.data!.size == 0) {
            return const Center(
              child: Text('No Customer Added Yet'),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> data =
                  snapshot.data!.docs[index].data() as Map<String, dynamic>;
              selectedFlags[index] = selectedFlags[index] ?? false;
              print('///////under list builder$selectedFlags//////////////');
              selected = selectedFlags[index];

              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                child: ListTile(
                  leading: CircleAvatar(child: Text(data['age'])),
                  title: Text(data['name']),
                  subtitle: Text(data['notes']),
                  tileColor: Colors.white,
                  trailing: selectedMode
                      ? Checkbox(
                          side: const BorderSide(
                            color: Colors.black,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                          ),
                          fillColor: MaterialStateProperty.all(Colors.green),
                          //  overlayColor: MaterialStateProperty.all(Colors.red),
                          value: selected,
                          checkColor: Colors.white,
                          onChanged: (bool? value) {
                            // setState(() {
                            //   if (selectedFlags[index]!) {
                            //     selectedFlags[index] = value!;
                            //
                            //     customersList.removeWhere(
                            //         (element) => element['age'] == data['age']);
                            //   } else {
                            //     selectedFlags[index] = value!;
                            //
                            //     customersList.add(data);
                            //   }
                            // });
                          })
                      : null,
                  onLongPress: () => setState(() {
                    selectedFlags[index] = !selectedFlags[index]!;
                    customersList.add(data);
                  }),
                  onTap: () {
                    if (selectedMode) {
                      print('list contains ${selectedFlags[index] == true}');
                      setState(() {
                        if (selectedFlags[index]!) {
                          print(
                              '////////////////////if ///////////${selectedFlags[index]}///////////////');
                          selectedFlags[index] = !selectedFlags[index]!;
                          customersList.removeWhere(
                              (element) => element['age'] == data['age']);
                        } else {
                          print(
                              '////////////////////else//////// ${selectedFlags[index]}///////////////');

                          selectedFlags[index] = !selectedFlags[index]!;
                          customersList.add(data);
                        }
                      });
                    } else {
                      print('$selectedFlags');
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('N0 Action Applied Right now')));
                    }
                  },
                  selected: selectedFlags[index]!,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: const BorderSide(color: Colors.deepOrange)),
                  selectedColor: Colors.black,
                  selectedTileColor: Colors.grey.shade300,
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> getData() async {
    QuerySnapshot customers =
        await FirebaseFirestore.instance.collection('users').get();
    dataList.clear();
    for (int i = 0; i < customers.docs.length; i++) {
      dataList.add(customers.docs[i].data());
    }
    check = false;
    print('$dataList//////dataList//////////${dataList.length}');
  }

  deleteCustomers() {
    for (var data in customersList) {
      FirebaseFirestore.instance.collection('users').doc(data['age']).delete();
      selectedFlags.removeWhere((key, value) => value == true);
      print(customersList);
      print(data);
    }
    customersList.clear();
  }
}
