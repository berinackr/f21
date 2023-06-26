import 'package:f21_demo/core/custom_styles.dart';
import 'package:flutter/material.dart';

class MeditationScreen extends StatefulWidget {
  const MeditationScreen({super.key});

  @override
  State<MeditationScreen> createState() => _MeditationScreenState();
}

class _MeditationScreenState extends State<MeditationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: CustomStyles.primaryColor,
          image: DecorationImage(
              image: AssetImage('assets/images/home-bg.png'),
              fit: BoxFit.cover),
        ),
        child: CustomScrollView(
          slivers: [
            const SliverAppBar(
              backgroundColor: Colors.transparent,
              title: Text(
                'Meditasyon Vakti',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            sliverList(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                child: const Text(
                  'Unutmayın bebekler 17. haftadan itibaren sesleri duymaya başlar. Bu sakinleştirici seslerle beraber hem kendinizi hem bebeğinizi rahatlatın.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ),
            sliverList(
                child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 0,
              ),
              height: 130,
              child: ListView(
                // shrinkWrap: true,
                primary: false,
                scrollDirection: Axis.horizontal,
                children: const [
                  IconBoxUI(
                    icon: 'assets/images/all.png',
                    title: 'Tümü',
                    isSelected: true,
                  ),
                  IconBoxUI(
                    icon: 'assets/images/love.png',
                    title: 'Beğenilen',
                  ),
                  IconBoxUI(
                    icon: 'assets/images/happy.png',
                    title: 'Neşeli',
                  ),
                  IconBoxUI(
                    icon: 'assets/images/sleep.png',
                    title: 'Uyku',
                  ),
                  IconBoxUI(
                    icon: 'assets/images/child.png',
                    title: 'Çocuk',
                  ),
                ],
              ),
            )),
            sliverList(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(15),
                height: 210,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/ocean-moon-bg.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            color: CustomStyles.backgroundColor,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.lock,
                            size: 15,
                            color: Colors.white.withOpacity(0.8),
                          ),
                        )
                      ],
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Meditasyon',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            child: Text(
                              'Tüm playlisti karışık şekilde çalmaya başla',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                              elevation: 5,
                              foregroundColor: Colors.black.withOpacity(0.8),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                            child: Text('Start'.toUpperCase()),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverGrid.count(
              crossAxisCount: 2,
              childAspectRatio: 1,
              crossAxisSpacing: 10,
              // mainAxisSpacing: 10,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: CustomStyles.primaryColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 6,
                        child: Container(
                          decoration: BoxDecoration(
                            color: CustomStyles.primaryColor,
                            borderRadius: BorderRadius.circular(15),
                            image: const DecorationImage(
                              image: AssetImage('assets/images/night-card.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      const Expanded(
                          flex: 4,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Uyku',
                                  style: TextStyle(
                                    color: Color(0xffE6E7F2),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  'Hemen uykuya dal',
                                  style: TextStyle(
                                    color: Color(0xff98A1BD),
                                    fontSize: 14,
                                  ),
                                )
                              ],
                            ),
                          ))
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: CustomStyles.primaryColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 6,
                        child: Container(
                          decoration: BoxDecoration(
                            color: CustomStyles.primaryColor,
                            borderRadius: BorderRadius.circular(15),
                            image: const DecorationImage(
                              image:
                                  AssetImage('assets/images/night-card2.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      const Expanded(
                          flex: 4,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Sakinleş',
                                  style: TextStyle(
                                    color: Color(0xffE6E7F2),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  'Sakinleştirici mekan sesleri',
                                  style: TextStyle(
                                    color: Color(0xff98A1BD),
                                    fontSize: 14,
                                  ),
                                )
                              ],
                            ),
                          ))
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: CustomStyles.primaryColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 6,
                        child: Container(
                          decoration: BoxDecoration(
                            color: CustomStyles.primaryColor,
                            borderRadius: BorderRadius.circular(15),
                            image: const DecorationImage(
                              image:
                                  AssetImage('assets/images/night-card2.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      const Expanded(
                          flex: 4,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Piyano',
                                  style: TextStyle(
                                    color: Color(0xffE6E7F2),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  'Huzurlu Piyano Sesleri',
                                  style: TextStyle(
                                    color: Color(0xff98A1BD),
                                    fontSize: 14,
                                  ),
                                )
                              ],
                            ),
                          ))
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: CustomStyles.primaryColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 6,
                        child: Container(
                          decoration: BoxDecoration(
                            color: CustomStyles.primaryColor,
                            borderRadius: BorderRadius.circular(15),
                            image: const DecorationImage(
                              image: AssetImage('assets/images/night-card.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      const Expanded(
                          flex: 4,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Neşelen',
                                  style: TextStyle(
                                    color: Color(0xffE6E7F2),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  'Neşeli Müzikler',
                                  style: TextStyle(
                                    color: Color(0xff98A1BD),
                                    fontSize: 14,
                                  ),
                                )
                              ],
                            ),
                          ))
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

SliverList sliverList({required Widget child}) {
  return SliverList(
    delegate: SliverChildListDelegate([child]),
  );
}

class IconBoxUI extends StatelessWidget {
  const IconBoxUI({
    Key? key,
    required this.title,
    required this.icon,
    this.isSelected = false,
  }) : super(key: key);

  final String title;
  final String icon;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 60,
            width: 60,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: isSelected
                  ? CustomStyles.backgroundColor
                  : const Color(0xff586894),
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(0.2),
                  offset: const Offset(0, 5),
                  blurRadius: 6,
                ),
              ],
            ),
            child: ImageIcon(
              AssetImage(
                icon,
              ),
              color: Colors.white.withOpacity(0.8),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 15,
              // fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}
