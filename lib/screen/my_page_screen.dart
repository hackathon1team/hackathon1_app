import 'package:flutter/material.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:memory_app/screen/components/my_glassmorphism.dart';

class MyPageScreen extends StatelessWidget {
  const MyPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background/background8.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '소중한 매일을 만들어 가는,\n나의 페이지',
              style: TextStyle(
                color: Color(0xFF5A639C),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: AspectRatio(
                aspectRatio: 1,
                child: GlassContainer(
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                  border: Border.all(
                      color: Colors.white.withOpacity(0.2), width: 1),
                  blur: 50,
                  color: Colors.white.withOpacity(0.05),
                  shadowColor: Colors.black.withOpacity(0.25),
                  shadowStrength: 10,
                  gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [
                      Color(0xFFFFE7E7).withOpacity(0.46),
                      Color(0xFFFFFFFF).withOpacity(0.47),
                      Color(0xFF000000),
                      Color(0xFFFFFFFF).withOpacity(0.3),
                      Color(0xFF7381FF).withOpacity(0.45),
                      Color(0xFF000749).withOpacity(0.31),
                    ],
                    stops: [
                      0.0,
                      0.07,
                      0.24,
                      0.58,
                      0.81,
                      1.0,
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset('assets/character/character5.png'),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '배혜윤',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF5A639C),
                                ),
                              ),
                              Text(
                                '메코와 매일을\n함께하는,\n하루하루',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF5A639C).withOpacity(0.7),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              MyGlassmorphism(
                                onTap: () {},
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    '로그아웃',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF5A639C).withOpacity(0.7),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Text(
                                '너 자신을 알라.\n-소크라테스',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF5A639C).withOpacity(0.75),
                                  // wordSpacing: -3,
                                  letterSpacing: -3,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              MyGlassmorphism(
                                onTap: () {},
                                child: Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Text(
                                    '회원탈퇴',
                                    style: TextStyle(
                                      color: Color(0xFF5A639C).withOpacity(0.7),
                                      fontSize: 9,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Image.asset('assets/components/cloud_star.png'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
