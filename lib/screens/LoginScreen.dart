import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//FORM VALIDATOR EKLENECEK
//BUTONLAR BÜYÜYECEK
//EN ALTTAKİ TEXTLERE CLİCKABLE ÖZELLİĞİ EKLENECEK
//LOGO RESİM YUVARLAKLAŞTIRILACAK
//KULLANICIDAN GERÇEKTEN BİLGİ ALACAĞIZ


//----------
//FİREBASE İLE BAĞLAYACAĞIZ

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;
    final double screenWidth = screenSize.width;


    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Color.fromARGB(255, 155,174,209),
        ),
      ),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
              child: Container(
                color: const Color.fromARGB(255, 155,174,209),
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight
                ),
                child: IntrinsicHeight(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Spacer(
                          flex: 1,
                        ),
                        //Logo
                        CircleAvatar(
                          radius: screenWidth / 4,
                          backgroundImage: const AssetImage("assets/images/logo.png"),
                        ),
                        //Email Label
                        Padding(
                          padding: EdgeInsets.only(top: screenHeight / 30) +
                              EdgeInsets.only(left: screenHeight / 30),
                          child: const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Email",
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Color.fromARGB(255, 31, 4, 99),
                                ),
                              )),
                        ),
                        //Email TextField
                        Padding(
                          padding: EdgeInsets.fromLTRB(screenHeight / 30,screenHeight / 50,screenHeight / 30,screenHeight / 30),
                          child: const TextField(
                            decoration: InputDecoration(
                              hintText: "johndoe@gmail.com",
                              filled: true,
                              fillColor: Color.fromARGB(255, 236, 236, 236),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                            ),
                          ),
                        ),
                        //Password Label
                        Padding(
                          padding: EdgeInsets.only(top: screenHeight / 60) +
                              EdgeInsets.only(left: screenHeight / 30),
                          child: const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Password",
                              style: TextStyle(
                                fontSize: 24,
                                color: Color.fromARGB(255, 31, 4, 99),
                              ),
                            ),
                          ),
                        ),
                        //Password TextField
                        Padding(
                          padding: EdgeInsets.fromLTRB(screenHeight / 30,screenHeight / 50,screenHeight / 30,screenHeight / 30),
                          child: const TextField(
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: "Passw0rd!",
                              filled: true,
                              fillColor: Color.fromARGB(255, 236, 236, 236),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                            ),
                          ),
                        ),

                        //DENEME ŞİFRE TASARIMI SONRA DEFAULT OLANLAR YERİNE GEÇİRİLEBİLİR
                        /*Padding(
                          padding: const EdgeInsets.all(10),
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            color: Colors.transparent,
                            child: TextFormField(
                              cursorColor: const Color.fromARGB(255, 31, 4, 99),
                              initialValue: '',
                              //maxLength: 20, //şifrede karakter sınırı yok
                              decoration: const InputDecoration(
                                hoverColor: Colors.white,
                                fillColor: Colors.white,
                                icon: Icon(Icons.password_outlined),
                                hintText: "Şifrenizi tekrar girin",
                                labelText: 'Şifre Tekrar',
                                labelStyle: TextStyle(
                                  color: Color(0xFF6200EE),
                                ),
                                //helperText: 'Güçlü bir şifre için en az 8 karakter kullanın',
                                enabledBorder: OutlineInputBorder(
                                  gapPadding: 5,
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                  borderSide: BorderSide(
                                    style: BorderStyle.solid,
                                    color: Color.fromARGB(255, 31, 4, 99),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        */


                        //Login Buttons
                        //Giriş Yap Butonu
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                const Color.fromARGB(255, 249, 191, 178)),
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Giriş yap'a tıklandi")));
                            },
                            child: const Text(
                              "Giriş Yap",
                              style:
                              TextStyle(
                                  color: Color.fromARGB(255, 31, 4, 99)
                              ),
                            )
                        ),
                        const Spacer(
                          flex: 1,
                        ),
                        //Google ile Giriş Yap Butonu
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromARGB(255, 249, 191, 178)),
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                  content:
                                  Text("Google ile giriş yap'a tıklandi")));
                            },
                            child: Container(
                              constraints: BoxConstraints(
                                maxWidth: screenWidth * 0.5,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      child: Image.asset("assets/images/google_icon.png"),
                                    ),
                                   const Text(
                                  "Google ile Giriş Yap",
                                  style:
                                  TextStyle(
                                    fontSize: 15,
                                      color: Color.fromARGB(255, 31, 4, 99)
                                  ),
                                ),
                                  ],
                                ),
                              ),
                            )
                        ),

                        Expanded(child: Container()),
                        Padding(
                          padding: EdgeInsets.only(bottom: screenHeight/25),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: screenWidth/20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pushNamed("/forgotPasswordScreen");
                                    },
                                    child: const Text("Şifremi Unuttum",
                                      style: TextStyle(
                                          color: Color.fromARGB(255, 31, 4, 99),
                                          fontSize: 17
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                      onPressed: (){
                                        Navigator.of(context).pushNamed("/registerScreen");
                                  },
                                      child: const Text("Kayıt Ol",
                                        style: TextStyle(
                                            fontSize: 17,
                                            color: Color.fromARGB(255, 31, 4, 99),
                                            fontWeight: FontWeight.bold
                                        ),
                                      )
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ]),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
