import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_jodi_admin/common_widgets/custom_spacer_widget.dart';
import 'package:my_jodi_admin/utils/constants.dart';
import 'package:my_jodi_admin/utils/fonts.dart';
import 'package:my_jodi_admin/view_demo.dart';

import 'firebase_options.dart';

void main() async{
  runApp(const MyApp());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
            const LoginScreen()
            )
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/matrimony.png",width: 200,height: 200,),
            const CircularProgressIndicator(color: AppColors.blackColor,)
          ],
        )
    );
  }
}
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Are you sure?'),
        content: const Text('Do you want to exit an App'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Yes'),
          ),
        ],
      ),
    )) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController username = TextEditingController();
    TextEditingController password = TextEditingController();
    return WillPopScope(
        onWillPop: _onWillPop,
        child:Scaffold(
            appBar: AppBar(title:Text("Login",style: AppFonts.extraBoldStyle(fontSize: 20,fontColor: AppColors.backgroundColorF5),
            ),
              backgroundColor: AppColors.blackColor,
              automaticallyImplyLeading: false,
            ),
            body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child:Image.asset("assets/images/matrimony.png",width: 200,height: 200,),
                    ),
                    Container(
                        width: double.maxFinite,
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.whiteFF,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.blackColor.withOpacity(.25),
                              offset: const Offset(0, 1),
                              blurRadius: 5,
                            ),
                          ],
                        ),
                        child:Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("User Name", style: AppFonts.extraBoldStyle(fontColor: Colors.black,fontSize: 15),),
                            TextField(
                                controller: username,
                                decoration: const InputDecoration(
                                  icon: Icon(Icons.person,color: Colors.black,),
                                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10)),borderSide: BorderSide(color: Colors.black, width: 2)),//icon at head of input
                                )
                            ),
                            const CustomSpacerWidget(height: 20,),
                            Text("Password", style: AppFonts.extraBoldStyle(fontColor: Colors.black,fontSize: 15),),
                            TextField(
                                controller: password,
                                decoration: const InputDecoration(
                                  icon: Icon(Icons.password,color: Colors.black,),
                                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10)),borderSide: BorderSide(color: Colors.black, width: 2)),//icon at head of input
                                )
                            ),
                            const CustomSpacerWidget(height: 20,),
                          ],
                        )
                    ),
                    const CustomSpacerWidget(height: 20,),
                    Center(
                        child:GestureDetector(
                          onTap: ()  {
                            if(username.text == "Manoj" && password.text == "manoj@123"){
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const Page1()));
                              Fluttertoast.showToast(
                                  msg: "Login Successfully",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM // Also possible "TOP" and "CENTER"
                              );
                            }
                            else if(username.text.isEmpty && password.text.isEmpty){
                              Fluttertoast.showToast(
                                  msg: "Please Enter Details",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM // Also possible "TOP" and "CENTER"
                              );
                            }
                            else{
                              Fluttertoast.showToast(
                                  msg: "Incorrect User Name or Password",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM // Also possible "TOP" and "CENTER"
                              );
                            }

                          },
                          child: Container(
                              width: 150,
                              height: 50,
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: AppColors.blackColor,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.blackColor.withOpacity(.25),
                                    offset: const Offset(0, 1),
                                    blurRadius: 5,
                                  ),
                                ],
                              ),
                              child: Center(
                                  child: Text("Login",style: AppFonts.extraBoldStyle(fontColor: Colors.white,fontSize: 15),)
                              )
                          ),
                        )),
                  ],
                )
            )
        ))  ;
  }
}
class Page1 extends StatelessWidget {
  const Page1({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> usersStream = FirebaseFirestore.instance.collection('Customer Details').snapshots();
    return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const CustomSpacerWidget(height: 150,),
                Image.asset("assets/images/matrimony.png",width: 80,height: 80,),
                Text("Home", style: AppFonts.regularStyle(fontColor: Colors.black,fontSize: 15),),
              ],
            ),
            Padding(padding: const EdgeInsets.only(left: 10),
              child: Row(
                children: [
                  const Icon(Icons.calendar_month),
                  const CustomSpacerWidget(width: 5,),
                  Text("Chithirai 12(Subamugurtha Naal)", style: AppFonts.extraBoldStyle(fontColor: Colors.black,fontSize: 15),),
                ],
              ),
            ),

            Padding(padding: const EdgeInsets.only(left: 10),
                child:Text("Hai, User",style: AppFonts.extraBoldStyle(fontSize: 25,fontColor: AppColors.blackColor),)),
            const CustomSpacerWidget(height: 10),
            SizedBox(
              width: double.maxFinite,
              height: double.maxFinite,
              child: StreamBuilder<QuerySnapshot>(
                stream: usersStream,
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if(snapshot.data!.docs.isEmpty){
                    return const Center(child: Text('No Data',style: TextStyle(fontSize: 20,color: Colors.black),),);
                  }
                  return ListView(
                    children: snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                      return GestureDetector(
                          onTap: (){
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const ViewDemo()));
                          },
                          child: Container(
                              width: double.maxFinite,
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: AppColors.whiteFF,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.blackColor.withOpacity(.25),
                                    offset: const Offset(0, 1),
                                    blurRadius: 5,
                                  ),
                                ],
                              ),
                              child:Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Image.asset("assets/images/profile.png",width: 150,height: 150,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("Name : " + data["First Name"] + " " + data["Last Name"], style: AppFonts.regularStyle(fontColor: Colors.black,fontSize: 15),),
                                          const CustomSpacerWidget(height: 10),
                                          Text("Age : " + data["Age"], style: AppFonts.regularStyle(fontColor: Colors.black,fontSize: 15),),
                                          const CustomSpacerWidget(height: 10),
                                          Text("Religion : "+data["Religion"], style: AppFonts.regularStyle(fontColor: Colors.black,fontSize: 15),),
                                          const CustomSpacerWidget(height: 10),
                                          Text("Location : "+data["Address"], style: AppFonts.regularStyle(fontColor: Colors.black,fontSize: 15),),
                                        ],
                                      )
                                    ],
                                  ),
                                  const CustomSpacerWidget(height: 20,),
                                  GestureDetector(
                                    onTap: (){
                                      AlertDialog alert = AlertDialog(
                                        title: const Text('Are you sure?'),
                                        content: const Text('Want to Remove Member'),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () => Navigator.of(context).pop(false),
                                            child: const Text('No'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                      FirebaseFirestore.instance.collection("Customer Details").doc(document.id).delete();
                                      Fluttertoast.showToast(
                                          msg: "Removed Successfully",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM // Also possible "TOP" and "CENTER"
                                      );
                                      Navigator.of(context).pop(false);
                                      } ,
                                            child: const Text('Yes'),
                                          ),
                                        ],
                                      );
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return alert;
                                        },
                                      );
                                    },
                                    child: Container(
                                        width: 50,
                                        height: 50,
                                        padding: const EdgeInsets.all(10),
                                        margin: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: AppColors.whiteFF,
                                          borderRadius: BorderRadius.circular(12),
                                          boxShadow: [
                                            BoxShadow(
                                              color: AppColors.blackColor.withOpacity(.25),
                                              offset: const Offset(0, 1),
                                              blurRadius: 5,
                                            ),
                                          ],
                                        ),
                                        child:const Icon(Icons.delete))
                                  ),
                                  const CustomSpacerWidget(height: 20,),
                                ],
                              )
                          )
                      );
                    }).toList(),
                  );
                },
              ),
            )

          ],
        )
    );
  }
}