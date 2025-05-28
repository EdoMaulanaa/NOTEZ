import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home_screen.dart';
import 'dart:math' as math;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _nisnController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;

  late AnimationController _breatheController;
  late AnimationController _moveController;
  late AnimationController _rotateController;

  late Animation<double> _breatheAnimation;
  late Animation<double> _moveAnimation;
  late Animation<double> _rotateAnimation;

  @override
  void initState() {
    super.initState();

    _breatheController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 6000),
    )..repeat(reverse: true);

    _moveController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 8000),
    )..repeat(reverse: true);

    _rotateController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 20000),
    )..repeat();

    _breatheAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _breatheController,
        curve: Curves.easeInOut,
      ),
    );

    _moveAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _moveController,
        curve: Curves.easeInOutCubic,
      ),
    );

    _rotateAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _rotateController,
        curve: Curves.linear,
      ),
    );
  }

  @override
  void dispose() {
    _namaController.dispose();
    _nisnController.dispose();
    _passwordController.dispose();
    _breatheController.dispose();
    _moveController.dispose();
    _rotateController.dispose();
    super.dispose();
  }

  void _handleJoinUs() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      await Future.delayed(const Duration(seconds: 1));

      if (_namaController.text == "Hakim Musa Eljabbar S.H." &&
          _nisnController.text == "0088974058" &&
          _passwordController.text == "musaganteng") {
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Nama, NISN, atau password salah'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }

      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = GoogleFonts.poppinsTextTheme();
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          AnimatedBuilder(
            animation: Listenable.merge(
                [_breatheAnimation, _moveAnimation, _rotateAnimation]),
            builder: (context, child) {
              final breatheValue = math.sin(_breatheAnimation.value * math.pi);
              final moveValue = math.sin(_moveAnimation.value * math.pi * 2);
              final rotateValue = _rotateAnimation.value * 2 * math.pi;

              return Stack(
                children: [
                  Positioned(
                    top: -130 + (breatheValue * 3) + (moveValue * 2),
                    left: -130 + (moveValue * 3),
                    child: Transform.rotate(
                      angle: rotateValue * 0.01,
                      child: Container(
                        width: 260 + (breatheValue * 5),
                        height: 260 + (breatheValue * 5),
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              left: 80,
                              top: 40,
                              child: Image.asset(
                                'assets/icons/logo_user.png',
                                width: 66,
                                height: 66,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 220 - (breatheValue * 4) - (moveValue * 3),
                    right: -60 + (moveValue * 5),
                    child: Transform.rotate(
                      angle: -rotateValue * 0.02,
                      child: Container(
                        width: 180 + (breatheValue * 8),
                        height: 180 + (breatheValue * 8),
                        decoration: BoxDecoration(
                          color: Colors.grey
                              .withOpacity(0.2 + (breatheValue * 0.03)),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -100 + (breatheValue * 4) + (moveValue * 4),
                    right: -100 - (moveValue * 3),
                    child: Transform.rotate(
                      angle: rotateValue * 0.015,
                      child: Container(
                        width: 220 + (breatheValue * 7),
                        height: 220 + (breatheValue * 7),
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                  if (screenSize.width > 400)
                    Positioned(
                      top: screenSize.height * 0.4 + (moveValue * 20),
                      right: screenSize.width * 0.2 - (breatheValue * 15),
                      child: Transform.rotate(
                        angle: rotateValue * 0.1,
                        child: Container(
                          width: 20 + (breatheValue * 5),
                          height: 20 + (breatheValue * 5),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                  if (screenSize.width > 400)
                    Positioned(
                      top: screenSize.height * 0.65 - (moveValue * 15),
                      left: screenSize.width * 0.25 + (breatheValue * 20),
                      child: Transform.rotate(
                        angle: -rotateValue * 0.1,
                        child: Container(
                          width: 15 + (breatheValue * 4),
                          height: 15 + (breatheValue * 4),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.15),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/icons/logo_book.png',
                        width: 50,
                        height: 50,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'NOTEZ',
                        style: GoogleFonts.poppins(
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        _buildInputField(
                          controller: _namaController,
                          hintText: 'Nama Lengkap',
                          obscureText: false,
                        ),
                        const SizedBox(height: 16),
                        _buildInputField(
                          controller: _nisnController,
                          hintText: 'NISN',
                          obscureText: false,
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 16),
                        _buildInputField(
                          controller: _passwordController,
                          hintText: 'Password',
                          obscureText: _obscurePassword,
                          suffixIcon: IconButton(
                            icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                                color: Colors.grey),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                        ),
                        const SizedBox(height: 32),
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              elevation: 0,
                            ),
                            onPressed: _isLoading ? null : _handleJoinUs,
                            child: _isLoading
                                ? const SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : Text(
                                    'Login',
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Demo Credentials:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Nama: user\nNISN: 0087654321\nPassword: user123',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hintText,
    bool obscureText = false,
    Widget? suffixIcon,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: GoogleFonts.poppins(fontSize: 16, color: Colors.black),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.poppins(color: Colors.grey, fontSize: 16),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.black, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.black, width: 2),
        ),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: Colors.transparent,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '$hintText tidak boleh kosong';
        }
        return null;
      },
    );
  }
}
