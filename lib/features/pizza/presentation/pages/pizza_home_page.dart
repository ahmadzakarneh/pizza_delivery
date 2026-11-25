import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:pizza_delivery/features/pizza/data/models/pizza_model.dart';

class PizzaHomePage extends StatefulWidget {
  const PizzaHomePage({super.key});

  @override
  State<PizzaHomePage> createState() => _PizzaHomePageState();
}

class _PizzaHomePageState extends State<PizzaHomePage> {
  final List<String> _categories = const ['الكل', 'لحوم', 'دجاج', 'نباتي'];
  String _selectedCategory = 'الكل';
  String _searchQuery = '';
  int _cartCount = 0;

  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<PizzaModel> get _filteredPizzas {
    return dummyPizzas.where((pizza) {
      final matchesCategory =
          _selectedCategory == 'الكل' || pizza.category == _selectedCategory;
      final matchesSearch = pizza.name.contains(_searchQuery.trim()) ||
          pizza.description.contains(_searchQuery.trim());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  void _addToCart(PizzaModel pizza) {
    setState(() {
      _cartCount++;
    });

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'تمت إضافة "${pizza.name}" إلى السلة',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF2E7D32),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pizzas = _filteredPizzas;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF7F4F1),
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              // 1. الشريط العلوي (اسم المطعم + أيقونة السلة مع العداد)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'أهلاً بك في PIZZA HOUSE 👋',
                            style: TextStyle(
                              fontSize: 13,
                              color: Color(0xFF7A7A7A),
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'شو حابب تطلب اليوم؟',
                            style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1F1F1F),
                            ),
                          ),
                        ],
                      ),

                      // زر السلة مع العداد
                      InkWell(
                        onTap: () {
                          // سنربط شاشة السلة (CartPage) هنا في الخطوة القادمة
                        },
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x12000000),
                                blurRadius: 12,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              const Icon(
                                Icons.shopping_bag_outlined,
                                color: Color(0xFFE64A19),
                                size: 26,
                              ),
                              if (_cartCount > 0)
                                Positioned(
                                  top: -6,
                                  left: -6,
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: const BoxDecoration(
                                      color: Color(0xFFD32F2F),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Text(
                                      '$_cartCount',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
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

              // 2. شريط البحث
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: TextField(
                    controller: _searchController,
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'ابحث عن بيتزا بيبروني، دجاج، خضار...',
                      hintStyle: const TextStyle(
                        color: Color(0xFF9E9E9E),
                        fontSize: 14,
                      ),
                      prefixIcon: const Icon(
                        Icons.search_rounded,
                        color: Color(0xFFE64A19),
                      ),
                      suffixIcon: _searchQuery.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.close, color: Colors.grey),
                              onPressed: () {
                                _searchController.clear();
                                setState(() {
                                  _searchQuery = '';
                                });
                              },
                            )
                          : null,
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(vertical: 14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ),

              // 3. بانر العروض الترويجي
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 16),
                  child: Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Color(0xFFBF360C),
                          Color(0xFFFF5722),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x33E64A19),
                          blurRadius: 16,
                          offset: Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Text(
                                  'عرض خاص 🔥',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'خصم 20% على أول طلب',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                'توصيل ساخن وسريع لجميع المناطق',
                                style: TextStyle(
                                  color: Color(0xEEFFFFFF),
                                  fontSize: 12.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        SizedBox(
                          width: 76,
                          height: 76,
                          child: CustomPaint(
                            painter: _MenuPizzaPainter(category: 'لحوم'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // 4. أزرار التصنيفات (الكل، لحوم، دجاج، نباتي)
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 44,
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    scrollDirection: Axis.horizontal,
                    itemCount: _categories.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 10),
                    itemBuilder: (context, index) {
                      final category = _categories[index];
                      final isSelected = _selectedCategory == category;
                      return ChoiceChip(
                        label: Text(category),
                        selected: isSelected,
                        onSelected: (_) {
                          setState(() {
                            _selectedCategory = category;
                          });
                        },
                        selectedColor: const Color(0xFFE64A19),
                        backgroundColor: Colors.white,
                        labelStyle: TextStyle(
                          color: isSelected
                              ? Colors.white
                              : const Color(0xFF424242),
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                          side: BorderSide.none,
                        ),
                        showCheckmark: false,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                      );
                    },
                  ),
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 16)),

              // 5. شبكة بطاقات البيتزا
              if (pizzas.isEmpty)
                const SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Text(
                      'لا توجد أصناف مطابقة لبحثك',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              else
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                  sliver: SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 238,
                      crossAxisSpacing: 14,
                      mainAxisSpacing: 14,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final pizza = pizzas[index];
                        return _PizzaCard(
                          pizza: pizza,
                          onAddPressed: () => _addToCart(pizza),
                          onCardTap: () {
                            // سنربط شاشة تفاصيل البيتزا (PizzaDetailsPage) هنا
                          },
                        );
                      },
                      childCount: pizzas.length,
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

class _PizzaCard extends StatelessWidget {
  final PizzaModel pizza;
  final VoidCallback onAddPressed;
  final VoidCallback onCardTap;

  const _PizzaCard({
    required this.pizza,
    required this.onAddPressed,
    required this.onCardTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onCardTap,
      borderRadius: BorderRadius.circular(22),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0F000000),
              blurRadius: 14,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // قرص البيتزا الدائري حسب التصنيف
            Center(
              child: Container(
                width: 92,
                height: 92,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x22000000),
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: CustomPaint(
                  painter: _MenuPizzaPainter(category: pizza.category),
                ),
              ),
            ),
            const SizedBox(height: 10),

            // اسم البيتزا
            Text(
              pizza.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F1F1F),
              ),
            ),
            const SizedBox(height: 4),

            // التقييم ووقت التحضير
            Row(
              children: [
                const Icon(
                  Icons.star_rounded,
                  color: Color(0xFFFFB300),
                  size: 16,
                ),
                const SizedBox(width: 2),
                Text(
                  '${pizza.rating}',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF424242),
                  ),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    '• ${pizza.prepTime}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 11.5,
                      color: Color(0xFF8A8A8A),
                    ),
                  ),
                ),
              ],
            ),

            const Spacer(),

            // السعر وزر الإضافة السريعة
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${pizza.price.toStringAsFixed(2)} د.أ',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFFE64A19),
                  ),
                ),
                InkWell(
                  onTap: onAddPressed,
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE64A19),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.add_rounded,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// رسم قرص بيتزا مخصص حسب التصنيف (لحوم، دجاج، نباتي)
class _MenuPizzaPainter extends CustomPainter {
  final String category;

