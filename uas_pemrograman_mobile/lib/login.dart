import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'api_manager.dart';
import 'user_manager.dart';

class LoginPage extends StatefulWidget {
  final ApiManager apiManager;

  LoginPage({required this.apiManager});

  
  
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  // Controller untuk field username dan password
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _authenticate(BuildContext context) async {
    final apiManager = Provider.of<ApiManager>(context, listen: false);
    final userManager = Provider.of<UserManager>(context, listen: false);
    final email = _usernameController.text;
    final password = _passwordController.text;

    try {
      final token = await apiManager.authenticate(email, password);
      userManager.setAuthToken(token);
      Navigator.pushReplacementNamed(context, '/dashboard');
    } catch (e) {
      print('Authentication failed. Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Login gagal. Silahkan Login Kembali'),
        duration: Duration(seconds: 2),
      ),
    );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login', style: TextStyle(color: Colors.white),),
        backgroundColor: const Color.fromARGB(255, 66, 163, 243),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10.0),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: false, // Ganti dengan logika Anda
                        onChanged: (value) {
                          // Ganti dengan logika Anda
                        },
                      ),
                      Text('Remember me'),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      // Ganti dengan aksi Anda saat klik Forgot Password
                    },
                    child: Text('Forgot Password?'),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () async {
                        _authenticate(context);
                      },
                child: Text('Login'),
              ),
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?"),
                  TextButton(
                    onPressed: () {
                        Navigator.pushNamed(context, '/register');
                    },
                    child: Text('Register now'),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              Text('--------------------    or    --------------------'),
              SizedBox(height: 10.0),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      // Ganti dengan aksi Anda saat login dengan Facebook
                    },
                    icon: Image.asset('assets/facebook.png', width: 24.0, height: 24.0),
                    label: Text('Login with Facebook'),
                  ),
                  SizedBox(height: 10.0),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Ganti dengan aksi Anda saat login dengan Google
                    },
                    icon: Image.asset('assets/google.png', width: 24.0, height: 24.0),
                    label: Text('Login with Google'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
