import 'package:flutter/material.dart';
import 'package:game_levels_scrolling_map/game_levels_scrolling_map.dart';
import 'package:game_levels_scrolling_map/model/point_model.dart';

import '../../../core/custom_styles.dart';

class ActivityScreenBottombar extends StatefulWidget {
  const ActivityScreenBottombar({super.key});

  @override
  State<ActivityScreenBottombar> createState() =>
      _ActivityScreenBottombarState();
}

class _ActivityScreenBottombarState extends State<ActivityScreenBottombar> {

  var etkinlik_list = [
    "Gebelik yolculuğunuzun ilk ayında, bebeğinizle bağınızı güçlendirmek için ona bir mektup yazın! Ona anne karnındaki maceraları ve hislerinizi anlatın, gelecekte birlikte yapmak istediğiniz şaşırtıcı planları paylaşın. Yazılan her harf, büyülü bir bağın başlangıcı olacak. Bebeğinize eğlenceli bir selam gönderin!",
    "2ccccccc",
    "3<<<<<<<<<",
    "4qqqqqqqqqqq",
    "5ccccccc",
    "6<<<<<<<<<",
    "7qqqqqqqqqqq",
    "8ccccccc",
    "9<<<<<<<<<",
    "1qqqqqqqqqqq",
    "2ccccccc",
    "3<<<<<<<<<",
    "4qqqqqqqqqqq",
    "5ccccccc",
    "6<<<<<<<<<",
    "7qqqqqqqqqqq",
    "8ccccccc",
    "9<<<<<<<<<",
    "10qqqqqqqqqqq",
    "11ccccccc",
    "12<<<<<<<<<",
    "13qqqqqqqqqqq",
    "14ccccccc",
    "15<<<<<<<<<",
    "16qqqqqqqqqqq",
    "17ccccccc",
    "18<<<<<<<<<",
    "19qqqqqqqqqqq",
    "20ccccccc",
    "21<<<<<<<<<",
    "22qqqqqqqqqqq",
    "23ccccccc",
    "24<<<<<<<<<",
  ];

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    CustomStyles().responsiveTheme(isDarkMode);
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
          child: GameLevelsScrollingMap.scrollable(
            direction: Axis.horizontal,
            width: double.maxFinite,
            imageWidth: 3000,
            imageUrl: "assets/images/map_horizontal.png",
            svgUrl: "assets/images/map_horizontal.svg",
            points: points,
          )), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  @override
  void initState() {
    //super.initState();
    fillTestData();
  }

  List<PointModel> points = [];
  int current = 11;

  void fillTestData() {
    int flag = 0;
    for (int i = 1; i < 34; i++) {
      if(i > 9){
        if(i < current){
          points.add(PointModel(100, testWidgetPass(i-9, 1)));
        }
        if(current == i){
          points.add(PointModel(100, testWidgetCurrent(i-9, 1)));
        }
        if(i > current){
          points.add(PointModel(100, testWidget(i-9, 1)));
        }
      }
      else{
        if(i < current){
          points.add(PointModel(100, testWidgetPass(i, 0)));
        }
        if(current == i){
          points.add(PointModel(100, testWidgetCurrent(i, 0)));
        }
        if(i > current){
          points.add(PointModel(100, testWidget(i, 0)));
        }
      }

      //points.add(PointModel(100, testWidget(i)));
    }
  }

  Widget testWidget(int order, int flag) {
    String baslik = "Gebelik $order.Ay Etkinliği";
    String btnYazisi = "\nGebelik\n $order.Ay";
    if(flag == 1){
      baslik = "Bebeğimin $order Aylık Etkinliği";
      btnYazisi = "\nBebeğim\n$order.Ay";
    }
    return InkWell(
      hoverColor: Colors.blue,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            "assets/images/map_horizontal_point(3).png",
            fit: BoxFit.fitWidth,
            width: 100,
          ),
          Text(btnYazisi,
              style: const TextStyle(color: Colors.black, fontSize: 20))
        ],
      ),
      onTap: () {
        showModalBottomSheet(
          context: context,
          shape: const RoundedRectangleBorder( // <-- SEE HERE
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(25.0),
            ),
          ),
          backgroundColor: Colors.grey,
          builder: (BuildContext context) {
            return Container(
              //color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    title: Text(
                      baslik,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const ListTile(
                    title: Align(
                      alignment: Alignment.center,
                      child: Icon(Icons.lock_outline, size: 80),
                    ),
                  ),
                  const SizedBox(height: 100),
                  Row(
                    children: [
                      ElevatedButton(
                        child: Text('Kapat'),

                        onPressed: () {
                          Navigator.pop(context); // Modal sayfasını kapat
                          /*
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GameFormPage(),
                        ),
                      ); */
                        },
                      ),
                      const ElevatedButton(
                        onPressed: null,
                        child: Text('Etkinliğe Başla'),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                ],
              ),
            );
          },
        );
      },
    );
  }
  Widget testWidgetCurrent(int order, int flag) {
    String baslik = "Gebelik $order. Ay Etkinliği";
    String btnYazisi = "\nGebelik\n$order.Ay";
    int index = order - 1;
    if(flag == 1){
      baslik = "Bebeğimin $order Aylık Etkinliği";
      btnYazisi = "\nBebeğim\n$order.Ay";
      index = order + 8;
    }
    return InkWell(
      hoverColor: Colors.blue,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            "assets/images/map_horizontal_point.png",
            fit: BoxFit.fitWidth,
            width: 100,
          ),
          Text(btnYazisi,
              style: const TextStyle(color: Colors.black, fontSize: 20))
        ],
      ),
      onTap: () {
        showModalBottomSheet(
          context: context,
          shape: const RoundedRectangleBorder( // <-- SEE HERE
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(25.0),
            ),
          ),
          backgroundColor: Colors.purpleAccent,
          builder: (BuildContext context) {
            return Container(
              //color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    title: Text(
                      baslik,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      etkinlik_list[index],
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 80),
                  Row(
                    children: [
                      ElevatedButton(
                        child: const Text('Kapat'),

                        onPressed: () {
                          Navigator.pop(context); // Modal sayfasını kapat
                          /*
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GameFormPage(),
                        ),
                      ); */
                        },
                      ),
                      ElevatedButton(
                        child: const Text('Etkinliğe Başla'),
                        onPressed: () {
                          /*
                        Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GameFormPage(),
                        ),
                      ); */
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),
                ],
              ),
            );
          },
        );
      },
    );
  }
  Widget testWidgetPass(int order, int flag) {
    String baslik = "Gebelik $order. Ay Etkinliği";
    String btnYazisi = "\nGebelik\n$order.Ay";
    int index = order-1;
    if(flag == 1){
      baslik = "Bebeğimin $order Aylık Etkinliği";
      btnYazisi = "\nBebeğim\n$order.Ay";
      index = order + 8;
    }
    return InkWell(
      hoverColor: Colors.blue,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            "assets/images/map_horizontal_point(2).png",
            fit: BoxFit.fitWidth,
            width: 100,
          ),
          Text(btnYazisi,
              style: const TextStyle(color: Colors.black, fontSize: 20))
        ],
      ),
      onTap: () {
        showModalBottomSheet(
          context: context,
          shape: const RoundedRectangleBorder( // <-- SEE HERE
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(25.0),
            ),
          ),
          backgroundColor: Colors.green[400],
          builder: (BuildContext context) {
            return Container(
              //color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    title: Text(
                      baslik,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  ListTile(
                    title: Text(
                      etkinlik_list[index],
                      style: TextStyle(
                        fontSize: 15,
                        //color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 80),
                  Row(
                    children: [
                      ElevatedButton(
                        child: Text('Kapat'),

                        onPressed: () {
                          Navigator.pop(context); // Modal sayfasını kapat
                        },
                      ),
                      const Text(
                        "   Etkinlik Tamamlandı",
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,),
                      const Icon(Icons.check_circle_outline, size: 25)
                    ],
                  ),

                  const SizedBox(height: 16),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
