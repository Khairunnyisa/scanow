import 'package:flutter/material.dart';
import 'package:qr_scanner/ui/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late final Animation<double> animation;

  void navigator() async {
    await Future.delayed(const Duration(seconds: 3), () {});

    if (!mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const Home(),
      ),
      (route) => false,
    );
  }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this, // Menggunakan SingleTickerProviderStateMixin
      duration: const Duration(milliseconds: 300),
    );
    animation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(animationController);

    animationController.forward();
    navigator();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand, // Mengatur gambar agar mengisi seluruh layar
        children: [
          // Background Gambar Full Screen
          Image.asset(
            "assets/images/splash-screen.png", // Pastikan path gambar benar
            fit: BoxFit.cover, // Membuat gambar menyesuaikan layar
          ),
          // Teks di atas gambar
          Center(
            child: ScaleTransition(
              scale: animation,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text(
                    "Scanow", // Teks utama
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // Sesuaikan warna teks
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
