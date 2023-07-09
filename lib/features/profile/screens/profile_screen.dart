import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:f21_demo/core/providers/firebase_providers.dart';
import 'package:f21_demo/core/utils.dart';
import 'package:f21_demo/features/auth/controller/auth_controller.dart';
import 'package:f21_demo/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_validator/form_validator.dart';
import 'package:go_router/go_router.dart';

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
  String _localProfilePicturePath = ""; //firebaseden indirilip locale kaydedilen localProfilePicturePath
  File? _profilePicFile; //güncelleneceği zaman localden upload edilen kontrol et null ise _profilePic değerini indirip al
  String? _profilePic; //firebase'den gelen url
  DateTime? _birthDate;
  DateTime? _birthDateBaby;
  double? _months;
  String? _gender = "Belirsiz";
  late bool _isPregnant;

  void selectProfileImage() async {
    final res = await pickImage();
    if (res != null) {
      setState(() {
        _profilePicFile = File(res.files.first.path!);
      });
    }
  }

  downloadExistingProfileImageFromFirebaseAsFile(String imageUrl) async {
    print("RECO : $imageUrl");
    var response = await http.get(Uri.parse(imageUrl));
    if (response.statusCode == 200) {
      var contentType = response.headers['content-type'];
      if(contentType != null){
        var fileExtension = getFileExtensionFromContentType(contentType);
        //print("RECO : file extension: $fileExtension");
        var fileName = 'existing_pofile_pic$fileExtension';
        //print("RECO : file name: $fileName");
        var appDocDir = await getApplicationDocumentsDirectory();
        //print("RECO : application documents dir: $appDocDir");
        var filePath = '${appDocDir.path}/$fileName';
        //print("RECO : file extension: $filePath");
        var file = File(filePath);
        await file.writeAsBytes(response.bodyBytes); //Bu kısmı bir yere eşitlemek lazım mı? sanki boş mu kaldı

        setState(() {
          _localProfilePicturePath = filePath;
          _profilePicFile = file;
        });

        print("RECO : _profilePicFile: $_profilePicFile");
        //print('Görsel kaydedildi: ${file.path}');
      }
    } else {
      print('Var olan profil resmi indirilirken bir sorun oluştu : ${response.statusCode}');
    }
  }

  String getFileExtensionFromContentType(String contentType) {
    if (contentType == 'image/jpeg') {
      return '.jpg';
    } else if (contentType == 'image/png') {
      return '.png';
    } else if (contentType == 'image/gif') {
      return '.gif';
    }
    // Diğer dosya türleri için ilgili uzantıları burada belirtebilirsiniz.
    // Örneğin: 'image/svg+xml' -> '.svg'

    // Varsayılan olarak, bilinmeyen dosya türleri için bir uzantı döndürebilirsiniz.
    return '.unknown';
  }

  //controllers
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool oneTimeWorkController = false;

  //functions
  void _toggleSwitch() {
    if (_isSaved) {
      _isEditing = !_isEditing;
      _isSaved = false;
    } else {
      showSnackBar(context, "Değişiklikleri kaydetmeden çıkamazsınız.");
    }
  }

  void _setInitialValuesOfFormFields(UserModel? user, FirebaseAuth userAuth) {
    setState(() {
      //Profil resmi değerini de burada almak lazım set ettikten sonra ekranda gösterirken de bu set ettiğin değişkeni kullanarak göster
      _profilePic = user!.profilePic!;
      _usernameController.text = user.username!.toString();
      _emailController.text = userAuth.currentUser!.email!;
      _passwordController.text = "*****";
      _months = user.months;
      _birthDate = user.birthDate;
      _birthDateBaby = user.babyBirthDate;
      _isPregnant = ref.read(userProvider)!.isPregnant!;//bu metodun retun değeri yok direkt olarak yukarıdaki _profilePicFile'a eşitler
    });
    downloadExistingProfileImageFromFirebaseAsFile(_profilePic!);
    //TODO: Ben değerleri aşağıdaki fromda bulunan değerleri elle atadım ancak _formKey kullanılarak ilgili alanların initialValue'leri bu fonksiyonda atanabilir.
  }

  //Default fuctions
  @override
  void initState() {
    // TODO: implement initState
    oneTimeWorkController = true;
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
    final UserModel? user = ref.read(userProvider);
    final FirebaseAuth userAuth = ref.read(authProvider);

    if(oneTimeWorkController){
      _setInitialValuesOfFormFields(user, userAuth);
      oneTimeWorkController = false;
    }
    return WillPopScope(
      onWillPop: () {
        if (_isSaved) {
          return Future.value(true);
        } else {
          showSnackBar(context, "Değişiklikleri kaydetmeden çıkamazsınız.\nLütfen sayfanın altındaki butonları kullanın.");
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
                              String textMessage = "Profil resminizi değiştirmek için Bilgilerimi Düzenle'yi aktifleştirin ve bu alana tıklayın ...";
                              if (_isEditing) {
                                textMessage = "Profil resminizi değiştirmek için görsele bir kez tıklayın.";
                              }
                              showSnackBar(context, textMessage);
                            },
                          onTap: () {
                            //TODO: Görsel seçme işlemi
                            if (_isEditing) {
                              selectProfileImage(); //seçilen profil resmi ana ekranda gösterilmeli (bir bool değişken koyarsın en tepeye o değiştiğinde localden image göster çalışır aksi halde url'den image göster çalışır)
                              if(_profilePicFile != null){ //görsel seçildiyse
                                setState(() {
                                  _localProfilePicturePath = _profilePicFile!.path; //yeni seçilen görselin pathini buraya kaydet
                                });
                              }
                            } else {
                              showSnackBar(context, "Öncelikile bilgilerimi düzenleyi aktifleştirin!");
                            }
                          },
                          child: Center(
                            child: Stack(
                              children: [
                                CircleAvatar(
                                  radius: 64,
                                  //TODO: Buraya kullanıcı resmi gelecek firebase ile çekilen resim
                                  backgroundImage: _localProfilePicturePath.isEmpty ? NetworkImage(_profilePic!) : FileImage(File(_localProfilePicturePath!),scale: 2) as ImageProvider,
                                  //_localProfilePicturePath.isEmpty ? NetworkImage(_profilePic!) : FileImage(File(_localProfilePicturePath!),scale: 2), //localdeki pathi
                                  //backgroundImage : NetworkImage(_profilePic!), //artık networkten çekmiyoruz

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
                            showSnackBar(context,  "E-mail adresinizi değiştirmezsiniz!");
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
                              context.push('/home/profile/change_pass');
                            }
                          },
                          readOnly: true,
                          name: "username",
                          controller: _passwordController,
                          decoration: InputDecoration(
                            label: const Text("Şifre"),
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
                            } else if (((DateTime.now().year - value.year) <
                                18)) {
                              return "18 yaşından küçükler bu uygulamayı kullanamaz!";
                            }
                            return null;
                          },
                          name: "birthDate",
                          lastDate: DateTime(DateTime.now().year - 18),
                          initialDate: user!.birthDate,
                          initialValue: user.birthDate,
                          onChanged: (value) {
                            setState(() {
                              _birthDate = value;
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
                          subtitle: Text(_isPregnant
                              ? "Henüz doğum yapmadım."
                              : "Doğum yaptım."),
                          title: Text(
                            _isPregnant ? "Gebeyim" : "Anneyim",
                            style: TextStyle(
                                color: CustomStyles.titleColor, fontSize: 18),
                          ),
                          initialValue: _isPregnant,
                          onChanged: (value) {
                            setState(() {
                              _isPregnant = value!;
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                          activeColor: CustomStyles.titleColor,
                          decoration:
                              const InputDecoration(border: InputBorder.none),
                        ),
                        const SizedBox(height: 20),
                        _isPregnant
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
                                  initialValue: _months ?? 2,
                                  divisions: 8,
                                  displayValues: DisplayValues.current,
                                  onChanged: (value) {
                                    _months = value;
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
                                    if (value == null && !_isPregnant) {
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
                                    _birthDateBaby = value;
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
                            _gender = value!;
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
                                    showSnackBar(context, "İptal edildi");
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
                                    try{
                                      if (_formKey.currentState!.validate()) {
                                        ref.read(authControllerProvider.notifier).setProfileInfos(
                                            _usernameController.text,
                                            _birthDate!,
                                            _gender!,
                                            _isPregnant,
                                            _profilePicFile,
                                            _months,
                                            _birthDateBaby,
                                            context
                                        );
                                        setState(() {
                                          _isSaved = true;
                                        });
                                        showSnackBar(context, "Başarılı");
                                        Navigator.pop(context);
                                      }else{
                                        showSnackBar(context, "Bir şeyler ters gitti");
                                      }
                                    }on Exception catch (_, ex){
                                      print("RECO : $ex");
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
