import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test & Result',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        textTheme: GoogleFonts.urbanistTextTheme(
          Theme.of(context).textTheme.apply(bodyColor: Colors.black, displayColor: Colors.black),
        ),
      ),
      home: TestScreen(),
    );
  }
}

class TestScreen extends StatefulWidget {
  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  final _formKey = GlobalKey<FormState>();
  final List<TextEditingController> _controllers = List.generate(16, (_) => TextEditingController());

  // Puan hesaplama işlevi
  double _calculateScore() {
    double total = 0.0;
    for (var controller in _controllers) {
      double value = double.tryParse(controller.text) ?? 0;
      total += value;
    }
    // Toplam puanı yüzdeye çeviriyoruz
    // En yüksek puan: 16 soru x 10 puan = 160 puan
    return (total / 160) * 100;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Text(
                'Uyumsuz Gündüz Düşü Ölçeği (MDS-16), Eli Somer, Jayne Bigelsen, Jonathan Lehrfeld ve Daniela Jopp tarafından bireylerin uyumsuz hayal kurma düzeylerini belirlemek amacıyla geliştirilmiştir.',
                style: GoogleFonts.urbanist(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 20),
              Text(
                'Aşağıdaki soruları cevaplarken, eğer başka türlü bir şey belirtilmemişse, son bir ay içerisinde kurduğunuz hayalleri dikkate alın. Deneyiminize en çok uyan puanı işaretleyin.',
                style: GoogleFonts.urbanist(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 20),
              for (int i = 0; i < 16; i++)
                Padding(
                  padding: EdgeInsets.only(bottom: 16.0),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    color: Color.fromRGBO(255, 249, 242, 1),
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${i + 1}. ${_getQuestion(i)}',
                            style: GoogleFonts.urbanist(
                              fontSize: 13, // Font size updated to 13
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                          SizedBox(height: 10),
                          GridView.builder(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 10,
                              crossAxisSpacing: 4,
                              mainAxisSpacing: 4,
                            ),
                            itemCount: 10,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              int value = index + 1;
                              bool isSelected = double.tryParse(_controllers[i].text) == value.toDouble();
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _controllers[i].text = value.toString();
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: isSelected ? Color.fromARGB(255, 246, 211, 158) : Colors.white,
                                    borderRadius: BorderRadius.circular(8.0),
                                    border: Border.all(color: Colors.grey[300]!),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '$value',
                                      style: GoogleFonts.urbanist(
                                        fontSize: 12,
                                        color: isSelected ? Colors.white : Colors.black,
                                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    double score = _calculateScore();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResultScreen(score: score),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 241, 195, 127),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                ),
                child: Text('Sonuç', style: GoogleFonts.urbanist(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getQuestion(int index) {
    List<String> questions = [
      'Bazı insanlar belli türden müziklerin hayal kurmayı tetiklediğini fark ederler. Müzik sizin hayal kurmanızı ne ölçüde tetikler?',
      'Bazı insanlar gerçek bir yaşam olayı tarafından kesintiye uğrayan hayallerine kaldığı yerden devam etmek isterler. Kurduğunuz hayallerden biri gerçek bir yaşam olayı tarafından kesintiye uğradığında, mümkün olan en kısa zamanda bu kurduğunuz hayale geri dönme ihtiyacınız veya isteğiniz ne kadar güçlüdür?',
      'Hayal kurmanıza sesiniz veya yüz ifadeniz ne sıklıkla eşlik etmektedir? (örneğin; gülme, konuşma veya mırıldanma)',
      'Gerçek yaşam yükümlülüklerinizi yerine getirmeniz sebebiyle hayal kuracak vakit bulamazsanız, hayal kurmak için zaman bulamamanız size ne kadar sıkıntı verir?',
      'Hayal kurmak bazı insanların günlük iş ve görevlerini yerine getirmelerine engeller. Hayal kurmak günlük temel işlerinizi başarıyla tamamlamanızı ne kadar engellemektedir?',
      'Bazı insanlar hayal kurmaya harcadıkları zaman konusunda kendilerini sıkıntılı veya endişeli hissederler. Bugünlerde hayal kurmaya harcadığınız zaman konusunda kendinizi ne kadar sıkıntılı hissediyorsunuz?',
      'Dikkat etmeniz veya bitirmeniz gereken zorlu ya da önemli bir iş olduğunda, işinizi hayal kurmadan tamamlamanız sizin için ne kadar zordur?',
      'Hayal kurmak bazı insanların hayatlarındaki önemli şeylere engel olmaktadır. Hayal kurmanız hayattaki hedeflerinize ulaşmanızı ne kadar engellemektedir?',
      'Bazı insanlar hayal kurmayı başka birçok şeyi yapmaya yeğlerler. Başka insanlarla etkileşimde bulunmak, sosyal faaliyetlere katılmak veya hobilerinizle uğraşmak yerine hayal kurmayı tercih etme dereceniz nedir?',
      'Sabah ilk uyandığınızda, hemen hayal kurma arzunuz ne kadar güçlüdür?',
      'Halihazırdaki hayal kurmanıza, tempo tutmak, sallanmak ve ellerinizi sallamanız gibi fiziksel aktiviteler ne sıklıkla eşlik etmektedir?',
      'Bazı insanlar hayal kurmayı severler. Hayal kurduğunuzda, hayal kurmayı ne kadar rahatlatıcı veya eğlenceli bulursunuz?',
      'Bazı insanlar müzik dinlemiyorken hayal kurmakta zorlanırlar. Sizin hayal kurmanız için müzik dinlemeniz ne kadar gereklidir?',
      'Bazı insanlar hayal kurmayı aşırı şekilde gerçekleştirirler. Hayal kurma sürenizi sınırlandırma gereksinimi duyuyor musunuz?',
      'Hayal kurmak bazı insanların uyku düzenini etkiler. Hayal kurma alışkanlığınızın uyku düzeninizi etkilediğini düşünüyor musunuz?',
      'Bazı insanlar hayal kurmayı başka birçok şeyi yapmaya yeğlerler. Hayal kurma, yapılması gereken görevleri yerine getirmek için ne kadar zamanınızı alır?',
    ];
    return questions[index];
  }
}


class ResultScreen extends StatelessWidget {
  final double score;

  ResultScreen({required this.score});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 20),
              Text(
                '${score.toStringAsFixed(1)}%',
                style: GoogleFonts.urbanist(
                  fontSize: 40, 
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              Text(
                score > 50 ? 'Muhtemel maladaptif hayal kurma.' : 'Normal aralık, maladaptif hayal kurma olasılığı düşük.',
                style: GoogleFonts.urbanist(
                  fontSize: 15, 
                  color: score > 50 ? const Color.fromARGB(255, 0, 0, 0) : const Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}