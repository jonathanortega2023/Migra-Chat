import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:migra_chat/src/ui/widgets.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:flutter/services.dart' show rootBundle;

class PDFEditPage extends StatefulWidget {
  const PDFEditPage({super.key});

  @override
  State<PDFEditPage> createState() => _PDFEditPageState();
}

class _PDFEditPageState extends State<PDFEditPage> {
  late PdfDocument document;

  @override
  void initState() {
    super.initState();
    loadDocument();
  }

  @override
  void dispose() {
    document.dispose();
    super.dispose();
  }

  Future<void> loadDocument() async {
    const String assetPath = 'assets/forms/ar-11.pdf';
    final ByteData data = await rootBundle.load(assetPath);
    final List<int> inputBytes = data.buffer.asUint8List();
    setState(() {
      document = PdfDocument(inputBytes: inputBytes);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('PDF Edit'),
        ),
        drawer: AppDrawer(),
        body: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                viewFormFields(document.form);
              },
              child: const Text('View Form Fields'),
            ),
            Expanded(
              child: ListView.builder(itemBuilder: (context, index) {
                if (index >= document.form.fields.count) {
                  return null;
                }
                return ListTile(
                  title: Text(document.form.fields[index].name ?? ''),
                );
              }),
            ),
          ],
        ));
  }
}

void viewFormFields(PdfForm form) {
  for (int i = 0; i < form.fields.count; i++) {
    final PdfField field = form.fields[i];
    if (field is PdfTextBoxField) {
      final PdfTextBoxField textBoxField = field;
      print('Text box field: ${textBoxField.name}');
    } else if (field is PdfRadioButtonListField) {
      final PdfRadioButtonListField radioButtonListField = field;
      print('Radio button field: ${radioButtonListField.name}');
    } else if (field is PdfCheckBoxField) {
      final PdfCheckBoxField checkBoxField = field;
      print('Check box field: ${checkBoxField.name}');
    } else if (field is PdfListBoxField) {
      final PdfListBoxField listBoxField = field;
      print('List box field: ${listBoxField.name}');
    } else if (field is PdfComboBoxField) {
      final PdfComboBoxField comboBoxField = field;
      print('Combo box field: ${comboBoxField.name}');
    } else if (field is PdfSignatureField) {
      final PdfSignatureField signatureField = field;
      print('Signature field: ${signatureField.name}');
    } else {
      print('Unknown field type');
    }
  }
}
