import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_levels_scrolling_map/game_levels_scrolling_map.dart';
import 'package:game_levels_scrolling_map/model/point_model.dart';
import 'package:go_router/go_router.dart';

import '../../../core/custom_styles.dart';
import '../../../models/user_model.dart';
import '../../auth/controller/auth_controller.dart';

class ActivityScreenBottombar extends ConsumerStatefulWidget {
  const ActivityScreenBottombar({super.key});

  @override
  ConsumerState createState() => _ActivityScreenBottombarState();
}

class _ActivityScreenBottombarState extends ConsumerState<ActivityScreenBottombar> {

  //bebek 24 aylıktan büyük mü kontrolü
  bool _isBabyBiggerThan24Months = false;
  late final bool isPregnant;

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
    return LayoutBuilder(
      builder: (context,viewportConstraints) {
        return Scaffold(
          bottomSheet: _isBabyBiggerThan24Months ? BottomSheet(
            backgroundColor: isDarkMode ? Colors.transparent : CustomStyles.primaryColor,
            //shadowColor: Colors.transparent,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            constraints: BoxConstraints(
              maxWidth: viewportConstraints.maxWidth
            ),
            builder: (context) {
              return Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Flexible(
                            child: Text(
                              style: TextStyle(
                                color: isDarkMode ? Colors.white : Colors.black,
                              ),
                                "Etkinliklerimiz yalnızca gebelik dönemindeki anneler ve 24 aydan küçük bebekler için tasarlanmıştır. Yeni etkinlikler için takipte kalın!"),
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
            onClosing: () {  },
          ) : const SizedBox(height: 0, width: 0,),
          extendBodyBehindAppBar: true,
          body: GameLevelsScrollingMap.scrollable(
            direction: Axis.horizontal,
            width: double.maxFinite,
            imageWidth: 3000,
            imageUrl: "assets/images/map_horizontal.png",
            svgUrl: "assets/images/map_horizontal.svg",
            points: points,
          ), // This trailing comma makes auto-formatting nicer for build methods.
        );
      }
    );
  }

  @override
  void initState() {
    super.initState();
    fillTestData();
  }

  List<PointModel> points = [];
  int current  = 0;
  void fillTestData() {
    UserModel? user = ref.read(userProvider);
    int babyMonths = calculateBabyMonth(user!.babyBirthDate!);
    isPregnant = user.isPregnant!;
    print("RECOX : babyMont $babyMonths");
    print("RECOX : isPregantn ${user.isPregnant!}");
    if(isPregnant){
      current = user.months!.toInt();
      //hamile olduğu durumda
      for(int i = 1; i < 10; i++){
        if(i < current){
          points.add(PointModel(100, pastActivity(i, true))); //TODO tamamlanan
        }
        else if(current == i){
          points.add(PointModel(100, currentActivity(i, true))); //TODO şuanki aktivite
        }
        else{
          points.add(PointModel(100, lockedActivity(i, true))); //TODO kiilitli aktivite
        }
      }
      for(int i = 1; i< 25; i++){
        points.add(PointModel(100, lockedActivity(i, false))); //TODO kiilitli aktivite
      }
    }else{
      if(babyMonths <= 24){ //bebek 24 aylıktan küçük
        current = babyMonths; //Şuan bu değer 1
      }else{
        setState(() {
          _isBabyBiggerThan24Months = true;
          current = 34;
        });
      }
      //hamile olmadığı durumda
      for(int i = 1; i < 10; i++){
        points.add(PointModel(100, pastActivity(i, true))); //TODO tamamlanan
      }
      for(int i = 1; i < 25; i++){
        if(i < current){
          points.add(PointModel(100, pastActivity(i, false))); //TODO tamamlanan
        }
        else if(current == i){
          points.add(PointModel(100, currentActivity(i, false))); //TODO şuanki aktivite
        }
        else{
          points.add(PointModel(100, lockedActivity(i, false))); //TODO kiilitli aktivite
        }
      }
    }





    /*for (int i = 1; i < 34; i++) {
      if(i > 9){ //TODO sanırım burası doğumdan sonrası
        if(i < current){
          points.add(PointModel(100, testWidgetPass(i-9, 1))); //TODO (order, flag) order kaçıncı ay olduğunu hesaplamada kullanılıyor
        }
        if(current == i && !user.isPregnant!){
          points.add(PointModel(100, testWidgetCurrent(i-9, 1)));
        }
        else{
          points.add(PointModel(100, testWidget(i-9, 1)));
        }
      }
      else{ //TODO Burası da doğumdan öncesi i<9
        if(i < current){
          points.add(PointModel(100, testWidgetPass(i, 0))); //TODO tamamlanan
        }
        else if(current == i){
          points.add(PointModel(100, testWidgetCurrent(i, 0))); //TODO şuanki aktivite
        }
        else{
          points.add(PointModel(100, testWidget(i, 0))); //TODO kiilitli aktivite
        }
      }
    }*/

  }

  Widget lockedActivity(int ay, bool isPregnant) { //TODO kilitli aktivite
    String baslik = "Gebelik $ay.Ay Etkinliği";
    String btnYazisi = "\nGebelik\n $ay.Ay";
    if(!isPregnant){
      baslik = "Bebeğimin $ay. Ay Etkinliği";
      btnYazisi = "\nBebeğim\n$ay.Ay";
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
                        child: const Text('Kapat'),
                        onPressed: () {},
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
  Widget currentActivity(int ay, bool isPregnant) { //TODO kilitli gelecek aktivite
    String baslik = "Gebelik $ay. Ay Etkinliği";
    String btnYazisi = "\nGebelik\n$ay.Ay";
    int index = ay - 1;
    if(!isPregnant){
      baslik = "Bebeğimin $ay Aylık Etkinliği";
      btnYazisi = "\nBebeğim\n$ay.Ay";
      index = ay + 8;
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
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 80),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        child: const Text('Kapat'),
                        onPressed: () {
                          Navigator.pop(context); // Modal sayfasını kapat
                        },
                      ),
                      ElevatedButton(
                        style : ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.lightGreenAccent),
                        ),
                        child: const Text('Etkinliğe Başla', style: TextStyle(color: Colors.black)),
                        onPressed: () {
                          context.push("/home/$index/${getActivityType(index)}/$isPregnant"); //TODO index 0'dan başlıyor
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
  Widget pastActivity(int ay, bool isPregnant) { //TODO şuanki aktivite
    String baslik = "Gebelik $ay. Ay Etkinliği";
    String btnYazisi = "\nGebelik\n$ay.Ay";
    int index = ay - 1;
    if(!isPregnant){
      baslik = "Bebeğimin $ay Aylık Etkinliği";
      btnYazisi = "\nBebeğim\n$ay.Ay";
      index = ay + 8;
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
                crossAxisAlignment: CrossAxisAlignment.center,
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
                  ListTile(
                    title: Text(
                      etkinlik_list[index],
                      style: const TextStyle(
                        fontSize: 15,
                        //color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 80),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        child: const Text('Kapat'),

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

  int calculateBabyMonth(DateTime babyBirthDate){
    Duration diff = DateTime.now().difference(babyBirthDate);
    return (diff.inDays / 30).ceil(); //yaklaşık olarak her ayı 30 gün aldım
  }

  String getActivityType(int index){
    if(index == 0 || index == 9){ //TODO bana index olarak almamış gibi geldi sanki +1 koymuş o neenle böyle yaptım hatalı gelirse 0'a 8 ver
      return 'text_activity';
    }else{
      return 'photo_activity';
    }
  }
}
