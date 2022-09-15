import 'package:cruid_cloud/see_data.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static late TextEditingController phoneController;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static final users = FirebaseFirestore.instance.collection('users');
  late TextEditingController _nameController;

  late TextEditingController _notesController;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    _nameController = TextEditingController();
    HomePage.phoneController = TextEditingController();
    _notesController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    HomePage.phoneController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crud Firebase'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Form(
            key: formKey,
            child: SingleChildScrollView(
              reverse: true,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _nameController,
                    focusNode: FocusNode(),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'can\'t be empty';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        hintText: 'Name',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: HomePage.phoneController,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'can\'t be empty';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        hintText: 'age',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _notesController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'can\'t be empty';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), hintText: 'Notes'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 18.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        final Map<String, dynamic> usersMap = {
                          'name': _nameController.text,
                          'age': HomePage.phoneController.text,
                          'notes': _notesController.text
                        };
                        Future<void> addUser() async {
                          var docPath = HomePage.phoneController.text;
                          return users.doc(docPath).set(usersMap);
                        }

                        if (formKey.currentState!.validate()) {
                          addUser()
                              .whenComplete(() => AwesomeDialog(
                                    context: context,
                                    animType: AnimType.LEFTSLIDE,
                                    headerAnimationLoop: true,
                                    dialogType: DialogType.SUCCES,
                                    title: 'Added',
                                    desc: _nameController.text,
                                    btnOkOnPress: () {
                                      debugPrint('OnClick');
                                    },
                                    btnOkIcon: Icons.check_circle,
                                  ).show())
                              .onError((error, stackTrace) => AwesomeDialog(
                                    context: context,
                                    animType: AnimType.LEFTSLIDE,
                                    headerAnimationLoop: true,
                                    dialogType: DialogType.ERROR,
                                    title: 'Ops!, Could Not Add',
                                    desc: _nameController.text,
                                    btnOkOnPress: () {
                                      debugPrint('OnClick');
                                    },
                                    btnOkIcon: Icons.check_circle,
                                  ).show());
                        }
                      },
                      child: const Text('Add Data'),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SeeData()));
                      },
                      child: const Icon(Icons.forward)),
                ],
              ),
            )),
      ),
    );
  }
}