  _MenuPizzaPainter({required this.category});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // العجينة الخارجية
    final crustPaint = Paint()
      ..shader = const RadialGradient(
        colors: [Color(0xFFE69D45), Color(0xFFC86D1F)],
        stops: [0.75, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: radius));
    canvas.drawCircle(center, radius, crustPaint);

    // الصلصة
    canvas.drawCircle(
      center,
      radius * 0.83,
      Paint()
        ..color = category == 'دجاج'
            ? const Color(0xFFD84315)
            : const Color(0xFFC62828),
    );

    // الجبنة
    final cheesePaint = Paint()
      ..shader = const RadialGradient(
        colors: [Color(0xFFFFE082), Color(0xFFFFCA28)],
      ).createShader(Rect.fromCircle(center: center, radius: radius * 0.78));
    canvas.drawCircle(center, radius * 0.78, cheesePaint);

    if (category == 'لحوم') {
      final pepBase = Paint()..color = const Color(0xFFB71C1C);
      final pepInner = Paint()..color = const Color(0xFFD32F2F);
      for (final angle in [0.0, 1.1, 2.2, 3.3, 4.4, 5.4]) {
        final pos = Offset(
          center.dx + math.cos(angle) * (radius * 0.48),
          center.dy + math.sin(angle) * (radius * 0.48),
        );
        canvas.drawCircle(pos, radius * 0.14, pepBase);
        canvas.drawCircle(pos, radius * 0.10, pepInner);
      }
      canvas.drawCircle(center, radius * 0.13, pepBase);
    } else if (category == 'دجاج') {
      final chickenPaint = Paint()..color = const Color(0xFF8D4E24);
      final bbqDot = Paint()..color = const Color(0xFF4E342E);
      for (final angle in [0.2, 1.3, 2.4, 3.5, 4.6, 5.7]) {
        final pos = Offset(
          center.dx + math.cos(angle) * (radius * 0.46),
          center.dy + math.sin(angle) * (radius * 0.46),
        );
        canvas.save();
        canvas.translate(pos.dx, pos.dy);
        canvas.rotate(angle);
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromCenter(center: Offset.zero, width: 12, height: 8),
            const Radius.circular(3),
          ),
          chickenPaint,
        );
        canvas.restore();
      }
      for (final angle in [0.7, 2.1, 3.8, 5.1]) {
        final pos = Offset(
          center.dx + math.cos(angle) * (radius * 0.25),
          center.dy + math.sin(angle) * (radius * 0.25),
        );
        canvas.drawCircle(pos, radius * 0.06, bbqDot);
      }
    } else {
      // نباتي: فليفلة خضراء + زيتون + ريحان
      final pepperPaint = Paint()
        ..color = const Color(0xFF2E7D32)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.6;
      for (final angle in [0.0, 1.5, 3.0, 4.5]) {
        final pos = Offset(
          center.dx + math.cos(angle) * (radius * 0.45),
          center.dy + math.sin(angle) * (radius * 0.45),
        );
        canvas.drawCircle(pos, radius * 0.11, pepperPaint);
      }
      final olivePaint = Paint()
        ..color = const Color(0xFF263238)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5;
      for (final angle in [0.8, 2.3, 3.8, 5.3]) {
        final pos = Offset(
          center.dx + math.cos(angle) * (radius * 0.30),
          center.dy + math.sin(angle) * (radius * 0.30),
        );
        canvas.drawCircle(pos, radius * 0.06, olivePaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}