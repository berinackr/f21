import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:f21_demo/core/utils.dart';
import 'package:f21_demo/features/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_validator/form_validator.dart';

class ExampleProfileData extends ConsumerStatefulWidget {
  const ExampleProfileData({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ExampleProfileDataState();
}

class _ExampleProfileDataState extends ConsumerState<ExampleProfileData> {
  final _formKey = GlobalKey<FormBuilderState>();
  File? profileFile;
  DateTime? birthDate;
  DateTime? birthDateBaby;
  double? months;
  String gender = "Belirsiz";
  bool isPregnant = true;
  final usernameController = TextEditingController();
  void selectProfileImage() async {
    final res = await pickImage();
    if (res != null) {
      setState(() {
        profileFile = File(res.files.first.path!);
      });
    }
  }

  void logOut(WidgetRef ref) {
    ref.read(authControllerProvider.notifier).logout();
  }

  void setProfileInfos(
    WidgetRef ref,
    String username,
    DateTime birthDate,
    String gender,
    bool isPregnant,
    File? profilePic,
    double? months,
    DateTime? babyBirthDate,
    BuildContext context,
  ) {
    ref
        .read(authControllerProvider.notifier)
        .setProfileInfos(username, birthDate, gender, isPregnant, profilePic, months, babyBirthDate, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Profil Bilgileri",
            style: TextStyle(color: Color.fromARGB(255, 155, 174, 209)),
          ),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 31, 4, 99),
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Color.fromARGB(255, 155, 174, 209),
          ),
          actions: [
            IconButton(
              onPressed: () => logOut(ref),
              icon: const Icon(Icons.logout, color: Color.fromARGB(255, 155, 174, 209)),
            ),
          ],
        ),
        body: SafeArea(child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
              child: Container(
                color: const Color.fromARGB(255, 155, 174, 209),
                constraints: BoxConstraints(minHeight: viewportConstraints.maxHeight),
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
                child: FormBuilder(
                  key: _formKey,
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: selectProfileImage,
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(100),
                          dashPattern: const [10, 4],
                          strokeCap: StrokeCap.round,
                          color: const Color.fromARGB(255, 31, 4, 99),
                          child: Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: profileFile != null
                                ? ClipOval(child: Image.file(profileFile!, fit: BoxFit.cover))
                                : const Center(
                                    child: Icon(
                                      Icons.camera_enhance,
                                      size: 30,
                                      color: Color.fromARGB(255, 31, 4, 99),
                                    ),
                                  ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Kullanıcı Adı",
                          style: TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 31, 4, 99),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      FormBuilderTextField(
                        name: "username",
                        controller: usernameController,
                        decoration: const InputDecoration(
                          hintText: "Anne",
                          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color.fromARGB(255, 31, 4, 99), width: 2),
                              borderRadius: BorderRadius.all(Radius.circular(10.0))),
                          fillColor: Color.fromARGB(255, 236, 236, 236),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          ),
                        ),
                        validator: ValidationBuilder(localeName: "tr").minLength(3).maxLength(20).build(),
                      ),
                      const SizedBox(height: 20),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Doğum Tarihi",
                          style: TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 31, 4, 99),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      FormBuilderDateTimePicker(
                        validator: (value) {
                          if (value == null) {
                            return "Doğum tarihi boş bırakılamaz";
                          }
                          return null;
                        },
                        name: "birthDate",
                        onChanged: (value) {
                          birthDate = value;
                        },
                        inputType: InputType.date,
                        decoration: const InputDecoration(
                          hintText: "Doğum Tarihi",
                          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                          fillColor: Color.fromARGB(255, 236, 236, 236),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color.fromARGB(255, 31, 4, 99), width: 2),
                              borderRadius: BorderRadius.all(Radius.circular(10.0))),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      FormBuilderSwitch(
                        name: "role",
                        title: const Text(
                          "Gebeyim",
                          style: TextStyle(color: Color.fromARGB(255, 31, 4, 99), fontSize: 18),
                        ),
                        initialValue: true,
                        onChanged: (value) {
                          setState(() {
                            isPregnant = value!;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                        activeColor: const Color.fromARGB(255, 31, 4, 99),
                        decoration: const InputDecoration(border: InputBorder.none),
                      ),
                      isPregnant
                          ? Column(children: [
                              const SizedBox(height: 20),
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Kaç Aylık Hamilesiniz?",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Color.fromARGB(255, 31, 4, 99),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              FormBuilderSlider(
                                name: "months",
                                min: 1,
                                max: 9,
                                initialValue: 2,
                                divisions: 8,
                                displayValues: DisplayValues.current,
                                onChangeEnd: (value) {
                                  months = value;
                                },
                                valueWidget: (value) {
                                  return Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(255, 31, 4, 99),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      "$value Aylık",
                                      style: const TextStyle(color: Colors.white),
                                    ),
                                  );
                                },
                                decoration:
                                    const InputDecoration(border: InputBorder.none, contentPadding: EdgeInsets.all(0)),
                              ),
                            ])
                          : Column(children: [
                              const SizedBox(height: 20),
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Bebeğinizin Doğum Tarihi",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Color.fromARGB(255, 31, 4, 99),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              FormBuilderDateTimePicker(
                                validator: (value) {
                                  if (value == null && !isPregnant) {
                                    return "Doğum tarihi boş bırakılamaz";
                                  }
                                  return null;
                                },
                                name: "birthDate",
                                onChanged: (value) {
                                  birthDateBaby = value;
                                },
                                inputType: InputType.date,
                                decoration: const InputDecoration(
                                  hintText: "Bebeğinizin Doğum Tarihi",
                                  contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                                  fillColor: Color.fromARGB(255, 236, 236, 236),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Color.fromARGB(255, 31, 4, 99), width: 2),
                                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                  ),
                                ),
                              ),
                            ]),
                      const SizedBox(height: 20),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Bebeğin Cinsiyeti",
                          style: TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 31, 4, 99),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      FormBuilderDropdown(
                        name: "gender",
                        items: const [
                          DropdownMenuItem(
                            value: "Erkek",
                            child: Text("Erkek"),
                          ),
                          DropdownMenuItem(
                            value: "Kız",
                            child: Text("Kız"),
                          ),
                          DropdownMenuItem(
                            value: "Belirsiz",
                            child: Text("Belirsiz"),
                          ),
                        ],
                        dropdownColor: const Color.fromARGB(255, 236, 236, 236),
                        initialValue: "Belirsiz",
                        iconEnabledColor: const Color.fromARGB(255, 31, 4, 99),
                        onChanged: (value) {
                          gender = value!;
                        },
                        iconDisabledColor: const Color.fromARGB(255, 31, 4, 99),
                        style: const TextStyle(color: Color.fromARGB(255, 31, 4, 99), fontSize: 18),
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                          fillColor: Color.fromARGB(255, 236, 236, 236),
                          hintText: "Belirsiz",
                          hintStyle: TextStyle(color: Color.fromARGB(255, 31, 4, 99), fontSize: 18),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color.fromARGB(255, 31, 4, 99), width: 2),
                              borderRadius: BorderRadius.all(Radius.circular(10.0))),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                          onPressed: () {
                            print(usernameController.text);
                            if (_formKey.currentState!.validate()) {
                              setProfileInfos(ref, usernameController.text, birthDate!, gender, isPregnant, profileFile,
                                  months, birthDateBaby, context);
                            }
                          },
                          child: const Text("Kaydet"))
                    ],
                  ),
                ),
              ),
            );
          },
        )));
  }
}
