import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'api_manager.dart';

class RegisterPage extends StatefulWidget {
  final ApiManager apiManager;

  RegisterPage({required this.apiManager});
  
  
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  // Controller untuk field username, email, dan password
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _register(BuildContext context) async {
  final apiManager = Provider.of<ApiManager>(context, listen: false);

  final name = _usernameController.text;
  final email = _emailController.text;  // Perbaiki baris ini
  final password = _passwordController.text;

  try {
    await apiManager.register(name, email, password);
    // Show a toast on successful registration

    Navigator.pushReplacementNamed(context, '/');
    // Handle successful registration
  } catch (e) {
    print('Registration failed. Error: $e');
    // Handle registration failure
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register', style: TextStyle(color: Colors.white),),
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
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
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
                children: [
                  Checkbox(
                    value: false, // Ganti dengan logika Anda
                    onChanged: (value) {
                      // Ganti dengan logika Anda
                    },
                  ),
                  Text('I accept all terms & conditions'),
                ],
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    // Aksi saat formulir valid
                    // Ganti dengan aksi Anda saat klik Register
                    // Setelah berhasil mendaftar, navigasi ke halaman dashboard
                    _register(context);
                    Navigator.pushReplacementNamed(context, '/login');
                  }
                },
                child: Text('Register'),
              ),
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account?"),
                  TextButton(
                    onPressed: () {
                     Navigator.pushNamed(context, '/login');
                    },
                    child: Text('Login now'),
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
