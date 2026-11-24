import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:pizza_delivery/features/auth/pages/signup_page.dart';
import 'package:pizza_delivery/features/pizza/presentation/pages/pizza_home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  late final AnimationController _rotationController;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    )..repeat();
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const PizzaHomePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF7F4F1),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 270,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Color(0xFFBF360C),
                          Color(0xFFFF5722),
                          Color(0xFFFF8A65),
                        ],
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(44),
                        bottomRight: Radius.circular(44),
                      ),
                    ),
                    child: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 18),
                        child: Column(
                          children: const [
                            Text(
                              'PIZZA HOUSE',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 2,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'أطيب بيتزا ساخنة لباب بيتك',
                              style: TextStyle(
                                color: Color(0xEEFFFFFF),
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -65,
                    child: Container(
                      width: 146,
                      height: 146,
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x33000000),
                            blurRadius: 20,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                      child: RotationTransition(
                        turns: _rotationController,
                        child: CustomPaint(
                          painter: _PizzaDiscPainter(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 82),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x12000000),
                        blurRadius: 24,
                        offset: Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          'تسجيل الدخول',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1F1F1F),
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'أدخل بياناتك للمتابعة إلى المنيو',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF8A8A8A),
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 26),
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: 'البريد الإلكتروني',
                            prefixIcon: const Icon(
                              Icons.email_outlined,
                              color: Color(0xFFE64A19),
                            ),
                            filled: true,
                            fillColor: const Color(0xFFF6F4F2),
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 16,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(
                                color: Color(0xFFFF5722),
                                width: 1.5,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'يرجى إدخال البريد الإلكتروني';
                            }
                            if (!value.contains('@')) {
                              return 'يرجى إدخال بريد إلكتروني صحيح';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: _obscurePassword,
                          decoration: InputDecoration(
                            hintText: 'كلمة المرور',
                            prefixIcon: const Icon(
                              Icons.lock_outline_rounded,
                              color: Color(0xFFE64A19),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                            filled: true,
                            fillColor: const Color(0xFFF6F4F2),
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 16,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(
                                color: Color(0xFFFF5722),
                                width: 1.5,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'يرجى إدخال كلمة المرور';
                            }
                            if (value.length < 6) {
                              return 'كلمة المرور يجب أن تكون 6 خانات على الأقل';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 26),
                        SizedBox(
                          height: 54,
                          child: ElevatedButton(
                            onPressed: _handleLogin,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFE64A19),
                              foregroundColor: Colors.white,
                              elevation: 6,
                              shadowColor: const Color(0x66E64A19),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: const Text(
                              'تسجيل الدخول',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'ما عندك حساب؟',
                    style: TextStyle(color: Color(0xFF666666)),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpPage(),
                        ),
                      );
                    },
                    child: const Text(
                      'أنشئ حساب جديد',
                      style: TextStyle(
                        color: Color(0xFFE64A19),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _PizzaDiscPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final crustPaint = Paint()
      ..shader = const RadialGradient(
        colors: [
          Color(0xFFE69D45),
          Color(0xFFC86D1F),
        ],
        stops: [0.75, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: radius));
    canvas.drawCircle(center, radius, crustPaint);

    final saucePaint = Paint()..color = const Color(0xFFC62828);
    canvas.drawCircle(center, radius * 0.83, saucePaint);

    final cheesePaint = Paint()
      ..shader = const RadialGradient(
        colors: [
          Color(0xFFFFE082),
          Color(0xFFFFCA28),
        ],
      ).createShader(Rect.fromCircle(center: center, radius: radius * 0.78));
    canvas.drawCircle(center, radius * 0.78, cheesePaint);

    final pepperoniBase = Paint()..color = const Color(0xFFB71C1C);
    final pepperoniHighlight = Paint()..color = const Color(0xFFD32F2F);

    final pepperoniAngles = [0.0, 1.1, 2.2, 3.3, 4.4, 5.4];
    for (final angle in pepperoniAngles) {
      final pos = Offset(
        center.dx + math.cos(angle) * (radius * 0.48),
        center.dy + math.sin(angle) * (radius * 0.48),
      );
      canvas.drawCircle(pos, radius * 0.14, pepperoniBase);
      canvas.drawCircle(pos, radius * 0.10, pepperoniHighlight);
    }

    canvas.drawCircle(center, radius * 0.13, pepperoniBase);
    canvas.drawCircle(center, radius * 0.09, pepperoniHighlight);

    final olivePaint = Paint()
      ..color = const Color(0xFF263238)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.2;

    final oliveAngles = [0.55, 1.7, 2.8, 3.9, 5.0];
    for (final angle in oliveAngles) {
      final pos = Offset(
        center.dx + math.cos(angle) * (radius * 0.30),
        center.dy + math.sin(angle) * (radius * 0.30),
      );
      canvas.drawCircle(pos, radius * 0.06, olivePaint);
    }

    final basilPaint = Paint()..color = const Color(0xFF2E7D32);
    final basilAngles = [0.3, 2.0, 3.6, 5.2];
    for (final angle in basilAngles) {
      final pos = Offset(
        center.dx + math.cos(angle) * (radius * 0.62),
        center.dy + math.sin(angle) * (radius * 0.62),
      );
      canvas.save();
      canvas.translate(pos.dx, pos.dy);
      canvas.rotate(angle);
      canvas.drawOval(
        Rect.fromCenter(center: Offset.zero, width: 11, height: 6),
        basilPaint,
      );
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}