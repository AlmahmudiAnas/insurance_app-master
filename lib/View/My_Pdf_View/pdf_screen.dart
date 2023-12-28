// import 'package:flutter/material.dart';
// import 'package:flutter_pdfview/flutter_pdfview.dart';

// class PdfScreen extends StatelessWidget {
//   final downloadUrl;

//   PdfScreen({required this.downloadUrl});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('PDF Screen'),
//       ),
//       body: Center(
//         child: SizedBox(
//           height: 500,
//           width: 300,
//           child: PDFView(
//             filePath: downloadUrl.toString(),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insurance_app/Util/My_Widget/my_button.dart';
import 'package:insurance_app/View_Model/insurance_provider.dart';
import 'package:provider/provider.dart';

class PdfScreen extends StatelessWidget {
  final String pdfUrl, insuranceType;
  final docId;

  const PdfScreen({
    required this.pdfUrl,
    required this.insuranceType,
    required this.docId,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 167, 201, 87),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          '$insuranceType',
          style: GoogleFonts.acme(color: Colors.black),
        ),
        flexibleSpace: Container(
          height: size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color.fromARGB(255, 167, 201, 87),
                Color.fromARGB(255, 239, 239, 239),
              ],
              stops: [0.1, 0.9],
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color.fromARGB(255, 167, 201, 87),
                  Color.fromARGB(255, 239, 239, 239),
                ],
                stops: [0.1, 0.9],
              ),
            ),
          ),
          Center(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
              width: size.width / 1.15,
              height: size.height / 1.1,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: size.width,
                      height: size.height * 0.6,
                      child: PDF().cachedFromUrl(
                        pdfUrl,
                        placeholder: (progress) =>
                            Center(child: CircularProgressIndicator()),
                        errorWidget: (error) =>
                            Center(child: Text('Error while loading PDF')),
                      ),
                    ),
                    SizedBox(height: size.height * 0.02),
                    context.watch<InsuranceProvider>().isLoading
                        ? CircularProgressIndicator()
                        : MyButton(
                            size: size,
                            text: 'Delete',
                            onPressed: () {
                              context
                                  .read<InsuranceProvider>()
                                  .deleteDocumentFromFirebase(pdfUrl, docId);
                              Navigator.pop(context);
                            },
                          ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
