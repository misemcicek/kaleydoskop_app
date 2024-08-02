import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoAndMotivationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context); // Geri butonuna tıklanınca ekranı kapat
        },
        child: Stack(
          children: [
            Container(
              color: Colors.grey.shade50, 
              padding: const EdgeInsets.all(16.0), 
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 40), 

                   
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.1), 
                        borderRadius: BorderRadius.circular(8.0), 
                      ),
                      child: Text(
                        'Uyumsuz Gündüz Düşü (Maladaptive Daydreaming)',
                        style: GoogleFonts.urbanist(
                          fontSize: 16, 
                          fontWeight: FontWeight.bold,
                          color: Colors.black, 
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 20), 

                   
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
                      decoration: BoxDecoration(
                        color: Colors.white, 
                        borderRadius: BorderRadius.circular(8.0), 
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            offset: Offset(0, 2),
                            blurRadius: 4,
                          ),
                        ], 
                      ),
                      child: Text(
                        'Uyumsuz gündüz düşü, gerçek dünyadan kaçma arzusuyla uzun ve yoğun hayaller kurma durumudur. Bu davranış, günlük yaşamınızı, işlerinizi ve sosyal ilişkilerinizi olumsuz etkileyebilir, hatta zamanla kişisel ilişkilerinizde zorluklara yol açabilir.\n\n'
                        'Kaleydoskop, bu karmaşık ve hassas durumu anlamanıza ve yönetmenize yardımcı olmak için geliştirilmiştir. Uygulamamız, Uyumsuz Gündüz Düşü Ölçeği (MDS-16) ile kendinizi değerlendirme imkanı sunar. Ayrıca, düş günlüğü özelliği sayesinde, hayallerinizi ve düşüncelerinizi düzenli olarak kaydedebilir, rahatsızlığınızı daha iyi anlayabilir ve kontrol altına alabilirsiniz.\n\n'
                        'Bu süreçte yalnız olmadığınızı unutmayın. Kaleydoskop, hayal dünyanızda daha sağlıklı bir denge kurmanıza destek olur. Kendinizi keşfetmek ve daha huzurlu bir yaşam için ilk adımı atmak üzere Kaleydoskop’u keşfedin!',
                        style: GoogleFonts.urbanist(
                          fontSize: 13,
                          color: Colors.black, 
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 40), 

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}