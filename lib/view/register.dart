import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/register_controller.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final provider = Provider.of<RegisterController>(context, listen: false);

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
                  key: formKey,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextFormField(
                            controller: provider.usernameController,
                            decoration: InputDecoration(
                                hintText: 'userName',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20))),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a username';
                              } else {
                                return null;
                              }
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: provider.emailController,
                            decoration: InputDecoration(
                                hintText: 'email',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20))),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter an email';
                              } else {
                                return null;
                              }
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: provider.passwordController,
                            decoration: InputDecoration(
                                hintText: 'password',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20))),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a password';
                              } else {
                                return null;
                              }
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  await provider.registerAndGetToken(context);
                                } else {
                                  print('empty value');
                                }
                              },
                              child: const Text('Register'))
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
