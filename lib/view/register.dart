// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/controller/register_controller.dart';
// import 'package:provider/provider.dart';

// class RegisterPage extends StatelessWidget {
//   const RegisterPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final p = Provider.of<RegisterController>(context, listen: false);
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           TextFormField(
//             controller: p.emailController,
//             decoration: InputDecoration(labelText: 'email'),
//           ),
//           TextFormField(
//             controller: p.usernameController,
//             decoration: InputDecoration(labelText: 'username'),
//           ),
//           TextFormField(
//             controller: p.passwordController,
//             decoration: InputDecoration(labelText: 'password'),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           TextButton(
//               onPressed: () async{
//                 p.registerAndGetToken(context);
//               },
//               child: Text('submit'))
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/register_controller.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formkey = GlobalKey<FormState>();
    final provide = Provider.of<RegisterController>(context, listen: false);

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Form(
                  key: formkey,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextFormField(
                            controller: provide.usernameController,
                            decoration: InputDecoration(
                                hintText: 'userName',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20))),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter password';
                              } else {
                                return null;
                              }
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: provide.emailController,
                            decoration: InputDecoration(
                                hintText: 'email',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20))),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter password';
                              } else {
                                return null;
                              }
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: provide.passwordController,
                            decoration: InputDecoration(
                                hintText: 'password',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20))),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter password';
                              } else {
                                return null;
                              }
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                              onPressed: () async {
                                if (formkey.currentState!.validate()) {
                                  await provide.registerAndGetToken(context);
                                } else {
                                  print('empty value');
                                }
                              },
                              child: Text('register'))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
