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
  State<GuestHomeScreenBottombar> createState() => _GuestHomeScreenBottombarState();
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
            decoration: BoxDecoration(
              color: CustomStyles.primaryColor,
              image: const DecorationImage(image: AssetImage('assets/images/home-bg.png'), fit: BoxFit.cover),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: CustomStyles.backgroundColor,
                      //borderRadius: BorderRadius.circular(40),
                    ),

                    //anasayfadaki doktor önerisi kısmı
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            children: [
                              const SizedBox(width: 25),
                              Image.asset(
                                "assets/images/doctor.png",
                                width: 40,
                                color: CustomStyles.primaryColor,
                              ),
                              const SizedBox(width: 10),
                              const Text(
                                "Haftanın Doktor Önerisi",
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                              const SizedBox(width: 10),
                              Icon(
                                Icons.favorite,
                                size: 40,
                                color: CustomStyles.primaryColor,
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
                              style: const TextStyle(fontSize: 18, color: Colors.white),
                              lessStyle: TextStyle(color: CustomStyles.primaryColor, fontWeight: FontWeight.bold),
                              moreStyle: TextStyle(color: CustomStyles.primaryColor, fontWeight: FontWeight.bold),
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
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(20), color: CustomStyles.backgroundColor),
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
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              " Diğer anneler tarafından açılmış popüler konuları ve konu başlıklarını görüntüleyebilirsin, ancak soru sormak ve cevap vermek için önce giriş yapmalısınız.",
                              style: TextStyle(fontSize: 18, color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const ForumScreen()));
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
                  //anasayfadan meditasyon kısmına geçiş

                  const SizedBox(height: 20),

                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: CustomStyles.backgroundColor,
                    ),
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
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              " Sağlıklı bir hamilelik ve bebek sağlığı için en önemli şeylerden birisi huzurdur. Meditasyon arayüzümüzdeki sizin için özenle seçmiş olduğumuz ortam seslerini ve müziklerini kullanarak rahatlamak için önce giriş yapmalısınız.",
                              style: TextStyle(fontSize: 18, color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              showSnackBar(context, "Meditasyon sayfasını görebilmek için önce üye olmalısınız.");
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
