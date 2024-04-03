import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';
import 'package:resume_builder_new/util.dart';

class PdfData {
  PdfPreview getPdfPreview() {
    return PdfPreview(
      build: (format) {
        // return generateInvoice(format);
        return getPdf();
      },
    );
  }

  Future<Uint8List> getPdf() async {
    var document = Document();

    document.addPage(Page(build: (context) {
      return Column(children: [
        Text(
          "Name ${resume.name}",
          style: TextStyle(fontSize: 18, color: PdfColor.fromHex("#ff8d00"), fontWeight: FontWeight.bold),
        ),
        Text(
          "Email ${resume.email}",
          style: TextStyle(fontSize: 18, color: PdfColor.fromHex("#ff8d00"), fontWeight: FontWeight.bold),
        ),
        Text(
          "Phone ${resume.phone}",
          style: TextStyle(fontSize: 18, color: PdfColor.fromHex("#ff8d00"), fontWeight: FontWeight.bold),
        )
        ,Text(
          "${resume.address1},${resume.address2},${resume.address3}",
          style: TextStyle(fontSize: 18, color: PdfColor.fromHex("#ff8d00"), fontWeight: FontWeight.bold),
        )
      ]);
    }));

    // document.addPage(Page(
    //   build: (context) {
    //     return Text("New Page");
    //   },
    // ));

    return document.save();
  }
}

Future<Uint8List> generateInvoice(PdfPageFormat pageFormat) async {
  final lorem = LoremText();

  final products = <Product>[
    Product('19874', lorem.sentence(4), 3.99, 2),
    Product('98452', lorem.sentence(6), 15, 2),
    Product('28375', lorem.sentence(4), 6.95, 3),
    Product('95673', lorem.sentence(3), 49.99, 4),
    Product('23763', lorem.sentence(2), 560.03, 1),
    Product('55209', lorem.sentence(5), 26, 1),
    Product('09853', lorem.sentence(5), 26, 1),
    Product('23463', lorem.sentence(5), 34, 1),
    Product('56783', lorem.sentence(5), 7, 4),
    Product('78256', lorem.sentence(5), 23, 1),
    Product('23745', lorem.sentence(5), 94, 1),
    Product('07834', lorem.sentence(5), 12, 1),
    Product('23547', lorem.sentence(5), 34, 1),
    Product('98387', lorem.sentence(5), 7.99, 2),
  ];

  final invoice = Invoice(
    invoiceNumber: '982347',
    products: products,
    customerName: 'Abraham Swearegin',
    customerAddress: '54 rue de Rivoli\n75001 Paris, France',
    paymentInfo: '4509 Wiseman Street\nKnoxville, Tennessee(TN), 37929\n865-372-0425',
    tax: .15,
    baseColor: PdfColors.teal,
    accentColor: PdfColors.blueGrey900,
  );

  return await invoice.buildPdf(pageFormat);
}

class Invoice {
  Invoice({
    required this.products,
    required this.customerName,
    required this.customerAddress,
    required this.invoiceNumber,
    required this.tax,
    required this.paymentInfo,
    required this.baseColor,
    required this.accentColor,
  });

  final List<Product> products;
  final String customerName;
  final String customerAddress;
  final String invoiceNumber;
  final double tax;
  final String paymentInfo;
  final PdfColor baseColor;
  final PdfColor accentColor;

  static const _darkColor = PdfColors.blueGrey800;
  static const _lightColor = PdfColors.white;

  PdfColor get _baseTextColor => baseColor.isLight ? _lightColor : _darkColor;

  PdfColor get _accentTextColor => baseColor.isLight ? _lightColor : _darkColor;

  double get _total => products.map<double>((p) => p.total).reduce((a, b) => a + b);

  double get _grandTotal => _total * (1 + tax);

  Future<Uint8List> buildPdf(PdfPageFormat pageFormat) async {
    // Create a PDF document.
    final doc = Document();

    // Add page to the PDF
    doc.addPage(
      MultiPage(
        pageTheme: _buildTheme(
          pageFormat,
          await PdfGoogleFonts.robotoRegular(),
          await PdfGoogleFonts.robotoBold(),
          await PdfGoogleFonts.robotoItalic(),
        ),
        header: _buildHeader,
        footer: _buildFooter,
        build: (context) => [
          _contentHeader(context),
          _contentTable(context),
          SizedBox(height: 20),
          _contentFooter(context),
          SizedBox(height: 20),
          _termsAndConditions(context),
        ],
      ),
    );

    // Return the PDF file content
    return doc.save();
  }

