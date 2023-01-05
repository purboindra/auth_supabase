import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();

  // FUNCTION LOGIN
  // BODYNYA DITARUH DI PARAMATER/LANGSUNG DIDEKLARASIIN JUGA BISA
  // DITARUH DIPARAMATER SEPERTI CARA 1
  // DIDEKLARASIIN SEPERTI CARA 2

  // CARA PERTAMA
  Future _login1(String email, String password) async {
    // GUNAKAN URI.PARSE (ENDPOINTNYA) DI DALAM HTTPNYA
    // KARENA HTTP TIDAK MENERIMA STRING, DIA MENERIMA TYPE URI
    final response =
        await http.post(Uri.parse('https://reqres.in/api/login'), body: {
      'email': email,
      'password': password,
    });

// KALAU DAPAT RESPONSE, AGAR DIA BERUPA OBJECT, HARUS DIDECODE TERLEBIH DAHULU
// DENGAN CARA => jsonDecode(response.body);
// JIKA DIA SUDAH DIDECODE, MAKA BARU BISA DIAMBIL ROLENYA

    // LAKUKAN PENGECEKAN PADA ROLE JIKA MAU ATUR NAVIGASI KEMANA
    // if(role == 'user'){
    //   routing ke homepageForUser;
    // } else {
    //   // BERARTI DIA BUKAN USER
    //   routing ke homepageBukanUser;
    // }

    // JIKA DIA SUKSES MAKA AKAN NGEPRINT TOKEN
    print('RESPONSE ${response.body}');
  }

  // CARA KEDUA
  Future _login2() async {
    // GUNAKAN URI.PARSE (ENDPOINTNYA) DI DALAM HTTPNYA
    // KARENA HTTP TIDAK MENERIMA STRING, DIA MENERIMA TYPE URI
    final response =
        await http.post(Uri.parse('https://reqres.in/api/login'), body: {
      'email': email.text,
      'password': pass.text,
    });

// KALAU DAPAT RESPONSE, AGAR DIA BERUPA OBJECT, HARUS DIDECODE TERLEBIH DAHULU
// DENGAN CARA => jsonDecode(response.body);
// JIKA DIA SUDAH DIDECODE, MAKA BARU BISA DIAMBIL ROLENYA

    // LAKUKAN PENGECEKAN PADA ROLE JIKA MAU ATUR NAVIGASI KEMANA
    // if(role == 'user'){
    //   routing ke homepageForUser;
    // } else {
    //   // BERARTI DIA BUKAN USER
    //   routing ke homepageBukanUser;
    // }

    // JIKA DIA SUKSES MAKA AKAN NGEPRINT TOKEN
    print('RESPONSE ${response.body}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/instagram_logo.png',
              color: Colors.white,
              height: 60,
              fit: BoxFit.fitWidth,
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: email,
              style: const TextStyle(
                color: Colors.white,
              ),
              decoration: InputDecoration(
                fillColor: const Color.fromARGB(66, 91, 91, 91),
                filled: true,
                contentPadding: const EdgeInsets.all(18),
                hintText: 'Email',
                hintStyle: const TextStyle(
                  color: Colors.white,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    8,
                  ),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: pass,
              style: const TextStyle(
                color: Colors.white,
              ),
              decoration: InputDecoration(
                fillColor: const Color.fromARGB(66, 91, 91, 91),
                filled: true,
                hintText: 'Password',
                contentPadding: const EdgeInsets.all(18),
                hintStyle: const TextStyle(
                  color: Colors.white,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    8,
                  ),
                  borderSide: const BorderSide(
                    color: Color.fromARGB(255, 222, 222, 222),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            InkWell(
              child: Container(
                alignment: Alignment.topRight,
                child: Text(
                  'Lupa kata sandi?',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.blue.shade800,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(
                  Size(MediaQuery.of(context).size.width, 50),
                ),
                padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(vertical: 10),
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              onPressed: () {
                _login1(email.text, pass.text);
                // _login2();
              },
              child: const Text(
                'Login',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: const [
                Expanded(
                  child: Divider(
                    color: Color.fromARGB(255, 173, 173, 173),
                  ),
                ),
                SizedBox(
                  width: 35,
                ),
                Text(
                  'ATAU',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color.fromARGB(255, 173, 173, 173),
                  ),
                ),
                SizedBox(
                  width: 35,
                ),
                Expanded(
                    child: Divider(
                  color: Color.fromARGB(255, 173, 173, 173),
                )),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.facebook_sharp,
                  color: Color.fromARGB(255, 14, 115, 232),
                  size: 32,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Masuk dengan Facebook',
                  style: TextStyle(
                    color: Color.fromARGB(255, 14, 115, 232),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.symmetric(vertical: 10),
        height: 40,
        decoration: const BoxDecoration(
          color: Colors.black,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0, 0),
              blurRadius: 2,
            ),
          ],
        ),
        child: RichText(
          text: TextSpan(
            style: const TextStyle(
              color: Colors.grey,
            ),
            children: [
              const TextSpan(text: 'Belum punya akun? '),
              TextSpan(
                text: 'Daftar.',
                recognizer: TapGestureRecognizer()..onTap = () {},
                style: const TextStyle(
                  color: Color.fromARGB(255, 14, 115, 232),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
