import 'package:flutter/material.dart';
import 'dart:io';
import 'package:f21_demo/core/utils.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/custom_styles.dart';

final List<String> imgList = [
  'assets/images/logo.png',
  'assets/images/logo.png',
  'assets/images/logo.png',
  'assets/images/logo.png',
  'assets/images/logo.png',
  'assets/images/logo.png',
  ];

class ActivityScreen extends ConsumerStatefulWidget {
  final String? activityId;
  final String? activityType;
  const ActivityScreen({Key? key, required this.activityType, required this.activityId}) : super(key: key);


  @override
  ConsumerState createState() => _ActivityScreenState();
}

class _ActivityScreenState extends ConsumerState<ActivityScreen> {
  TextEditingController textarea = TextEditingController();

  File? postFile;
  void selectPostImage() async {
    final res = await pickImage();
    if (res != null) {
      setState(() {
        postFile = File(res.files.first.path!);
      });
    }
  }

  bool visibilityfotos = false;
  bool _isButtonDisabled = false;
  int flag = 0;

  void _changed(bool visibility, String field) {
    setState(() {
      if (field == "tag"){
        visibilityfotos = visibility;
      }
    });
  }

  final List<Widget> imageSliders = imgList
      .map((item) => Container(
    child: Container(
      margin: const EdgeInsets.all(5.0),
      child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
          child: Stack(
            children: <Widget>[
              Image.asset(item, fit: BoxFit.cover, width: 1000.0),
              Positioned(
                bottom: 0.0,
                left: 0.0,
                right: 0.0,
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(200, 0, 0, 0),
                        Color.fromARGB(0, 0, 0, 0)
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20.0),
                ),
              ),
            ],
          )),
    ),
  ))
      .toList();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("2. Ay Gebelik - Etkinlik"), //TODO bu kısım buraya yönlendirirken gelecek push edilirken context.push()'a parametre olarak verilecek örneklerine router altında hangi sayfada kullanıldıysa o ayfayı açarak görebilirsin
        //backgroundColor: Colors.redAccent,
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 25),
            GestureDetector(
              onTap: !visibilityfotos ? selectPostImage : null,
              child: Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: CustomStyles.fillColor,
                  border: Border.all(color: CustomStyles.titleColor, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: postFile != null
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(
                    postFile!,
                    fit: BoxFit.cover,
                  ),
                )
                    : Icon(
                  Icons.add_a_photo,
                  size: 50,
                  color: CustomStyles.titleColor,
                ),
              ),
            ),
            const SizedBox(height: 16),
            !visibilityfotos ? ElevatedButton(
              onPressed: () {
                if(_isButtonDisabled = true){
                  visibilityfotos ? null : _changed(true, "tag");
                }
                else{
                  //visibilityfotos ? null : _changed(true, "tag");
                  //_isButtonDisabled = true;
                }
              },
              child: const Text("Kaydet"),
            ): Container(),
            const SizedBox(height: 16),
            visibilityfotos ? const Text(
              "Diğer kullanıcıların fotoğraflarına göz at.",
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ): Container(),
            const SizedBox(height: 16),
            visibilityfotos ?  CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                aspectRatio: 2.0,
                enlargeCenterPage: true,
              ),
              items: imageSliders,
            ): Container(),
          ],
        ),
      ),
    );
  }
}