  Widget _buildHeader(Context context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                children: [
                  Container(
                    height: 50,
                    padding: const EdgeInsets.only(left: 20),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'INVOICE',
                      style: TextStyle(
                        color: baseColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(2)),
                      color: accentColor,
                    ),
                    padding: const EdgeInsets.only(left: 40, top: 10, bottom: 10, right: 20),
                    alignment: Alignment.centerLeft,
                    height: 50,
                    child: DefaultTextStyle(
                      style: TextStyle(
                        color: _accentTextColor,
                        fontSize: 12,
                      ),
                      child: GridView(
                        crossAxisCount: 2,
                        children: [
                          Text('Invoice #'),
                          Text(invoiceNumber),
                          Text('Date:'),
                          Text(_formatDate(DateTime.now())),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    alignment: Alignment.topRight,
                    padding: const EdgeInsets.only(bottom: 8, left: 30),
                    height: 72,
                  ),
                  // Container(
                  //   color: baseColor,
                  //   padding: EdgeInsets.only(top: 3),
                  // ),
                ],
              ),
            ),
          ],
        ),
        if (context.pageNumber > 1) SizedBox(height: 20)
      ],
    );
  }

  Widget _buildFooter(Context context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          height: 20,
          width: 100,
          child: BarcodeWidget(
            barcode: Barcode.pdf417(),
            data: 'Invoice# $invoiceNumber',
            drawText: false,
          ),
        ),
        Text(
          'Page ${context.pageNumber}/${context.pagesCount}',
          style: const TextStyle(
            fontSize: 12,
            color: PdfColors.white,
          ),
        ),
      ],
    );
  }

  PageTheme _buildTheme(PdfPageFormat pageFormat, Font base, Font bold, Font italic) {
    return PageTheme(
      pageFormat: pageFormat,
      theme: ThemeData.withFont(
        base: base,
        bold: bold,
        italic: italic,
      ),
    );
  }

  Widget _contentHeader(Context context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            height: 70,
            child: FittedBox(
              child: Text(
                'Total: ${_formatCurrency(_grandTotal)}',
                style: TextStyle(
                  color: baseColor,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 10, right: 10),
                height: 70,
                child: Text(
                  'Invoice to:',
                  style: TextStyle(
                    color: _darkColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 70,
                  child: RichText(
                      text: TextSpan(
                          text: '$customerName\n',
                          style: TextStyle(
                            color: _darkColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                          children: [
                        const TextSpan(
                          text: '\n',
                          style: TextStyle(
                            fontSize: 5,
                          ),
                        ),
                        TextSpan(
                          text: customerAddress,
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 10,
                          ),
                        ),
                      ])),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _contentFooter(Context context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Thank you for your business',
                style: TextStyle(
                  color: _darkColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, bottom: 8),
                child: Text(
                  'Payment Info:',
                  style: TextStyle(
                    color: baseColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                paymentInfo,
                style: const TextStyle(
                  fontSize: 8,
                  lineSpacing: 5,
                  color: _darkColor,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: DefaultTextStyle(
            style: const TextStyle(
              fontSize: 10,
              color: _darkColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Sub Total:'),
                    Text(_formatCurrency(_total)),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Tax:'),
                    Text('${(tax * 100).toStringAsFixed(1)}%'),
                  ],
                ),
                Divider(color: accentColor),
                DefaultTextStyle(
                  style: TextStyle(
                    color: baseColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total:'),
                      Text(_formatCurrency(_grandTotal)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _termsAndConditions(Context context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: accentColor)),
                ),
                padding: const EdgeInsets.only(top: 10, bottom: 4),
                child: Text(
                  'Terms & Conditions',
                  style: TextStyle(
                    fontSize: 12,
                    color: baseColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                LoremText().paragraph(40),
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  fontSize: 6,
                  lineSpacing: 2,
                  color: _darkColor,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: SizedBox(),
        ),
      ],
    );
  }

  Widget _contentTable(Context context) {
    const tableHeaders = ['SKU#', 'Item Description', 'Price', 'Quantity', 'Total'];

    return TableHelper.fromTextArray(
      border: null,
      cellAlignment: Alignment.centerLeft,
      headerDecoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(2)),
        color: baseColor,
      ),
      headerHeight: 25,
      cellHeight: 40,
      cellAlignments: {
        0: Alignment.centerLeft,
        1: Alignment.centerLeft,
        2: Alignment.centerRight,
        3: Alignment.center,
        4: Alignment.centerRight,
      },
      headerStyle: TextStyle(
        color: _baseTextColor,
        fontSize: 10,
        fontWeight: FontWeight.bold,
      ),
      cellStyle: const TextStyle(
        color: _darkColor,
        fontSize: 10,
      ),
      rowDecoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: accentColor,
            width: .5,
          ),
        ),
      ),
      headers: List<String>.generate(
        tableHeaders.length,
        (col) => tableHeaders[col],
      ),
      data: List<List<String>>.generate(
        products.length,
        (row) => List<String>.generate(
          tableHeaders.length,
          (col) => products[row].getIndex(col),
        ),
      ),
    );
  }
}

String _formatCurrency(double amount) {
  return '\$${amount.toStringAsFixed(2)}';
}

String _formatDate(DateTime date) {
  return date.toString();
}

class Product {
  const Product(
    this.sku,
    this.productName,
    this.price,
    this.quantity,
  );

  final String sku;
  final String productName;
  final double price;
  final int quantity;

  double get total => price * quantity;

  String getIndex(int index) {
    switch (index) {
      case 0:
        return sku;
      case 1:
        return productName;
      case 2:
        return _formatCurrency(price);
      case 3:
        return quantity.toString();
      case 4:
        return _formatCurrency(total);
    }
    return '';
  }
}
