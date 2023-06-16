import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;
    final double screenWidth = screenSize.width;
    bool isChecked = false;


    return Scaffold(
      appBar: AppBar(
        //toolbarHeight: 0,
        backgroundColor: const Color.fromARGB(255, 155,174,209),
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Color.fromARGB(255, 155,174,209),
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
              child: Container(
                color: const Color.fromARGB(255, 155,174,209),
                constraints: BoxConstraints(
                  minWidth: viewportConstraints.maxWidth,
                  minHeight: viewportConstraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Spacer(
                        flex: 1,
                      ),
                      //Logo
                      CircleAvatar(
                        radius: screenWidth / 4,
                        backgroundImage: const AssetImage("assets/images/logo.png"),
                      ),
                      const Spacer(
                        flex: 1,
                      ),
                      //Email Label
                      Padding(
                        padding: EdgeInsets.only(left: screenHeight / 30),
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
                        padding: EdgeInsets.fromLTRB(screenHeight / 30, 0,screenHeight / 30,0),
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
                      const Spacer(
                        flex: 1,
                      ),
                      //Password Label
                      Padding(
                        padding: EdgeInsets.only(left: screenHeight / 30),
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
                        padding: EdgeInsets.fromLTRB(screenHeight / 30,0,screenHeight / 30,0),
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
                      const SizedBox(
                        height: 20,
                      ),
                      //Password Label
                      Padding(
                        padding: EdgeInsets.only(left: screenHeight / 30),
                        child: const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Password Again",
                            style: TextStyle(
                              fontSize: 24,
                              color: Color.fromARGB(255, 31, 4, 99),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(screenHeight / 30,0,screenHeight / 30,0),
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
                      const SizedBox(
                        height: 20,
                      ),
                      /*const Spacer(
                        flex: 1,
                      ),*/


                       Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.ads_click, color: Color.fromARGB(255, 31, 4, 99),),
                          TextButton(
                              onPressed: (){
                                //tiklayinca sozlesme ekranina gitmeli
                                  Navigator.of(context).pushNamed("/sozlesmeEkrani");
                              },
                              child: const Text("Sözleşmeyi Okudum, Onayladım.",
                                style: TextStyle(
                                  color: Colors.blueAccent,
                                ),
                              )
                          ),
                          StatefulBuilder(builder: (context, setState) {
                            return Checkbox(
                              checkColor: Colors.black,
                              value: isChecked,
                              onChanged: (checked){
                                setState(() {
                                  isChecked = checked!;
                                });
                              },
                            );
                          },
                          ),
                        ],
                      ),

                      //Kayıt Ol Butonu
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                              const Color.fromARGB(255, 249, 191, 178)),
                          onPressed: () {
                            if(isChecked == true){
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Kayıt ol ekranına yönlendiriliyor ...")));
                            }else{
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Lütfen öncelikle sözleşmeyi onaylayın!", style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold
                              ),)));
                            }
                          },
                          child: const Text(
                            "Kayıt ol",
                            style:
                            TextStyle(
                                color: Color.fromARGB(255, 31, 4, 99)
                            ),
                          )
                      ),
                      const Spacer(
                        flex: 1,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
