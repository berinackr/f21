import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:f21_demo/core/custom_styles.dart';
import 'package:f21_demo/features/auth/controller/auth_controller.dart';
import 'package:f21_demo/features/auth/screens/register_screen.dart';
import 'package:f21_demo/features/home/screens/guest_home_bottom_screen.dart';
import 'package:f21_demo/features/profile/widgets/profile_screen_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/providers/settings_repository.dart';

class GuestHomeScreen extends ConsumerStatefulWidget {
  const GuestHomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _GuestHomeScreenState();
}

class _GuestHomeScreenState extends ConsumerState<GuestHomeScreen> {
  bool toggle = false;

  void logOut(WidgetRef ref) {
    ref.read(authControllerProvider.notifier).logout();
  }

  @override
  void initState() {
    super.initState();
    checkDefaultUIMode(ref);
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    CustomStyles().responsiveTheme(isDarkMode);
    final bottomBarList = [const GuestHomeScreenBottombar()];
    final settings = ref.watch(settingsProvider);
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints viewportConstraints) =>
          Scaffold(
        body: bottomBarList[0],
        appBar: AppBar(
          backgroundColor: CustomStyles.primaryColor,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Color(0xffFF8551),
          ),
          actions: [
            IconButton(
              onPressed: () {
                context.push('/auth');
              },
              icon: const Icon(Icons.login),
            )
          ],
          title: const Text('Anasayfa'),
        ),
        drawer: SafeArea(
          child: LayoutBuilder(
            builder: (context, viewportConstraints) {
              return Stack(
                children: [
                  Drawer(
                    // Add a ListView to the drawer. This ensures the user can scroll
                    // through the options in the drawer if there isn't enough vertical
                    // space to fit everything.
                    child: Stack(
                      children: [
                        ListView(
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
                                  decoration: BoxDecoration(
                                      color: CustomStyles.primaryColor),
                                  accountName: const Text(
                                    "Misafir Kullanıcı",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  accountEmail: const Text(
                                    "",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  currentAccountPicture: CircleAvatar(
                                    backgroundImage: Image.asset(
                                      "assets/images/logo.png",
                                    ).image,
                                  ),
                                ),
                                Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 10, 10, 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                          icon: settings.isSilentMode()
                                              ? const Icon(
                                                  Icons.notifications_off,
                                                  color: Colors.red,
                                                )
                                              : const Icon(
                                                  Icons.notifications_active,
                                                  color: Colors.white,
                                                ),
                                          onPressed: () {
                                            toggleSilentMode(ref);
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
                                Icons.person_add,
                              ),
                              title: const Text('Kayıt ol'),
                              onTap: () {
                                context.push('/auth');
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
                              child: Text('Hakkımızda'),
                            ),
                            ListTile(
                              leading: const Icon(Icons.privacy_tip),
                              title: const Text("Gizlilik Politikası"),
                              onTap: () {
                                showContractPopup(context);
                              },
                            ),
                            const AboutListTile(
                              icon: Icon(
                                Icons.contact_mail,
                              ),
                              applicationIcon: Icon(
                                Icons.local_play,
                              ),
                              applicationName: 'Biberon App',
                              aboutBoxChildren: [Text("biberonapp@gmail.com")],
                              child: Text('Bize Ulaşın'),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: SizedBox(
                              height: 50,
                              width: 120,
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: CustomStyles
                                        .fillColor, // Beyaz çizgi rengi
                                    width: 2, // Beyaz çizgi kalınlığı
                                  ),
                                  borderRadius: BorderRadius.circular(
                                      8), // Kenar yuvarlatma
                                ),
                                child: ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: Colors.red[900],
                                    shadowColor: Colors.black,
                                    elevation: 4,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                  ),
                                  onPressed: () {
                                    logOut(ref);
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(
                                    Icons.exit_to_app,
                                    color: Colors.white,
                                  ),
                                  label: const Text(
                                    'Çıkış',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        bottomNavigationBar: ConvexAppBar(
          backgroundColor: CustomStyles.primaryColor,
          initialActiveIndex: 0,
          items: const [
            TabItem(icon: Icons.home, title: 'Anasayfa'),
          ],
        ),
      ),
    );
  }
}
