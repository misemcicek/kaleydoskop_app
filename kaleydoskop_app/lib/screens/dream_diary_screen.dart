import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:kaleydoskop/database_helper.dart';
import 'package:google_fonts/google_fonts.dart';

class DreamDiaryScreen extends StatefulWidget {
  @override
  _DreamDiaryScreenState createState() => _DreamDiaryScreenState();
}

class _DreamDiaryScreenState extends State<DreamDiaryScreen> {
  final _titleController = TextEditingController();
  final _detailsController = TextEditingController();
  int? _selectedDreamId;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('tr', null); // Türkçe tarih formatını başlat
  }

  void _addOrUpdateDream() async {
    final title = _titleController.text;
    final details = _detailsController.text;
    final dateTime = DateTime.now().toIso8601String();

    if (title.isEmpty || details.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Eksik Alanlar', style: GoogleFonts.urbanist(fontSize: 14)),
          content: Text('Başlık ve detayları doldurmalısınız.', style: GoogleFonts.urbanist(fontSize: 14)),
          actions: [
            TextButton(
              child: Text('TAMAM', style: GoogleFonts.urbanist(fontSize: 14)),
              onPressed: () => Navigator.of(context).pop(),
              style: TextButton.styleFrom(
                backgroundColor: Colors.grey[300],
                foregroundColor: Colors.black,
              ),
            ),
          ],
        ),
      );
      return;
    }

    if (_selectedDreamId == null) {
      await DatabaseHelper.instance.insertDream(title, details, dateTime); // Yeni düş ekle
    } else {
      await DatabaseHelper.instance.updateDream(_selectedDreamId!, title, details); // Mevcut düşü güncelle
      _selectedDreamId = null;
    }

    _titleController.clear();
    _detailsController.clear();
    Navigator.of(context).pop();
    setState(() {});
  }

  void _showDreamBottomSheet({int? id}) async {
    if (id != null) {
      final dream = await DatabaseHelper.instance.getDream(id);
      if (dream != null) {
        _titleController.text = dream['title'];
        _detailsController.text = dream['details'];
        _selectedDreamId = id;
      }
    } else {
      _titleController.clear();
      _detailsController.clear();
      _selectedDreamId = null;
    }

    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        backgroundColor: Colors.grey[100],
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.7,
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      labelText: 'Başlık',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    style: GoogleFonts.urbanist(fontSize: 14),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _detailsController,
                    decoration: InputDecoration(
                      labelText: 'Detaylar',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    maxLines: 5,
                    style: GoogleFonts.urbanist(fontSize: 14),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _addOrUpdateDream,
                    child: Text(_selectedDreamId == null ? 'KAYDET' : 'GÜNCELLE', style: GoogleFonts.urbanist(fontSize: 14)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 213, 159, 159),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      elevation: 8,
                      textStyle: GoogleFonts.urbanist(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('İPTAL', style: GoogleFonts.urbanist(fontSize: 14)),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.grey[300],
                      foregroundColor: Colors.black,
                      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      textStyle: GoogleFonts.urbanist(fontSize: 14, fontWeight: FontWeight.bold),
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

  Future<void> _deleteDream(int id) async {
    final confirmed = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: Text('Silmek istediğinizden emin misiniz?', style: GoogleFonts.urbanist(fontSize: 14)),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              TextButton(
                child: Text('Evet', style: GoogleFonts.urbanist(fontSize: 14, fontWeight: FontWeight.bold)),
                onPressed: () => Navigator.of(context).pop(true),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.black,
                ),
              ),
              TextButton(
                child: Text('Hayır', style: GoogleFonts.urbanist(fontSize: 14, fontWeight: FontWeight.bold)),
                onPressed: () => Navigator.of(context).pop(false),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await DatabaseHelper.instance.deleteDream(id); 
      setState(() {});
    }
  }

  String formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('dd MMMM yyyy, HH:mm', 'tr'); 
    return formatter.format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(), 
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16.0),
              child: ElevatedButton.icon(
                onPressed: () => _showDreamBottomSheet(),
                icon: Icon(Icons.add, color: Colors.white, size: 20),
                label: Text('Yeni Düş Ekle', style: GoogleFonts.urbanist(fontSize: 16, fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 213, 159, 159),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 12,
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: DatabaseHelper.instance.getDreams(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator()); 
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Bir hata oluştu: ${snapshot.error}', style: GoogleFonts.urbanist(fontSize: 14)));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('Henüz düş eklemediniz.', style: GoogleFonts.urbanist(fontSize: 14)));
                  } else {
                    return ListView(
                      children: snapshot.data!.map((dream) {
                        final id = dream['id'];
                        final dateTime = DateTime.parse(dream['date_time']);
                        final formattedDate = formatDate(dateTime);

                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.all(16.0),
                            title: Text(dream['title'], style: GoogleFonts.urbanist(fontSize: 16, fontWeight: FontWeight.bold)),
                            subtitle: Text(formattedDate, style: GoogleFonts.urbanist(fontSize: 14, color: Colors.grey[700])),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(Icons.edit, color: Color.fromARGB(255, 205, 205, 205)),
                                  onPressed: () => _showDreamBottomSheet(id: id),
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete, color: const Color.fromARGB(255, 255, 164, 157)),
                                  onPressed: () => _deleteDream(id),
                                ),
                              ],
                            ),
                            onTap: () => _showDreamBottomSheet(id: id),
                          ),
                        );
                      }).toList(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
