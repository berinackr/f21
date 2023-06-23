import 'package:f21_demo/core/common/loading_screen.dart';
import 'package:f21_demo/core/custom_styles.dart';
import 'package:f21_demo/features/auth/controller/auth_controller.dart';
import 'package:f21_demo/features/auth/screens/profile_data.dart';
import 'package:f21_demo/features/home/screens/forum_screen.dart';
import 'package:f21_demo/features/home/screens/meditation_screen.dart';
import 'package:f21_demo/features/profile/widgets/profile_screen_widgets.dart';
import 'package:f21_demo/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';
import 'package:readmore/readmore.dart';
import '../../../core/providers/settings_repository.dart';
import '../../auth/repository/auth_repository.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  bool toggle = false;

  void logOut(WidgetRef ref) {
    ref.read(authControllerProvider.notifier).logout();
  }

  @override
  Widget build(BuildContext context) {
    showSnackbarIfDarkModeChanges(ref, context);
    final user = ref.watch(userProvider);
    return user == null
        ? const LoadingScreen()
        : user.username == null
        ? const ExampleProfileData()
        : LayoutBuilder(
      builder: (BuildContext context,
          BoxConstraints viewportConstraints) =>
          Scaffold(
            backgroundColor: CustomStyles.backgroundColor,
            body: Padding(
              padding: const EdgeInsets.all(15),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color(0xffffe6e9),
                        //borderRadius: BorderRadius.circular(40),
                      ),

                      //anasayfadaki doktor önerisi kısmı
                      child: Column(
                        children: [
                          Padding(
                            padding:
                            const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              children: [
                                const SizedBox(width: 20),
                                Image.asset(
                                  "assets/images/doctor.png",
                                  width: 40,
                                  color: CustomStyles.primaryColor,
                                ),
                                const SizedBox(width: 10),
                                const Text(
                                  "Haftanın Doktor Önerisi",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(width: 10),
                                const Icon(
                                  Icons.favorite,
                                  size: 40,
                                  color: CustomStyles.primaryColor,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            child: const Align(
                              alignment: Alignment.center,
                              child: ReadMoreText(
                                //buradaki textleri başka bir classtan haftalık düzeni kontrol ederek çekeceğiz.
                                'Çocukların sağlıklı gelişimi için düzenli beslenme, '
                                    'yeterli uyku ve oyunlaştırılmış öğrenme ortamları sağlamak önemlidir.'
                                    ' Ayrıca, çocukların sağlıklı gelişimini desteklemek için düzenli uyku alışkanlıkları '
                                    'oluşturulmalı ve yaşlarına uygun uyku süresi sağlanmalıdır. Bunun yanı sıra, çocuklara'
                                    ' oyunlaştırılmış öğrenme ortamları sunularak keşfetme, sosyal etkileşim ve yaratıcılık'
                                    ' becerileri geliştirilmelidir.',
                                trimLines: 5,
                                textAlign: TextAlign.center,
                                trimMode: TrimMode.Line,
                                trimCollapsedText: "Devamını Oku",
                                trimExpandedText: "Küçült",
                                style: TextStyle(fontSize: 18),
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
                    //anasayfadan forum kısmına geçiş
                    const SizedBox(height: 20),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                const ForumScreen()));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color(0xffff9565),
                        ),
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
                                padding:
                                EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  " Diğer anneler tarafından açılmış popüler konuları ve konu başlıklarını görüntüleyin, soru sorun, cevap yazın ve iletişime geçin.",
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                              Image.asset(
                                'assets/images/forum_icon.png',
                                width: 80,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    //anasayfadan meditasyon kısmına geçiş

                    const SizedBox(height: 20),

                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                const MeditationScreen()));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color(0xffa1e5de),
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
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Padding(
                                padding:
                                EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  " Sağlıklı bir hamilelik ve bebek sağlığı için en önemli şeylerden birisi huzurdur. Meditasyon arayüzümüzdeki sizin için özenle seçmiş olduğumuz ortam seslerini ve müziklerini kullanarak rahatlayabilirsiniz.",
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                              Image.asset(
                                'assets/images/meditation_woman.png',
                                width: 120,
                              ),
                            ],
                          ),
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
            appBar: AppBar(
              backgroundColor: CustomStyles.primaryColor,
              actions: [
                IconButton(
                  onPressed: () {
                    showProfilePopUp(context, viewportConstraints, ref);
                  },
                  icon: const CircleAvatar(),
                )
              ],
              title: const Text('Anasayfa'),
            ),
            //-------------------------------------
            drawer: SafeArea(
              child: LayoutBuilder(
                builder: (context, viewportConstraints) {
                  return Drawer(
                    // Add a ListView to the drawer. This ensures the user can scroll
                    // through the options in the drawer if there isn't enough vertical
                    // space to fit everything.
                    child: ListView(
                      // Important: Remove any padding from the ListView.
                      padding: EdgeInsets.zero,
                      children: [
                        Stack(
                          children: [
                            UserAccountsDrawerHeader(
                              onDetailsPressed: () {
                                showProfilePopUp(
                                    context, viewportConstraints, ref);
                              },
                              arrowColor: Colors.transparent,
                              decoration: const BoxDecoration(
                                  color: CustomStyles.primaryColor),
                              accountName: Text(
                                user.username.toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              accountEmail: Text(
                                ref
                                    .read(authRepositoryProvider)
                                    .getCurrentUser()!
                                    .email!
                                    .toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              currentAccountPicture: const CircleAvatar(),
                            ),
                            Container(
                              padding:
                              const EdgeInsets.fromLTRB(0, 10, 10, 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                      icon: toggle
                                          ? const Icon(
                                        Icons.notifications_off,
                                        color: Colors.red,
                                      )
                                          : const Icon(
                                        Icons.notifications_active,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          toggle = !toggle;
                                        });
                                      }),
                                  IconButton(
                                      onPressed: () {
                                        toggleDarkMode(ref);
                                      },
                                      icon: const Icon(Icons.dark_mode)),
                                ],
                              ),
                            )
                          ],
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.person,
                          ),
                          title: const Text('Profilim'),
                          onTap: () {
                            //Profil ekranına gider
                            context.push('/home/profile');
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.camera,
                          ),
                          title: const Text('Fotoğraflarım'),
                          onTap: () {
                            // Update the state of the app
                            // ...
                            // Then close the drawer
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.settings,
                          ),
                          title: const Text('Ayarlar'),
                          onTap: () {
                            //Ayarlar ekranına gider
                            context.push('/home/settings');
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.logout,
                          ),
                          title: const Text('Çıkış yap'),
                          onTap: () {
                            logOut(ref);
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.delete,
                          ),
                          title: const Text('Hesabı sil'),
                          onTap: () {
                            // Update the state of the app
                            // ...
                            // Then close the drawer
                            Navigator.pop(context);
                          },
                        ),
                        const Divider(),
                        Container(
                          padding: const EdgeInsets.only(left: 20),
                          child: const Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: Text(
                              "İletişim Bilgileri",
                              //style: Theme.of(context).textTheme.caption,
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ),
                        const AboutListTile(
                          icon: Icon(
                            Icons.info,
                          ),
                          applicationIcon: Icon(
                            Icons.local_play,
                          ),
                          applicationName: 'Biberon App',
                          applicationVersion: '1.0.0',
                          applicationLegalese: '© 2023 Company',
                          aboutBoxChildren: [
                            ///Content goes he.re..
                          ],
                          child: Text('About app'),
                        ),
                        ListTile(
                          leading: const Icon(Icons.privacy_tip),
                          title: const Text("Privacy Policy"),
                          onTap: () {},
                        ),
                        ListTile(
                          leading: const Icon(Icons.contact_mail),
                          title: const Text("Contact us"),
                          onTap: () {},
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            //--------------------------------------

            bottomNavigationBar: ConvexAppBar(
              backgroundColor: CustomStyles.primaryColor,
              items: const [
                TabItem(icon: Icons.child_friendly, title: 'Bebeğim'),
                TabItem(icon: Icons.home, title: 'Anasayfa'),
                TabItem(
                    icon: Icons.celebration, title: 'Etkinlik Yolculuğu'),
              ],
              onTap: (int i) => {},
            ),
          ),
    );
  }
}