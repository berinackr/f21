import 'package:f21_demo/features/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:readmore/readmore.dart';

class MyBabyScreenBottombar extends ConsumerStatefulWidget {
  const MyBabyScreenBottombar({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyBabyScreenBottombarState();
}


class _MyBabyScreenBottombarState extends ConsumerState<MyBabyScreenBottombar> {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Icon(
                  Icons.calendar_month,
                  color: Colors.orangeAccent,
                  size: 22,
                ),
              ),
              BaslangicWidget(ref: ref),
              DonemselBilgilendirme(),
              Align(
                alignment: Alignment.topLeft,
                child: Icon(
                  Icons.question_mark_rounded,
                  color: Colors.orangeAccent,
                  size: 24,
                ),
              ),
              SoruMetni(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SoruWidgeti(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SorButonu(),
                    )

                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class BaslangicWidget extends StatefulWidget {
  final WidgetRef ref;
  const BaslangicWidget({super.key, required this.ref});

  @override
  State<BaslangicWidget> createState() => _BaslangicWidgetState();
}

class _BaslangicWidgetState extends State<BaslangicWidget> {
  @override
  Widget build(BuildContext context) {
    final user = widget.ref.watch(userProvider);
    return Container(
      child: Center(
        child: Text(
          "Merhaba ${user!.username.toString()}, bu ay bebeğin hakkında bilmen gerekenler var;",
          style: TextStyle(
            fontSize: 22,
            fontFamily: "YsabeauInfant",
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 155, 48, 255),
          ),
        ),
      ),
    );
  }
}

class DonemselBilgilendirme extends StatefulWidget {
  const DonemselBilgilendirme({super.key});

  @override
  State<DonemselBilgilendirme> createState() => _DonemselBilgilendirmeState();
}

class _DonemselBilgilendirmeState extends State<DonemselBilgilendirme> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        child: Align(
          alignment: Alignment.center,
          child: ReadMoreText(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
            trimLines: 5,
            textAlign: TextAlign.left,
            trimMode:TrimMode.Line,
            trimCollapsedText: "Daha Fazla",
            trimExpandedText: "Daha Az",
            style: TextStyle(
              fontSize: 18
            ),
            lessStyle: TextStyle(
              color: Color.fromARGB(255, 54, 54, 54),
              fontFamily: "YsabeauInfant",
              fontWeight: FontWeight.bold,
            ),
            moreStyle: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
  }
}

class SoruMetni extends StatelessWidget {
  const SoruMetni({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Bebeğin Hakkında Merak Ettiklerini Sor ",
        style: TextStyle(
          fontSize: 22,
          fontFamily: "YsabeauInfant",
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 155, 48, 255),
        ),
      ),
    );
  }
}

class SoruWidgeti extends StatefulWidget {
  SoruWidgeti({super.key});
  final TextEditingController controller = TextEditingController();

  @override
  State<SoruWidgeti> createState() => _SoruWidgetiState();
}

class _SoruWidgetiState extends State<SoruWidgeti> {
  TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        controller: _textEditingController,
        keyboardType: TextInputType.multiline,
        maxLines: 3,
        decoration: InputDecoration(
          hintText: "Sorunuzu yazınız...",
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}

class SorButonu extends StatelessWidget {
  const SorButonu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        onPressed: (){
          print("butona tıklandı.");
        },
        child: const Text("SOR"),
        style: ElevatedButton.styleFrom(
        primary: Colors.purple,
    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
    textStyle: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    ),
        )
      )
    );
  }
}
