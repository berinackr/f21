import 'package:f21_demo/core/custom_styles.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatGPTScreen extends StatefulWidget {
  const ChatGPTScreen({Key? key}) : super(key: key);

  @override
  State<ChatGPTScreen> createState() => _ChatGPTScreenState();
}

class _ChatGPTScreenState extends State<ChatGPTScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _response = "";
  bool _isLoading = false;
  String x1 = "DmevSyjU7rBDWMFNtXrPT3Blbk";
  String x2 = "FJzhSptQbWYWBgOuxL5eyv";

  Future<String> getResponseFromAPI(String search) async {
    try {
      final remoteConfig = FirebaseRemoteConfig.instance;
      await remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval: const Duration(hours: 1),
      ));
      String apiKey = "sk-$x1$x2";
      var url = Uri.https("api.openai.com", "/v1/completions");

      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      };

      Map<String, dynamic> body = {
        "model": 'text-davinci-003',
        "prompt":
            "'${search} ?' NOT : Biraz önce sorduğum soru eğer Anneler, Bebekler, Gebelik, Hamilelik, Sağlık, Bebek Bakımı, Beslenme ve benzeri konu başlıklarından çok uzaksa 'Biberon Yapay Zeka Modeli olarak anneler ve bebekleri hakkında konulara cevap verebilirim.' hata mesajını ver. Ayrıca tüm cevaplarının sonuna ‘Benim verdiğim tüm bilgiler öneri ve genel doğrulardır. Lütfen spesifik veya ciddi bir sorunuz varsa doktorunuza başvurunuz.’ bilgilendirme metnini ekle.",
        "max_tokens": 2000,
      };
      //hata yakalama ve response'u set etme
      var response =
          await http.post(url, headers: headers, body: jsonEncode(body));
      if (response.statusCode == 200) {
        var responseJson = jsonDecode(utf8.decode(response.bodyBytes));
        return responseJson["choices"][0]["text"];
      } else {
        throw Exception("Failed to get response from API");
      }
    } catch (e) {
      print("Caught exception: $e");
      return "";
    }
  }

  void _getResponse() async {
    setState(() {
      _isLoading = true;
    });

    try {
      String response = await getResponseFromAPI(
          Uri.encodeComponent(_searchController.text.toString()));
      setState(() {
        _response = response;
      });
    } catch (e) {
      _response = e.toString();
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomStyles.primaryColor,
        centerTitle: true,
        title: const Text("Biberon - Yapay Zeka"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(screenHeight / 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  hintText: 'Sorunuzu Buraya Giriniz',
                ),
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: screenHeight / 30),
              _isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _getResponse,
                      child: const Text("Cevabı Oluştur"),
                    ),
              SizedBox(height: screenHeight / 30),
              Card(
                child: _response.isNotEmpty
                    ? Padding(
                        padding: EdgeInsets.only(
                          top: 0,
                          left: screenHeight / 50,
                          right: screenHeight / 50,
                          bottom: screenHeight / 20,
                        ),
                        child: Text(_response),
                      )
                    : Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
