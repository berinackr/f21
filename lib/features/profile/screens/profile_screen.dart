import 'package:f21_demo/core/providers/firebase_providers.dart';
import 'package:f21_demo/features/auth/controller/auth_controller.dart';
import 'package:f21_demo/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_validator/form_validator.dart';

import '../../../core/custom_styles.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  //formKey
  final _formKey = GlobalKey<FormBuilderState>();

  //states
  bool _isEditing = false;
  bool _isSaved = true;

  //userInfoStates
  //File? profileFile;
  DateTime? birthDate;
  DateTime? birthDateBaby;
  double? months;
  String gender = "Belirsiz";
  late bool isPregnant = ref.read(userProvider)!.isPregnant!;

  //controllers
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  //functions
  void _toggleSwitch() {
    if (_isSaved) {
      _isEditing = !_isEditing;
      _isSaved = false;
    } else {
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(const SnackBar(
            content: Text("Değişiklikleri kaydetmeden çıkamazsınız.")));
    }
  }

  void _setInitialValuesOfFormFields(UserModel? user, FirebaseAuth userAuth) {
    setState(() {
      _usernameController.text = user!.username!.toString();
      _emailController.text = userAuth.currentUser!.email!;
      _passwordController.text = "*****";
    });
    //TODO: Ben değerleri aşağıdaki fromda bulunan değerleri elle atadım ancak _formKey kullanılarak ilgili alanların initialValue'leri bu fonksiyonda atanabilir.
  }

  //Default fuctions
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    CustomStyles().responsiveTheme(isDarkMode);
    //providers
    final UserModel? user = ref.watch(userProvider);
    final FirebaseAuth userAuth = ref.watch(authProvider);

    _setInitialValuesOfFormFields(user, userAuth);
    return WillPopScope(
      onWillPop: () {
        if (_isSaved) {
          return Future.value(true);
        } else {
          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(const SnackBar(
                content: Text(
                    "Değişiklikleri kaydetmeden çıkamazsınız.\nLütfen sayfanın altındaki butonları kullanın.")));
          return Future.value(false);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Profil"),
          actions: [
            Row(
              children: [
                const Text("Bilgilerimi Düzenle"),
                Switch(
                  value: _isEditing,
                  onChanged: (value) {
                    setState(() {
                      _toggleSwitch();
                    });
                  },
                )
              ],
            )
          ],
        ),
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return Container(
              constraints: BoxConstraints(
                maxWidth: viewportConstraints.maxWidth,
                maxHeight: viewportConstraints.maxHeight,
              ),
              child: SingleChildScrollView(
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 15,
                    ),
                    child: FormBuilder(
                      key: _formKey,
                      child: Column(children: [
                        //TODO: Profil Resmi
                        InkWell(
                          onLongPress: () {
                            ScaffoldMessenger.of(context)
                              ..removeCurrentSnackBar()
                              ..showSnackBar(const SnackBar(
                                  content: Text(
                                      "Profil resminizi değiştirmek için Bilgilerimi Düzenle'yi aktifleştirin ve bu alana tıklayın ...")));
                          },
                          onTap: () {
                            //TODO: Görsel seçme işlemi
                            if (_isEditing) {
                              ScaffoldMessenger.of(context)
                                ..removeCurrentSnackBar()
                                ..showSnackBar(const SnackBar(
                                    content: Text(
                                        "Görsel seçme fonksiyonu çalışmalı")));
                            } else {
                              ScaffoldMessenger.of(context)
                                ..removeCurrentSnackBar()
                                ..showSnackBar(const SnackBar(
                                    content: Text(
                                        "Öncelikile bilgilerimi düzenleyi aktifleştirin!")));
                            }
                          },
                          child: Center(
                            child: Stack(
                              children: [
                                CircleAvatar(
                                  radius: 64,
                                  //TODO: Buraya kullanıcı resmi gelecek firebase ile çekilen resim
                                  backgroundImage:
                                      NetworkImage(user!.profilePic!),
                                ),
                                const Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Icon(size: 35, Icons.image_rounded),
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        //TODO: Kullanıcı adı
                        FormBuilderTextField(
                          readOnly: !_isEditing,
                          name: "username",
                          controller: _usernameController,
                          decoration: InputDecoration(
                            label: const Text("Kullanıcı Adı"),
                            hintText: "Kullanıcı adı",
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 15),
                            fillColor: CustomStyles.fillColor,
                          ),
                          validator: ValidationBuilder(localeName: "tr")
                              .minLength(3)
                              .maxLength(20)
                              .build(),
                        ),
                        const SizedBox(height: 20),
                        //TODO: Email
                        FormBuilderTextField(
                          onTap: () {
                            ScaffoldMessenger.of(context)
                              ..removeCurrentSnackBar()
                              ..showSnackBar(const SnackBar(
                                  content: Text(
                                      "E-mail adresinizi değiştirmezsiniz!")));
                          },
                          readOnly: true,
                          name: "email",
                          controller: _emailController,
                          decoration: InputDecoration(
                            label: const Text("E-mail"),
                            hintText: "johndoe@gmail.com",
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 15),
                            fillColor: CustomStyles.fillColor,
                          ),
                        ),
                        const SizedBox(height: 20),
                        //TODO: Password
                        FormBuilderTextField(
                          onTap: () {
                            if (_isEditing) {
                              //TODO: şifre değiştir ekranına git
                            }
                          },
                          readOnly: true,
                          name: "username",
                          controller: _passwordController,
                          decoration: InputDecoration(
                            label: Text("Şifre"),
                            hintText: "*********",
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 15),
                            fillColor: CustomStyles.fillColor,
                          ),
                        ),
                        const SizedBox(height: 20),
                        //TODO: Doğum tarihi
                        FormBuilderDateTimePicker(
                          enabled: _isEditing,
                          validator: (value) {
                            if (value == null) {
                              return "Doğum tarihi boş bırakılamaz";
                            } else if (((DateTime.now().year - value!.year) <
                                18)) {
                              return "18 yaşından küçükler bu uygulamayı kullanamaz!";
                            }
                            return null;
                          },
                          name: "birthDate",
                          lastDate: DateTime(DateTime.now().year - 18),
                          initialDate: user!.birthDate ?? DateTime.now(),
                          initialValue: user!.birthDate ?? DateTime.now(),
                          onChanged: (value) {
                            setState(() {
                              birthDate = value;
                            });
                          },
                          inputType: InputType.date,
                          decoration: const InputDecoration(
                            label: Text("Doğum Tarihi"),
                          ),
                        ),
                        const SizedBox(height: 20),
                        //TODO: Gebelik durumu
                        FormBuilderSwitch(
                          enabled: _isEditing,
                          name: "role",
                          subtitle: Text(isPregnant
                              ? "Henüz doğum yapmadım."
                              : "Doğum yaptım."),
                          title: Text(
                            isPregnant ? "Gebeyim" : "Anneyim",
                            style: TextStyle(
                                color: CustomStyles.titleColor, fontSize: 18),
                          ),
                          initialValue: isPregnant,
                          onChanged: (value) {
                            setState(() {
                              isPregnant = value!;
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                          activeColor: CustomStyles.titleColor,
                          decoration:
                              const InputDecoration(border: InputBorder.none),
                        ),
                        const SizedBox(height: 20),
                        isPregnant
                            ? Column(children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Kaç Aylık Hamilesiniz?",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: CustomStyles.titleColor,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                //TODO: Hamilelik ayları
                                FormBuilderSlider(
                                  label: "Kaç Aylık Hamilesiniz?",
                                  enabled: _isEditing,
                                  name: "months",
                                  min: 1,
                                  max: 9,
                                  initialValue: user.months?.toDouble() ?? 2,
                                  divisions: 8,
                                  displayValues: DisplayValues.current,
                                  onChangeEnd: (value) {
                                    months = value;
                                  },
                                  valueWidget: (value) {
                                    return Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: CustomStyles.titleColor,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        "$value Aylık",
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    );
                                  },
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.all(0)),
                                ),
                              ])
                            : Column(children: [
                                //TODO: Bebeğin doğum tarihi ayarla
                                FormBuilderDateTimePicker(
                                  validator: (value) {
                                    if (value == null && !isPregnant) {
                                      return "Doğum tarihi boş bırakılamaz";
                                    }
                                    return null;
                                  },
                                  initialValue:
                                      user.babyBirthDate ?? DateTime.now(),
                                  initialDate:
                                      user.babyBirthDate ?? DateTime.now(),
                                  name: "birthDate",
                                  onChanged: (value) {
                                    birthDateBaby = value;
                                  },
                                  inputType: InputType.date,
                                  decoration: const InputDecoration(
                                    label: Text("Bebeğinizin Doğum Tarihi"),
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 15),
                                  ),
                                ),
                              ]),
                        const SizedBox(height: 20),
                        //TODO: Bebeğin Cinsiyeti
                        FormBuilderDropdown(
                          enabled: _isEditing,
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
                          dropdownColor: CustomStyles.fillColor,
                          initialValue: user.gender ?? "Belirsiz",
                          iconEnabledColor: CustomStyles.titleColor,
                          onChanged: (value) {
                            gender = value!;
                          },
                          iconDisabledColor: CustomStyles.titleColor,
                          style: TextStyle(
                              color: CustomStyles.titleColor, fontSize: 18),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 15),
                            fillColor: CustomStyles.fillColor,
                            label: const Text("Bebeğinizin Cinsiyeti"),
                          ),
                        ),
                        const SizedBox(height: 20),
                        //TODO: Bebeğin Kilosu
                        if (_isEditing)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.red),
                                  ),
                                  onPressed: () {
                                    //TODO: Buna basıldığında tüm _formKey ile eski haline getirilmeli ya da pop yapıp yeniden bu sayfa açılabilir??? Şimdilik ikinciyi yapıyor
                                    setState(() {
                                      _isSaved = true;
                                    });
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Değişiklikleri İptal Et")),
                              const SizedBox(width: 20),
                              ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.green),
                                  ),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      //TODO: Kaydetme işlemleri burada yapılacak eğer kaydet butonuna basılmadan sayfadan çıkılmak istenirse hata vermeli!
                                      setState(() {
                                        _isSaved = true;
                                      });
                                    }
                                  },
                                  child: const Text("Kaydet")),
                            ],
                          )
                      ]),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
