import 'package:flutter/material.dart';
import 'package:task_tracker/screens/home.dart';
import 'package:task_tracker/screens/onboarding.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;
  bool _isPasswordVisible = false;
  bool _isPasswordValid = false;
  bool _acceptedTerms = false;

  void _submitForm() async {
    if (_formKey.currentState!.validate() && _acceptedTerms) {
      setState(() {
        isLoading = true;
      });

      await Future.delayed(const Duration(seconds: 2));

      // Save data
      final name = _nameController.text;
      final email = _emailController.text;
      final password = _passwordController.text;
      print('Name: $name, Email: $email, Password: $password');

      // Show a success snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
          'Registration successful!',
          style: TextStyle(
            fontFamily: 'Lato',
          ),
        )),
      );

      // Navigate to the home screen after a short delay
      await Future.delayed(const Duration(seconds: 1));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(userName: name),
        ),
      );

      setState(() {
        isLoading = false;
      });
    } else if (!_acceptedTerms) {
      // Show a snackbar asking to accept terms
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please accept the terms and conditions',
            style: TextStyle(
              fontFamily: 'Lato',
            ),
          ),
        ),
      );
    }
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  void _checkPasswordValidity(String password) {
    setState(() {
      _isPasswordValid = password.length >= 8;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Create an account',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontFamily: 'Lato',
            )),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Image.asset('assets/arrow.png', height: 24),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            children: [
              const SizedBox(height: 20.0),

              // Name
              const Text(
                'Name',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Lato',
                ),
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(width: 1.0, color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      width: 1.0,
                      color: Colors.black,
                    ),
                  ),
                  hintText: 'Enter your name',
                  hintStyle: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Lato',
                      color: Colors.grey),
                ),
                keyboardType: TextInputType.name,
                validator: (value) {
                  // Validate name field
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20.0),

              // Email
              const Text(
                'Email',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Lato',
                ),
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(width: 1.0, color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      width: 1.0,
                      color: Colors.black,
                    ),
                  ),
                  hintText: 'Enter your email',
                  hintStyle: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Lato',
                      color: Colors.grey),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  // Validate email field
                  if (value == null ||
                      !RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                          .hasMatch(value)) {
                    return 'Enter a valid email';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20.0),

              // Password
              const Text('Password',
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 8.0),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide:
                        const BorderSide(width: 1.0, color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      width: 1.0,
                      color: Colors.black,
                    ),
                  ),
                  hintText: 'Enter your password',
                  hintStyle: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Lato',
                      color: Colors.grey),
                  suffixIcon: IconButton(
                    icon: Image.asset(
                      _isPasswordVisible
                          ? 'assets/visible.png'
                          : 'assets/invisible.png',
                      height: 24,
                      width: 24,
                    ),
                    onPressed: _togglePasswordVisibility,
                  ),
                ),
                obscureText: !_isPasswordVisible,
                onChanged: _checkPasswordValidity,
                validator: (value) {
                  if (value == null || value.isEmpty || value.length < 8) {
                    return 'Password must have at least 8 characters';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 8.0),

              if (_isPasswordValid)
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 4.0),
                      child: Image.asset('assets/check_circle.png',
                          color: Colors.black, height: 14),
                    ),
                    const Text(
                      'Password must have at least 8 characters',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Lato',
                      ),
                    ),
                  ],
                ),

              const SizedBox(height: 20.0),

              // Terms and Conditions
              Row(
                children: [
                  Expanded(
                    child: RichText(
                      text: const TextSpan(
                        text: 'Agree to ',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Lato',
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Terms and Conditions',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Lato',
                                color: Color(
                                  0xFF005CE7,
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Switch(
                    value: _acceptedTerms,
                    activeColor: const Color(0xFF005CE7),
                    onChanged: (value) {
                      setState(() {
                        _acceptedTerms = value;
                      });
                    },
                  )
                ],
              ),

              const SizedBox(height: 60.0),

              // Register button
              if (isLoading)
                // Show progress indicator
                const Center(
                    child: CircularProgressIndicator(
                  backgroundColor: Color(0xFF005CE7),
                ))
              else
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: ElevatedButton(
                      onPressed: _submitForm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF005CE7),
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        textStyle: const TextStyle(fontSize: 20),
                      ),
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Lato',
                        ),
                      ),
                    ),
                  ),
                ),

              const SizedBox(height: 20.0),

              const Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Divider(
                        color: Colors.grey,
                        thickness: 1.0,
                      ),
                    ),
                  ),
                  Text(
                    'or register with',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      fontFamily: 'Lato',
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Divider(
                        color: Colors.grey,
                        thickness: 1.0,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20.0),

              // Google Sign-up button
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: Image.asset(
                      'assets/google.png',
                      height: 24,
                    ),
                    label: const Text(
                      'Google',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Lato',
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40.0),

              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const OnboardingScreen()));
                  },
                  child: RichText(
                    text: const TextSpan(
                      text: 'Have an account already? ',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontFamily: 'Lato',
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Login',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontFamily: 'Lato',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
