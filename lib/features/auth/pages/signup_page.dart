import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:pizza_delivery/features/pizza/presentation/pages/pizza_home_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

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
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleSignUp() {
    if (_formKey.currentState!.validate()) {
      // حالياً انتقال تجريبي للمنيو لحد ما يوسف يجهز API إنشاء الحساب
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const PizzaHomePage()),
        (route) => false,
      );
    }
  }

  InputDecoration _inputDecoration({
    required String hint,
    required IconData icon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon, color: const Color(0xFFE64A19)),
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: const Color(0xFFF6F4F2),
      contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Color(0xFFFF5722), width: 1.5),
      ),
    );
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
              // الجزء العلوي الملون مع زر الرجوع وقرص البيتزا الدوار
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 225,
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
                      child: Stack(
                        children: [
                          const Positioned(
                            top: 8,
                            right: 8,
                            child: BackButton(color: Colors.white),
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 18),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Text(
                                    'PIZZA HOUSE',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 21,
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: 2,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'انضم لعائلتنا واطلب بيتزتك بلحظات',
                                    style: TextStyle(
                                      color: Color(0xEEFFFFFF),
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // قرص البيتزا الدائري
                  Positioned(
                    bottom: -55,
                    child: Container(
                      width: 122,
                      height: 122,
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x33000000),
                            blurRadius: 18,
                            offset: Offset(0, 8),
                          ),
                        ],
                      ),
                      child: RotationTransition(
                        turns: _rotationController,
                        child: CustomPaint(
                          painter: _SignUpPizzaPainter(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 70),

              // كرت نموذج إنشاء الحساب
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: const EdgeInsets.all(22),
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
                          'إنشاء حساب جديد',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1F1F1F),
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'عبّي بياناتك لسهولة توصيل طلباتك',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF8A8A8A),
                            fontSize: 13.5,
                          ),
                        ),
                        const SizedBox(height: 22),

                        // الاسم الكامل
                        TextFormField(
                          controller: _nameController,
                          textInputAction: TextInputAction.next,
                          decoration: _inputDecoration(
                            hint: 'الاسم الكامل',
                            icon: Icons.person_outline_rounded,
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'يرجى إدخال الاسم الكامل';
                            }
                            if (value.trim().length < 3) {
                              return 'الاسم قصير جداً';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 14),

                        // رقم الهاتف
                        TextFormField(
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.next,
                          decoration: _inputDecoration(
                            hint: 'رقم الهاتف (مثال: 0790000000)',
                            icon: Icons.phone_android_rounded,
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'يرجى إدخال رقم الهاتف للتوصيل';
                            }
                            if (value.trim().length < 10) {
                              return 'يرجى إدخال رقم هاتف صحيح من 10 خانات';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 14),

                        // البريد الإلكتروني
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          decoration: _inputDecoration(
                            hint: 'البريد الإلكتروني',
                            icon: Icons.email_outlined,
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
                        const SizedBox(height: 14),

                        // عنوان التوصيل
                        TextFormField(
                          controller: _addressController,
                          textInputAction: TextInputAction.next,
                          decoration: _inputDecoration(
                            hint: 'عنوان التوصيل (المنطقة / الشارع)',
                            icon: Icons.location_on_outlined,
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'يرجى إدخال عنوان التوصيل';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 14),

                        // كلمة المرور
                        TextFormField(
                          controller: _passwordController,
                          obscureText: _obscurePassword,
                          textInputAction: TextInputAction.next,
                          decoration: _inputDecoration(
                            hint: 'كلمة المرور',
                            icon: Icons.lock_outline_rounded,
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
                        const SizedBox(height: 14),

                        // تأكيد كلمة المرور
                        TextFormField(
                          controller: _confirmPasswordController,
                          obscureText: _obscureConfirmPassword,
                          decoration: _inputDecoration(
                            hint: 'تأكيد كلمة المرور',
                            icon: Icons.lock_reset_rounded,
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureConfirmPassword
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscureConfirmPassword =
                                      !_obscureConfirmPassword;
                                });
                              },
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'يرجى تأكيد كلمة المرور';
                            }
                            if (value != _passwordController.text) {
                              return 'كلمتا المرور غير متطابقتين';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 24),

                        // زر إنشاء الحساب
                        SizedBox(
                          height: 54,
                          child: ElevatedButton(
                            onPressed: _handleSignUp,
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
                              'إنشاء الحساب',
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

              const SizedBox(height: 18),

              // رابط العودة لتسجيل الدخول
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'عندك حساب أصلاً؟',
                    style: TextStyle(color: Color(0xFF666666)),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'سجّل دخولك',
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

class _SignUpPizzaPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final crustPaint = Paint()
      ..shader = const RadialGradient(
        colors: [Color(0xFFE69D45), Color(0xFFC86D1F)],
        stops: [0.75, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: radius));
    canvas.drawCircle(center, radius, crustPaint);

    canvas.drawCircle(
      center,
      radius * 0.83,
      Paint()..color = const Color(0xFFC62828),
    );

    final cheesePaint = Paint()
      ..shader = const RadialGradient(
        colors: [Color(0xFFFFE082), Color(0xFFFFCA28)],
      ).createShader(Rect.fromCircle(center: center, radius: radius * 0.78));
    canvas.drawCircle(center, radius * 0.78, cheesePaint);

    final pepperoniBase = Paint()..color = const Color(0xFFB71C1C);
    final pepperoniHighlight = Paint()..color = const Color(0xFFD32F2F);
    for (final angle in [0.0, 1.1, 2.2, 3.3, 4.4, 5.4]) {
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
      ..strokeWidth = 2.8;
    for (final angle in [0.55, 1.7, 2.8, 3.9, 5.0]) {
      final pos = Offset(
        center.dx + math.cos(angle) * (radius * 0.30),
        center.dy + math.sin(angle) * (radius * 0.30),
      );
      canvas.drawCircle(pos, radius * 0.06, olivePaint);
    }

    final basilPaint = Paint()..color = const Color(0xFF2E7D32);
    for (final angle in [0.3, 2.0, 3.6, 5.2]) {
      final pos = Offset(
        center.dx + math.cos(angle) * (radius * 0.62),
        center.dy + math.sin(angle) * (radius * 0.62),
      );
      canvas.save();
      canvas.translate(pos.dx, pos.dy);
      canvas.rotate(angle);
      canvas.drawOval(
        Rect.fromCenter(center: Offset.zero, width: 10, height: 5),
        basilPaint,
      );
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}