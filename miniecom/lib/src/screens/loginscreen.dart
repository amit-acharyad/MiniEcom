import 'package:miniecom/src/screens/agastyashop.dart';
import 'package:miniecom/src/screens/signup.dart';
import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';
import '../blocs/loginprovider.dart';

class LoginScreen extends StatelessWidget {
  Widget build(context) {
    final loginBloc = LoginProvider.of(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
      body: ListView(
        children: [
          Container(
                color: Colors.grey[200],
                child: Column(children: [
                  image(),
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white),
                    child: Column(
                      children: [
                        loginText(),
                        emailField(loginBloc),
                        passwordField(loginBloc),
                        Center(
                          child: keepLoggedin(),
                        ),
                        Center(
                          child: SingleChildScrollView(
                            child: Container(
                              constraints: BoxConstraints(
                                maxWidth:
                                    400.0, // Adjust the max width as needed
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  loginBtn(loginBloc),
                                  signupBtn(context),
                                  SizedBox(height: 110,),
                                  Row(
                                    children: [terms1(), terms2()],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                ],
                )
                )
        ],
      )
    ),
    );
  }

  Widget image() {
    return Container(
      padding: EdgeInsets.only(bottom: 10.0),
      child: Image.asset("assets/images/agastya.png"),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(40.0),
      ),
      height: 200,
    );
  }

  Widget loginText() {
    return Container(
      margin: EdgeInsets.all(20),
      child: RichText(
        text: TextSpan(
          text: "Login",
          style: TextStyle(
            color: Colors.orange,
            fontSize: 26.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget emailField(loginBloc) {
    return StreamBuilder(
        stream: loginBloc.email,
        builder: (context, snapshot) {
          return Container(
            margin: EdgeInsets.all(20.0),
            child: TextField(
              onChanged: loginBloc.changeEmail,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                border: InputBorder.none,
                icon: Icon(Icons.email),
                hintText: "Email address",
                contentPadding: EdgeInsets.all(10.0),
                iconColor: Colors.grey,
                errorText:
                    snapshot.hasError ? (snapshot.error as String?) : null,
              ),
              cursorHeight: 20.0,
            ),
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.grey[100]),
          );
        });
  }

  Widget passwordField(loginBloc) {
    return StreamBuilder(
        stream: loginBloc.password,
        builder: (context, snapshot) {
          return Container(
            margin: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: TextField(
              onChanged: loginBloc.changePassword,
              obscureText: true,
              decoration: InputDecoration(
                border: InputBorder.none,
                icon: const Icon(Icons.lock),
                iconColor: Colors.grey,
                hintText: "Password",
                errorText:
                  snapshot.hasError ? snapshot.error.toString() : null,
                contentPadding: const EdgeInsets.all(15.0),
              ),
              cursorHeight: 20.0,
            ),
            
          );
        });
  }

  Widget keepLoggedin() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Row(
            children: [
              Checkbox(
                value: false,
                onChanged: (value) {
                  print("checked");
                },
                checkColor: Colors.grey[200],
                activeColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                  side: BorderSide(color: Colors.blue),
                ),
              ),
              Text("Keep me Logged in"),
            ],
          ),
        ),
        Flexible(
          child: Container(
            padding: EdgeInsets.only(right: 10.0),
            alignment: Alignment.centerRight,
            child: RichText(
              text: TextSpan(
                text: "Forgot Password?",
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget loginBtn(loginBloc) {
    return StreamBuilder(
        stream: loginBloc.submitValid,
        builder: (context, snapshot) {
          return Container(
              margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
              width: 120,
              height: 40,
              child: TextButton(
                  // onPressed: snapshot.hasData
                  // ? loginBloc.submitData
                  // :null,
                  onPressed:(){
                    if(snapshot.hasData){
                      loginBloc.submitData(context);
                    }
                    else{
                      null;
                    }
                  },
              
                  child: RichText(
                    text: TextSpan(
                        text: "Login",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 224, 139, 12)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))))));
        });
  }

  
  Widget signupBtn(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichText(
              text: TextSpan(
                text: "New to Agastya?",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(width: 10), // Adjust the spacing as needed
            InkWell(
              child: RichText(
                text: TextSpan(
                  text: "SignUp",
                  style: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => SignupScreen()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  
  Widget terms1() {
    return Flexible(
        child: Container(
      margin: EdgeInsets.only(left: 50, bottom: 10),
      child: RichText(
        text: TextSpan(
          text: "By continuing, you agree to Agastya's",
          style: TextStyle(
              fontSize: 13.0, fontWeight: FontWeight.w100, color: Colors.black),
        ),
      ),
    ));
  }

  Widget terms2() {
    return Container(
      margin: EdgeInsets.only(bottom: 10, left: 3.0),
      child: InkWell(
        child: RichText(
          text: TextSpan(
            text: "Terms of Use",
            style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.w100,
                color: Colors.blue),
          ),
        ),
        onTap: () => launchUrl(Uri.parse("https://www.amazon.com")),
      ),
    );
  }
}
