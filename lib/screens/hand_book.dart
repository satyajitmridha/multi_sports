import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class Handbook extends StatefulWidget {
  @override
  _HandbookState createState() => _HandbookState();
}

class _HandbookState extends State<Handbook> {
  String? pdfPath;
  bool _isLoading = true;
  String errorMessage = '';

  Future<File> getFileFromUrl(String url, {String name = 'copd'}) async {
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var bytes = response.bodyBytes;
        var dir = await getApplicationDocumentsDirectory();
        File file = File("${dir.path}/$name.pdf");
        await file.writeAsBytes(bytes, flush: true);
        return file;
      } else {
        throw Exception("Failed to load PDF (Status Code: ${response.statusCode})");
      }
    } catch (e) {
      throw Exception("Error fetching PDF: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    loadPdf();
  }

  Future<void> loadPdf() async {
    setState(() {
      _isLoading = true;
      errorMessage = '';
    });

    try {
      final file = await getFileFromUrl(
        'https://sports.forcempower.com/darts/copd/copd.php', // Replace with your PDF URL
      );
      setState(() {
        pdfPath = file.path;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to load PDF: ${e.toString()}';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Handbook', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: const Color.fromARGB(255, 247, 74, 35),
      ),
      body: Stack(
        children: [
          if (_isLoading)
            const Center(child: CircularProgressIndicator()),
          if (errorMessage.isNotEmpty)
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(errorMessage, style: TextStyle(color: Colors.red)),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: loadPdf,
                    child: Text("Retry"),
                  ),
                ],
              ),
            ),
          if (pdfPath != null)
            PDFView(
              filePath: pdfPath,
              enableSwipe: true,
              swipeHorizontal: false,
              autoSpacing: true,
              pageFling: true,
              pageSnap: true,
              fitPolicy: FitPolicy.BOTH,
              preventLinkNavigation: false,
              onError: (error) {
                setState(() {
                  errorMessage = error.toString();
                });
              },
              onPageError: (page, error) {
                setState(() {
                  errorMessage = 'Error on page $page: ${error.toString()}';
                });
              },
            ),
        ],
      ),
    );
  }
}
