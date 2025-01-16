import 'package:flutter/material.dart';

// Kelas Home sebagai StatefulWidget
class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: CircleAvatar(
                    radius: 24,
                    backgroundImage: AssetImage('assets/images/profile.png'),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Welcome back,",
                      style: TextStyle(
                        color: Color(0xFF9B9B9B),
                        fontSize: 15,
                        fontFamily: 'Satoshi',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Hi Nisa!",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: IconButton(
                    onPressed: () {},
                    icon: Container(
                      padding: const EdgeInsets.all(
                          10), // Padding di dalam kontainer untuk memberi jarak antara ikon dan latar belakang
                      decoration: BoxDecoration(
                        color: Color(0xFFE5EDFF), // Warna latar belakang
                        shape: BoxShape
                            .circle, // Bentuk latar belakang menjadi lingkaran
                      ),
                      child: const Icon(
                        Icons.notifications_outlined,
                        color: Color(0xFF2B61E3), // Warna ikon
                        size: 28,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              padding: const EdgeInsets.only(top: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/header-scanow.png', // Pastikan nama file sesuai
                    width: 380,
                    height: 150, // Atur tinggi gambar sesuai kebutuhan
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: 380,
                    height: 500,
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: 40,
                          width: 200,
                          decoration: ShapeDecoration(
                            color: const Color(0xFFF8F8F8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            "Scan Here!",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/scanner');
                          },
                          child: Container(
                            width: 250,
                            height: 250,
                            margin: const EdgeInsets.only(top: 20),
                            decoration: ShapeDecoration(
                              color: const Color(0xFFE5EDFF),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(22),
                              ),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.qr_code_scanner_rounded,
                                size: 150,
                                color: Color(0xFF2B61E3),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Container(
                                  width: 70,
                                  height: 70,
                                  decoration: ShapeDecoration(
                                    color: const Color(0xFF2B61E3),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(49),
                                    ),
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      Icons.send,
                                      size: 30,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const Text("Send",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                    )),
                              ],
                            ),
                            const SizedBox(width: 30),
                            Column(
                              children: [
                                Container(
                                  width: 70,
                                  height: 70,
                                  decoration: ShapeDecoration(
                                    color: const Color(0xFF2B61E3),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(49),
                                    ),
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      Icons.add_rounded,
                                      size: 30,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const Text("Add",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                    )),
                              ],
                            ),
                            const SizedBox(width: 30),
                            Column(
                              children: [
                                Container(
                                  width: 70,
                                  height: 70,
                                  decoration: ShapeDecoration(
                                    color: const Color(0xFF2B61E3),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(49),
                                    ),
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      Icons.payment,
                                      size: 30,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const Text("Pay",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
