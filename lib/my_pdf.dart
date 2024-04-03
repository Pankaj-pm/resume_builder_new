import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:resume_builder_new/pdf_data.dart';

class MyPdf extends StatefulWidget {
  const MyPdf({super.key});

  @override
  State<MyPdf> createState() => _MyPdfState();
}

class _MyPdfState extends State<MyPdf> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: PdfData().getPdfPreview(),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      // ),
    );
  }
}
