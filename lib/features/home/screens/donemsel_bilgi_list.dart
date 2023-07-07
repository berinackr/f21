// import 'package:flutter/cupertino.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_riverpod/src/consumer.dart';
//
// import '../../../models/user_model.dart';
// import '../../auth/controller/auth_controller.dart';
//
// class Info {
//   final String name;
//   final String explanation;
//   final int id;
//
//   Info(this.name, this.explanation, this.id);
// }
//
// class Infos {
//   static final List<Info> _infos = [
//     Info("1. Ay Gebelik", "Bilgilendirme Metni", 1),
//     Info("2. Ay Gebelik", "Bilgilendirme Metni", 2),
//     Info("3. Ay Gebelik", "Bilgilendirme Metni", 3),
//     Info("4. Ay Gebelik", "Bilgilendirme Metni", 4),
//     Info("5. Ay Gebelik", "Bilgilendirme Metni", 5),
//     Info("6. Ay Gebelik", "Bilgilendirme Metni", 6),
//     Info("7. Ay Gebelik", "Bilgilendirme Metni", 7),
//     Info("8. Ay Gebelik", "Bilgilendirme Metni", 8),
//     Info("9. Ay Gebelik", "Bilgilendirme Metni", 9),
//     Info("1 Aylık Bebek", "Bilgilendirme Metni", 10),
//     Info("2 Aylık Bebek", "Bilgilendirme Metni", 11),
//     Info("3 Aylık Bebek", "Bilgilendirme Metni", 12),
//     Info("4 Aylık Bebek", "Bilgilendirme Metni", 13),
//     Info("5 Aylık Bebek", "Bilgilendirme Metni", 14),
//     Info("6 Aylık Bebek", "Bilgilendirme Metni", 15),
//     Info("7 Aylık Bebek", "Bilgilendirme Metni", 16),
//     Info("8 Aylık Bebek", "Bilgilendirme Metni", 17),
//     Info("9 Aylık Bebek", "Bilgilendirme Metni", 18),
//     Info("10 Aylık Bebek", "Bilgilendirme Metni", 19),
//     Info("11 Aylık Bebek", "Bilgilendirme Metni", 20),
//     Info("12 Aylık Bebek", "Bilgilendirme Metni", 21),
//     Info("13 Aylık Bebek", "Bilgilendirme Metni", 22),
//     Info("14 Aylık Bebek", "Bilgilendirme Metni", 23),
//     Info("15 Aylık Bebek", "Bilgilendirme Metni", 24),
//     Info("16 Aylık Bebek", "Bilgilendirme Metni", 25),
//     Info("17 Aylık Bebek", "Bilgilendirme Metni", 26),
//     Info("18 Aylık Bebek", "Bilgilendirme Metni", 27),
//     Info("19 Aylık Bebek", "Bilgilendirme Metni", 28),
//     Info("20 Aylık Bebek", "Bilgilendirme Metni", 29),
//     Info("21 Aylık Bebek", "Bilgilendirme Metni", 30),
//     Info("22 Aylık Bebek", "Bilgilendirme Metni", 31),
//     Info("23 Aylık Bebek", "Bilgilendirme Metni", 32),
//     Info("24 Aylık Bebek", "Bilgilendirme Metni", 33),
//
//   ];
//
//   static final Map<int, Info> _infosById = {
//     for(var info in _infos) info.id: info,
//   };
//
//   static String getInfoNameById(int id){
//     Info ? info = _infosById[id];
//     return info?.explanation?? "Unknown Info";
//   }
//   static List<Info> get all => _infos;
// }

//
//
//
//
// class BaslangicWidget extends StatefulWidget {
//   final WidgetRef ref;
//   const BaslangicWidget({super.key, required this.ref});
//
//   @override
//   State<BaslangicWidget> createState() => _BaslangicWidgetState();
// }
//
// class _BaslangicWidgetState extends State<BaslangicWidget> {
//   @override
//   Widget build(BuildContext context) {
//     final user = widget.ref.watch(userProvider);
//     return Container(
//       child: Center(
//         child: Text(
//           "Merhaba ${user!.username.toString()}, bu ay bebeğin hakkında bilmen gerekenler var;",
//           style: TextStyle(
//             fontSize: 22,
//             fontFamily: "YsabeauInfant",
//             fontWeight: FontWeight.bold,
//             color: Color.fromARGB(255, 155, 48, 255),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//







