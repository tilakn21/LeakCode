import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:manga_mania/pages/auth/login_page.dart';
import 'package:manga_mania/pages/auth/gif_widget.dart';
import 'package:manga_mania/pages/main/main_page.dart';

class SignUpFormState extends ChangeNotifier {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String _errorMessage = '';

  bool validatePassword(String password) {
    _errorMessage = '';

    if (password.length < 8) {
      _errorMessage += 'Password must be longer than 8 characters.\n';
    }
    if (!password.contains(RegExp(r'[A-Z]'))) {
      _errorMessage += 'Password must contain at least one uppercase letter.\n';
    }
    if (!password.contains(RegExp(r'[a-z]'))) {
      _errorMessage += 'Password must contain at least one lowercase letter.\n';
    }
    if (!password.contains(RegExp(r'[0-9]'))) {
      _errorMessage += 'Password must contain at least one digit.\n';
    }
    if (!password.contains(RegExp(r'[!@#%^&*(),.?":{}<>]'))) {
      _errorMessage +=
          'Password must contain at least one special character.\n';
    }

    return _errorMessage.isEmpty;
  }

  void showAgeConfirmationDialog(BuildContext context, DateTime selectedDate) {
    final currentDate = DateTime.now();
    var age = currentDate.year - selectedDate.year;
    final monthDiff = currentDate.month - selectedDate.month;
    if (monthDiff < 0 ||
        (monthDiff == 0 && currentDate.day < selectedDate.day)) {
      age--;
    }
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.black,
        title: const Text(
          'Confirm Age',
          style: TextStyle(color: Colors.white),
        ),
        content: Text(
          'You are $age years old. Is this correct?',
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              'Yes',
              style: TextStyle(color: Colors.white),
            ),
          ),
          TextButton(
            onPressed: () {
              dobController.clear();
              Navigator.of(context).pop();
            },
            child: const Text(
              'No',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SignUpFormState(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Sign Up'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
          ),
        ),
        body: Consumer<SignUpFormState>(
          builder: (context, signUpFormState, child) {
            return Container(
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Form(
                        key: signUpFormState.formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: signUpFormState.nameController,
                                    style: const TextStyle(color: Colors.black),
                                    decoration: const InputDecoration(
                                      hintText: 'Name',
                                      hintStyle: TextStyle(color: Colors.black),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 3, color: Colors.black),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 3, color: Colors.black),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 3, color: Colors.black),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your name';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  child: TextFormField(
                                    controller:
                                        signUpFormState.surnameController,
                                    style: const TextStyle(color: Colors.black),
                                    decoration: const InputDecoration(
                                      hintText: 'Surname',
                                      hintStyle: TextStyle(color: Colors.black),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 3, color: Colors.black),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 3, color: Colors.black),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 3, color: Colors.black),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your surname';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: signUpFormState.emailController,
                              style: const TextStyle(color: Colors.black),
                              decoration: const InputDecoration(
                                hintText: 'Email',
                                hintStyle: TextStyle(color: Colors.black),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 3, color: Colors.black),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 3, color: Colors.black),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 3, color: Colors.black),
                                      ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter an email address';
                                }
                                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                    .hasMatch(value)) {
                                  return 'Please enter a valid email address';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: signUpFormState.passwordController,
                              style: const TextStyle(color: Colors.black),
                              obscureText: true,
                              decoration: const InputDecoration(
                                hintText: 'Password',
                                hintStyle: TextStyle(color: Colors.black),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 3, color: Colors.black),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 3, color: Colors.black),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 3, color: Colors.black),
                                      ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a password';
                                }
                                if (!signUpFormState.validatePassword(value)) {
                                  return 'Password does not meet the requirements';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller:
                                  signUpFormState.confirmPasswordController,
                              style: const TextStyle(color: Colors.black),
                              obscureText: true,
                              decoration: const InputDecoration(
                                hintText: 'Confirm Password',
                               hintStyle: TextStyle(color: Colors.black),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 3, color: Colors.black),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 3, color: Colors.black),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 3, color: Colors.black),
                                      ),
                              ),
                              validator: (value) {
                                if (value !=
                                    signUpFormState.passwordController.text) {
                                  return 'Passwords do not match';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: signUpFormState.dobController,
                              style: const TextStyle(color: Colors.black),
                              decoration: const InputDecoration(
                                hintText: 'Date of Birth',
                                hintStyle: TextStyle(color: Colors.black),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 3, color: Colors.black),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 3, color: Colors.black),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 3, color: Colors.black),
                                      ),
                              ),
                              onTap: () {
                                showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime.now(),
                                ).then((value) {
                                  if (value != null) {
                                    signUpFormState.dobController.text =
                                        '${value.day}/${value.month}/${value.year}';
                                    signUpFormState.showAgeConfirmationDialog(
                                        context, value);
                                  }
                                });
                              },
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Password must be at least 8 characters long, contain at least one uppercase letter, one lowercase letter, one digit, and one special character.',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 12),
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                if (signUpFormState.formKey.currentState!
                                    .validate()) {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const MainPage()),
                                  );
                                }
                              },
                              child: const Text(
                                'Sign Up',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Expanded(
                    flex: 3,
                    child: GifWidget(),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
