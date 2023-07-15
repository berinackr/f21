import 'package:f21_demo/core/google_ads.dart';
import 'package:f21_demo/core/utils.dart';
import 'package:f21_demo/features/forum/screens/forum_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:readmore/readmore.dart';
import '../../../core/custom_styles.dart';

class GuestHomeScreenBottombar extends StatefulWidget {
  const GuestHomeScreenBottombar({super.key});

  @override
  State<GuestHomeScreenBottombar> createState() =>
      _GuestHomeScreenBottombarState();
}

final GoogleAds _googleAds = GoogleAds();

class _GuestHomeScreenBottombarState extends State<GuestHomeScreenBottombar> {
  @override
  void initState() {
    _googleAds.loadBannerAd(
      adLoaded: () {
        setState(() {});
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    CustomStyles().responsiveTheme(isDarkMode);
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: CustomStyles.fillColor
                        //borderRadius: BorderRadius.circular(40),
                        ),

                    //anasayfadaki doktor önerisi kısmı
                    child: Column(
                      children: [
                        WaveContainer(),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            children: [
                              const SizedBox(width: 25),
                              Image.asset(
                                "assets/images/doctor.png",
                                width: 40,
                                color: CustomStyles.forumTextColor,
                              ),
                              const SizedBox(width: 10),
                              const Text(
                                "Haftanın Doktor Önerisi",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Icon(
                                Icons.favorite,
                                size: 40,
                                color: CustomStyles.forumTextColor,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: Align(
                            alignment: Alignment.center,
                            child: ReadMoreText(
                              //buradaki textleri başka bir classtan haftalık düzeni kontrol ederek çekeceğiz.
                              'Alanında uzman doktorlar tarafından paylaşılan bebeğiniz hakkında bilmeniz gereken önerileri görebilmek için önce giriş yapmalısınız',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                              lessStyle: TextStyle(
                                  color: CustomStyles.primaryColor,
                                  fontWeight: FontWeight.bold),
                              moreStyle: TextStyle(
                                  color: CustomStyles.primaryColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (_googleAds.bannerAd != null)
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox(
                        width: _googleAds.bannerAd!.size.width.toDouble(),
                        height: _googleAds.bannerAd!.size.height.toDouble(),
                        child: AdWidget(ad: _googleAds.bannerAd!),
                      ),
                    ),
                  Container(),
                  //anasayfadan forum kısmına geçiş

                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: CustomStyles.backgroundColor),
                    child: Column(
                      children: [
                        WaveContainer(),
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              children: [
                                const Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Forum',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Text(
                                    " Diğer anneler tarafından açılmış popüler konuları ve konu başlıklarını görüntüleyebilirsin, ancak soru sormak ve cevap vermek için önce giriş yapmalısınız.",
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const ForumScreen()));
                                  },
                                  child: Container(
                                    height: 80,
                                    width: 80,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: CustomStyles.backgroundColor,
                                      boxShadow: const [
                                        BoxShadow(
                                          blurRadius: 10,
                                          spreadRadius: 1,
                                        )
                                      ],
                                    ),
                                    child: Image.asset(
                                      'assets/images/forum_icon.png',
                                      width: 80,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //anasayfadan meditasyon kısmına geçiş

                  const SizedBox(height: 20),

                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: CustomStyles.backgroundColor,
                    ),
                    child: Column(
                      children: [
                        WaveContainer(),
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              children: [
                                const Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Meditasyon',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Text(
                                    " Sağlıklı bir hamilelik ve bebek sağlığı için en önemli şeylerden birisi huzurdur. Meditasyon arayüzümüzdeki sizin için özenle seçmiş olduğumuz ortam seslerini ve müziklerini kullanarak rahatlamak için önce giriş yapmalısınız.",
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    showSnackBar(context,
                                        "Meditasyon sayfasını görebilmek için önce üye olmalısınız.");
                                  },
                                  child: Container(
                                    height: 80,
                                    width: 80,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: CustomStyles.backgroundColor,
                                      boxShadow: const [
                                        BoxShadow(
                                          blurRadius: 10,
                                          spreadRadius: 1,
                                        )
                                      ],
                                    ),
                                    child: Image.asset(
                                      'assets/images/meditation_woman.png',
                                      width: 80,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  /*  Container(
                                width: MediaQuery.of(context).size.width,
                                padding: const EdgeInsets.all(20),
                                margin: const EdgeInsets.only(top: 30),
                                decoration: const BoxDecoration(
                                  color: CustomStyles.backgroundColor,
                                  //borderRadius: BorderRadius.circular(40),
                                  boxShadow: [
                                    BoxShadow(
                                      color: CustomStyles.fillColor,
                                      offset: Offset(0, 7),
                                      blurRadius: 10,
                                    ),
                                  ],
                                ),
                              ), */
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class WaveContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: WaveClipper(), // Dalgalı şekli oluşturan custom clipper
      child: Container(
        color: Color.fromARGB(255, 255, 191, 169), // İlk renk
        height: 120,
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                color: Color(0xff9BCDD2),
                height: 80,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height * 0.6);

    final firstControlPoint = Offset(size.width * 0.25, size.height);
    final firstEndPoint = Offset(size.width * 0.5, size.height * 0.8);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    final secondControlPoint = Offset(size.width * 0.75, size.height * 0.6);
    final secondEndPoint = Offset(size.width, size.height * 0.8);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(WaveClipper oldClipper) => false;
}
