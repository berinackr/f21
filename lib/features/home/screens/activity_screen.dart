import 'dart:typed_data';

import 'package:f21_demo/core/custom_styles.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:f21_demo/core/utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:screenshot/screenshot.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ActivityScreen extends ConsumerStatefulWidget {
  final String? _activityId;
  final String? _activityType;
  final String? _isPregnant;

  const ActivityScreen(
      {Key? key,
      required String? activityId,
      required String? activityType,
      required String? isPregnant})
      : _isPregnant = isPregnant,
        _activityType = activityType,
        _activityId = activityId,
        super(key: key);

  @override
  ConsumerState createState() => _ActivityScreenState();
}

class _ActivityScreenState extends ConsumerState<ActivityScreen> {
  final controller = TextEditingController();
  late bool isTextActivity;

  File? postFile;

  void selectPostImage() async {
    final res = await pickImage();
    if (res != null) {
      setState(() {
        postFile = File(res.files.first.path!);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.text = "";
  }

  //TODO PHOTO ACTIVITY STATELERI ---------------------------------------------

  File? _selectedImage;
  double _imageScale = 0.5;
  double _imageX = 0.0;
  double _imageY = 0.0;

  Future<void> _getImageFromGallery() async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedImage != null) {
        _selectedImage = File(pickedImage.path);
      }
    });
  }

  void _increaseScale() {
    setState(() {
      _imageScale += 0.1;
    });
  }

  void _decreaseScale() {
    setState(() {
      if (_imageScale > 0.1) {
        _imageScale -= 0.1;
      }
    });
  }

  void _moveRight() {
    setState(() {
      _imageX += 10;
    });
  }

  void _moveLeft() {
    setState(() {
      _imageX -= 10;
    });
  }

  void _moveUp() {
    setState(() {
      _imageY -= 10;
    });
  }

  void _moveDown() {
    setState(() {
      _imageY += 10;
    });
  }

  ScreenshotController screenshotController = ScreenshotController();

  void _saveToGallery() async {
    try {
      // Ekran görüntüsünü al
      Uint8List? capturedImage = await screenshotController.capture();

      // Alınan görüntüyü galeriye kaydet
      final result = await ImageGallerySaver.saveImage(capturedImage!);
      print(result); // Kaydedilen dosyanın yolu
    } catch (e) {
      print("Hata: $e");
    }
  }

  //TODO PHOTO ACTIVITY STATELERI ---------------------------------------------

  @override
  Widget build(BuildContext context) {
    final int index = int.parse(widget._activityId!);
    isTextActivity = widget._activityType! == "text_activity" ? true : false;
    if (isTextActivity) {
      _getText(index, controller);
    }
    late final int ay;
    // ignore: sdk_version_since
    late final bool isPregnant = bool.parse(widget._isPregnant!);

    if (isPregnant) {
      ay = int.parse(widget._activityId!) + 1;
    } else {
      ay = int.parse(widget._activityId!) - 8;
    }

    print(
        "RECOX : Gelen id : ${widget._activityId}, gelen activity type : ${widget._activityType}, ay : $ay, index: $index"); //TODO dikkat 5. aya tıklayınca id 4 geliyor yani index şeklinde
    return WillPopScope(
      onWillPop: () async {
        _saveText(index, controller.text);
        showSnackBar(context, "Taslak kaydedildi.");
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
              "$ay. Ay ${isPregnant ? "Gebelik" : "Bebeğim"} Etkinliği"), //TODO bu kısım buraya yönlendirirken gelecek push edilirken context.push()'a parametre olarak verilecek örneklerine router altında hangi sayfada kullanıldıysa o ayfayı açarak görebilirsin
          //backgroundColor: Colors.redAccent,
        ),
        body: LayoutBuilder(
          builder: (context, viewportConstraints) => Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    if (isTextActivity)
                      Container(
                        //Text Aktivitesi
                        width: viewportConstraints.maxWidth,
                        child: Stack(
                          children: [
                            // Arkaplan görüntüsü
                            Image.asset(
                              'assets/images/activity_frame_0.png', //TODO buraya {index} gelecek
                              fit: BoxFit.contain,
                            ),
                            Positioned(
                              top: 70,
                              left: 50,
                              right: 50,
                              bottom: 70,
                              child: SingleChildScrollView(
                                child: Container(
                                  padding: const EdgeInsets.all(16),
                                  child: TextFormField(
                                    controller: controller,
                                    maxLines: null,
                                    keyboardType: TextInputType.multiline,
                                    textInputAction: TextInputAction.newline,
                                    style: GoogleFonts.dancingScript(
                                      color: Colors.black,
                                      fontSize: 24,
                                    ),
                                    decoration: InputDecoration.collapsed(
                                      hintText:
                                          'Sevgili yavrum, \nbu satırları ...',
                                      hintStyle: GoogleFonts.dancingScript(
                                          color: Colors.black),
                                    ),
                                    textAlignVertical: TextAlignVertical.top,
                                    scrollPhysics:
                                        const NeverScrollableScrollPhysics(),
                                    cursorColor: CustomStyles.primaryColor,
                                    cursorWidth: 2,
                                    cursorHeight: 28,
                                    textCapitalization:
                                        TextCapitalization.sentences,
                                    textAlign: TextAlign.left,
                                    textDirection: TextDirection.ltr,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    else
                      SingleChildScrollView(
                        child: Column(
                          //mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _selectedImage != null
                                ? Screenshot(
                                    controller: screenshotController,
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Transform.translate(
                                          offset: Offset(_imageX, _imageY),
                                          child: Transform.scale(
                                            scale: _imageScale,
                                            child: Image.file(
                                              _selectedImage!,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                            ),
                                          ),
                                        ),
                                        Image.asset(
                                          'assets/images/activity_frame_$index.png', // Çerçeve asset'i
                                          width:
                                              MediaQuery.of(context).size.width,
                                        ),
                                      ],
                                    ),
                                  )
                                : const Padding(
                                    padding: EdgeInsets.all(20.0),
                                    child: Text(
                                        'Görsel seçin butonunu kullanarak bir görsel seçin. Ardından aşağıdaki hareket butonlarıyla görüntüyü çerçeveye yerleştirin.'),
                                  ),
                            const SizedBox(height: 50),
                            Container(
                              constraints: BoxConstraints(
                                maxWidth: viewportConstraints.maxWidth,
                              ),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    ElevatedButton(
                                      onPressed: _increaseScale,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            CustomStyles.primaryColor,
                                      ),
                                      child: const Text('+'),
                                    ),
                                    const SizedBox(width: 16),
                                    ElevatedButton(
                                      onPressed: _decreaseScale,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            CustomStyles.primaryColor,
                                      ),
                                      child: const Text('-'),
                                    ),
                                    const SizedBox(width: 16),
                                    ElevatedButton(
                                      onPressed: _moveLeft,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            CustomStyles.primaryColor,
                                      ),
                                      child: const Icon(Icons.arrow_left),
                                    ),
                                    const SizedBox(width: 16),
                                    ElevatedButton(
                                      onPressed: _moveRight,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            CustomStyles.primaryColor,
                                      ),
                                      child: const Icon(Icons.arrow_right),
                                    ),
                                    const SizedBox(width: 16),
                                    ElevatedButton(
                                      onPressed: _moveUp,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            CustomStyles.primaryColor,
                                      ),
                                      child: const Icon(Icons.arrow_upward),
                                    ),
                                    const SizedBox(width: 16),
                                    ElevatedButton(
                                      onPressed: _moveDown,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            CustomStyles.primaryColor,
                                      ),
                                      child: const Icon(Icons.arrow_downward),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: _getImageFromGallery,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: CustomStyles.primaryColor,
                              ),
                              child: Text(_selectedImage == null
                                  ? 'Galeriden Görsel Seç 📸'
                                  : 'Yeni Görsel Seç 📷'),
                            ),
                          ],
                        ),
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              if (isTextActivity) {
                                //TODO Burada sharedPreferences ile text'i kaydet text_activity adlı bir değişkende tut
                                _saveText(index, controller.text);
                                showSnackBar(context,
                                    "Yazınızı kaydettik! Daha sonra kaldığınız yerden devam edebilirisiniz. 🤓");
                              } else {
                                if (_selectedImage != null) {
                                  _saveToGallery();
                                  showSnackBar(context,
                                      "Harika! Görüntü galerinize kaydedildi! 🎉🥳");
                                } else {
                                  showSnackBar(context,
                                      "Lütfen önce galerinizden bir resim seçin. 🙌");
                                }
                              }
                            },
                            child: const Text("Kaydet")),
                        ElevatedButton(
                            onPressed: () {
                              //TODO burada text_activity ise text'i paylaş değilse, fotoğrafı paylaş ilgili forum sayfasına yönlendir
                              if (isTextActivity) {
                                //TODO Burada sharedPreferences ile text'i kaydet text_activity adlı bir değişkende tut
                                showSnackBar(context,
                                    "Yazdığınız şaheseri kopyalayıp, Forum sayfasındaki Etkinlikler kısmında ilgili etkinliğin altında paylaşabilirsiniz. 🥳🤩");
                              } else {
                                //TODO burada resmi galeriye kaydetme işlemleri olacak screenshot library'si ile
                                showSnackBar(context,
                                    "Yaptığınız etkinlik görselini galerinize kaydettikten sonra, Forum sayfasındaki Etkinlikler kısmında ilgili etkinliğin altında paylaşabilirsiniz.🥳🤩");
                              }
                            },
                            child: const Text("Paylaş")),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void _saveText(int index, String textFieldText) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("string_activity_$index", textFieldText);
}

void _getText(int index, TextEditingController controller) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String text = prefs.getString("string_activity_$index") ?? "";
  controller.text = text;
}
