import 'package:flutter/material.dart';
class ChatgptScreen extends StatefulWidget {
  const ChatgptScreen({super.key});

  @override
  State<ChatgptScreen> createState() => _ChatgptScreenState();
}

class _ChatgptScreenState extends State<ChatgptScreen> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      child: Center(child: Text("Haaaaaay")),
    );
  }
}


// class SoruWidgeti extends StatefulWidget {
//   SoruWidgeti({super.key});
//   final TextEditingController controller = TextEditingController();
//
//   @override
//   State<SoruWidgeti> createState() => _SoruWidgetiState();
// }
//
// class _SoruWidgetiState extends State<SoruWidgeti> {
//   TextEditingController _textEditingController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: TextField(
//         controller: _textEditingController,
//         keyboardType: TextInputType.multiline,
//         maxLines: 3,
//         decoration: InputDecoration(
//           hintText: "Sorunuzu yazınız...",
//           border: OutlineInputBorder(),
//         ),
//         style: TextStyle(
//           fontSize: 14,
//           color: Colors.black,
//         ),
//       ),
//     );
//   }
// }

