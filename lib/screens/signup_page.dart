import 'package:flutter/material.dart';
import 'home_page.dart'; // Import your HomePage

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      body: Center(
        child: isSmallScreen
            ? Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            _Logo(),
            _SignUpFormContent(),
          ],
        )
            : Container(
          padding: const EdgeInsets.all(32.0),
          constraints: const BoxConstraints(maxWidth: 800),
          child: Row(
            children: const [
              Expanded(child: _Logo()),
              Expanded(
                child: Center(child: _SignUpFormContent()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.network(
          'https://cdn-icons-png.flaticon.com/512/3532/3532091.png',
          width: isSmallScreen ? 100 : 200,
          height: isSmallScreen ? 100 : 200,
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "Добро пожаловать в Книгоград!",
            textAlign: TextAlign.center,
            style: isSmallScreen
                ? Theme.of(context).textTheme.headlineSmall
                : Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(color: Colors.black),
          ),
        ),
      ],
    );
  }
}

class _SignUpFormContent extends StatefulWidget {
  const _SignUpFormContent({super.key});

  @override
  State<_SignUpFormContent> createState() => __SignUpFormContentState();
}

class __SignUpFormContentState extends State<_SignUpFormContent> {
  bool _isPasswordVisible = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _signUp() {
    if (_formKey.currentState?.validate() ?? false) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 300),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _emailController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Пожалуйста, введите свою почту';
                }
                bool emailValid = RegExp(
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(value);
                if (!emailValid) {
                  return 'Пожалуйста, введите правильную почту';
                }
                return null;
              },
              decoration: const InputDecoration(
                labelText: 'Почта',
                hintText: 'Введите свою почту',
                prefixIcon: Icon(Icons.email_outlined),
                border: OutlineInputBorder(),
              ),
            ),
            _gap(),
            TextFormField(
              controller: _passwordController,
              obscureText: !_isPasswordVisible,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Пожалуйста, введите свой пароль';
                }
                if (value.length < 6) {
                  return 'Пароль должен состоять хотя бы из 6 символов';
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: 'Пароль',
                hintText: 'Введите свой пароль',
                prefixIcon: const Icon(Icons.lock_outline_rounded),
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ),
            ),
            _gap(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'Зарегистрироваться',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                onPressed: _signUp,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _gap() => const SizedBox(height: 16);
}
