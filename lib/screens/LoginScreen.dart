import 'package:edu/screens/homescreen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rive/rive.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String animationURL;
  Artboard? _teddyArtboard;
  SMITrigger? successTriger, failTrigger;
  SMIBool? isHandsUp, isChecking;
  SMINumber? numLook;

  bool _isChecked = false;

  StateMachineController? stateMachineController;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override

  void initState(){
    super.initState();
    animationURL = defaultTargetPlatform == TargetPlatform.android ||
    defaultTargetPlatform == TargetPlatform.iOS
    ? 'assets/animations/bear_login.riv'
        : 'animations/bear_login.riv';
    rootBundle.load(animationURL).then(
        (data) {
          final file = RiveFile.import(data);
          final artboard = file.mainArtboard;
          stateMachineController =
              StateMachineController.fromArtboard(artboard, "State Machine 1");
          if (stateMachineController != null){
            artboard.addController(stateMachineController!);

            for(var e in stateMachineController!.inputs){
              debugPrint(e.runtimeType.toString());
              debugPrint("name${e.name}End");
            }

            for( var element in stateMachineController!.inputs){
              if(element.name == "success"){
                successTriger = element as SMITrigger;

              } else if (element.name == "faill"){
                failTrigger = element as SMITrigger;
              } else if (element.name == "hands_up"){
                isHandsUp = element as SMIBool;

              } else if(element.name == "Check"){
                isChecking = element as SMIBool;
              } else if( element.name == "Look"){
                numLook = element as SMINumber;
              }
            }
          }

          setState(() => _teddyArtboard = artboard);
        },
    );
  }

  void handsOnTheEyes(){
    isHandsUp?.change(true);
  }
  void lookOnTheTextField(){
    isHandsUp?.change(false);
    isChecking?.change(true);
    numLook?.change(0);
  }
  void moveEyeBalls(val){
    numLook?.change(val.length.toDouble());
  }

  void login(){
    isChecking?.change(false);
    isHandsUp?.change(false);

    //check login credentials

    if(_emailController.text == "mnymsuren37@gmail.com" &&
    _passwordController.text == "nymsuren"){
      successTriger?.fire();

      //add a 2-second delay before navigating

      Future.delayed(const Duration(seconds: 3), (){
        Navigator.push(context, MaterialPageRoute(builder: (context) =>
        const HomeScreen()),);
      });
    } else{
      failTrigger?.fire();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffd6e2ea),
      appBar: AppBar(
        backgroundColor: const Color(0xffd6e2ea),
        title: Text(
          '',
          style: GoogleFonts.aBeeZee(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 28
          ),
        ),

      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if(_teddyArtboard != null)
                SizedBox(
                  width: 400,
                  height: 300,
                  child: Rive(
                    artboard: _teddyArtboard!,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              Container(
                alignment: Alignment.center,
                width: 400,
                padding: const EdgeInsets.only(bottom: 15),
                margin: const EdgeInsets.only(bottom: 15 * 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Padding(padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
                        const SizedBox(height: 15 * 2,),
                        TextField(
                          controller: _emailController,
                          onTap: lookOnTheTextField,
                          onChanged: moveEyeBalls,
                          keyboardType: TextInputType.emailAddress,
                          style: GoogleFonts.poppins(fontSize: 14),
                          cursorColor: Colors.deepPurpleAccent,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.email,
                              color: Colors.deepPurpleAccent,
                            ),
                            hintText: "Имейл",
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            focusColor: Colors.deepPurpleAccent,
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.deepPurpleAccent,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15,),
                        TextField(
                          controller: _passwordController,
                          onTap: handsOnTheEyes,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          style: GoogleFonts.poppins(fontSize: 14),
                          cursorColor: Colors.deepPurpleAccent,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Colors.deepPurpleAccent,
                            ),
                            hintText: "Нууц үг",
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            focusColor: Color(0xffb04863),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.deepPurpleAccent,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                    activeColor: Colors.deepPurpleAccent,
                                    value: _isChecked,
                                    onChanged: (value){
                                      setState(() {
                                        _isChecked = value!;
                                      });
                                },
                                ),
                                Text("Намайг сана",style: GoogleFonts.poppins(),)
                              ],
                            ),
                            ElevatedButton(onPressed: login,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.deepPurpleAccent,
                                ),
                                child: Text(
                                  "Нэвтрэх",
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            ),
                          ],
                        ),
                      ],
                    ),),
                  ],
                ),
              ),
              const SizedBox(height: 150,),
            ],
          ),
        ),
      ),
    );
  }
}
