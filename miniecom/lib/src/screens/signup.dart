import 'package:miniecom/src/screens/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import '../blocs/signupprovider.dart';

class SignupScreen extends StatelessWidget {
  Widget build(context) {
    final signupBloc = SignupProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: TextSpan(
              text: "SignUp",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              )),
        ),
        backgroundColor: Colors.orange,
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [Container(
          margin: EdgeInsets.all(10.0),
          child: Column(
            children: [
              nameField(signupBloc),
              emailField(signupBloc),
              newpasswordField(signupBloc),
              // PasswordField(hint: "Password"),
              // PasswordField(hint: "Retype Password"),

              retypepasswordField(signupBloc),
              createAccount(context, signupBloc),
            ],
          )),
          Container(color: Colors.grey[200],)
          ],
          
      )
    );
  }

  Widget nameField(SignupBloc signupBloc) {
    return StreamBuilder(
        stream: signupBloc.name,
        builder: (context, snapshot) {
          return Container(
            margin: EdgeInsets.all(20.0),
            child: TextField(
              onChanged: signupBloc.changeName,
              decoration: InputDecoration(
                border: InputBorder.none,
                icon: Icon(Icons.person),
                hintText: "Enter you Name",
                errorText:
                    snapshot.hasError ? (snapshot.error.toString()) : null,
                contentPadding: EdgeInsets.all(10.0),
                iconColor: Colors.grey,
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

  Widget newpasswordField(SignupBloc signupBloc) {
    return StreamBuilder(
        stream: signupBloc.password,
        builder: (context, snapshot) {
          return Container(
            margin: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: TextField(
              onChanged: signupBloc.changePassword,
              obscureText: true,
              decoration: InputDecoration(
                border: InputBorder.none,
                icon: const Icon(Icons.lock),
                iconColor: Colors.grey,
                hintText: "Password",
                errorText:
                    snapshot.hasError ? (snapshot.error as String?) : null,
                contentPadding: const EdgeInsets.all(15.0),
              ),
              cursorHeight: 20.0,
            ),
          );
        });
  }

  Widget emailField(SignupBloc signupBloc) {
    return StreamBuilder(
        stream: signupBloc.email,
        builder: ((context, snapshot) {
          return Container(
            margin: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.grey[100]),
            child: TextField(
              onChanged: signupBloc.changeEmail,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                border: InputBorder.none,
                icon: Icon(Icons.email),
                hintText: "Email Address",
                errorText:
                    snapshot.hasError ? (snapshot.error.toString()) : null,
                contentPadding: EdgeInsets.all(10.0),
                iconColor: Colors.grey,
              ),
              cursorHeight: 20.0,
            ),
          );
        }));
  }

  Widget retypepasswordField(SignupBloc signupBloc) {
    return StreamBuilder(
        stream: signupBloc.confirmPassword,
        builder: ((context, snapshot) {
          return Container(
            margin: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: TextField(
              onChanged: signupBloc.changeConfirmPassword,
              obscureText: true,
              decoration: InputDecoration(
                border: InputBorder.none,
                icon: Icon(Icons.lock),
                iconColor: Colors.grey,
                hintText: "Confirm Password",
                errorText:
                    snapshot.hasError ? (snapshot.error.toString()) : null,
                contentPadding: EdgeInsets.all(15.0),
              ),
              cursorHeight: 20.0,
            ),
          );
        }));
  }

  Widget createAccount(context, SignupBloc signupBloc) {
    return StreamBuilder(
        stream: signupBloc.submitValid,
        builder: (context, snapshot) {
          return Container(
              margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
              width: 400,
              height: 40,
              child: TextButton(
                  onPressed: () {
                    if (snapshot.hasData) {
                      signupBloc.submitData(context);
                    } else {
                      null;
                    }
                  },
                  child: RichText(
                    text: TextSpan(
                        text: "Create Account",
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
}
// For show password Icon 
// class PasswordField extends StatefulWidget {

//   String? hint = '';
//   PasswordField({this.hint});
//   _PasswordFieldState createState() => _PasswordFieldState(hint: hint);
// }

// class _PasswordFieldState extends State<PasswordField> {
//   bool _obscureText = true;
//   final String? hint;
//   _PasswordFieldState({this.hint});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: TextField(
//         obscureText: _obscureText,
//         decoration: InputDecoration(
//           border: InputBorder.none,
//           labelText: hint,
//           icon: Icon(Icons.lock),
//           suffixIcon: IconButton(
//             icon: Icon(
//               _obscureText ? Icons.visibility : Icons.visibility_off,
//             ),
//             onPressed: () {
//               setState(() {
//                 _obscureText = !_obscureText;
//               });
//             },
//           ),
//         ),
        
//       ),
//     );
//   }
// }
