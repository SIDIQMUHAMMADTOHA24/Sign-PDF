import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:share_plus/share_plus.dart';

class EditPdfPage extends StatefulWidget {
  @override
  _EditPdfPageState createState() => _EditPdfPageState();
}

class _EditPdfPageState extends State<EditPdfPage> {
  Offset _signaturePosition = Offset.zero;
  Size _signatureSize = const Size(100, 100);
  bool _isAddingSignature = true;
  final String _ttdPath = 'assets/ttd/ttd.png';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeSignaturePosition();
    });
  }

  void _initializeSignaturePosition() {
    final screenSize = MediaQuery.of(context).size;
    setState(() {
      _signaturePosition = Offset(
        (screenSize.width - _signatureSize.width) / 2,
        (screenSize.height -
                _signatureSize.height -
                MediaQuery.of(context).padding.top) /
            2,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PDF with Signature"),
        actions: [
          TextButton(onPressed: _savePdfWithSignature, child: Text('Done'))
        ],
      ),
      body: Stack(
        children: [
          SfPdfViewer.asset(
            'assets/pdf/testing.pdf',
            onPageChanged: (details) {
              print('detail, ${details.newPageNumber}');
            },
          ),
          if (_isAddingSignature) _buildSignatureWidget(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            setState(() => _isAddingSignature = !_isAddingSignature),
        child: Icon(_isAddingSignature ? Icons.check : Icons.edit),
      ),
    );
  }

  Widget _buildSignatureWidget() {
    return Positioned(
      left: _signaturePosition.dx,
      top: _signaturePosition.dy,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onPanUpdate: (details) =>
              setState(() => _signaturePosition += details.delta),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                child: Container(
                  width: _signatureSize.width,
                  height: _signatureSize.height,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue, width: 2),
                  ),
                  child: Image.asset(_ttdPath, fit: BoxFit.contain),
                ),
              ),
              ..._buildResizeHandles(),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildResizeHandles() {
    return [
      _buildHandle(Alignment.topLeft,
          (delta) => _resize(delta, isTop: true, isLeft: true)),
      _buildHandle(Alignment.topRight,
          (delta) => _resize(delta, isTop: true, isLeft: false)),
      _buildHandle(Alignment.bottomLeft,
          (delta) => _resize(delta, isTop: false, isLeft: true)),
      _buildHandle(Alignment.bottomRight,
          (delta) => _resize(delta, isTop: false, isLeft: false)),
    ];
  }

  Widget _buildHandle(Alignment alignment, Function(Offset) onDrag) {
    final offset = _getHandleOffset(alignment);
    return Positioned(
      left: offset.dx,
      top: offset.dy,
      child: GestureDetector(
        onPanUpdate: (details) => setState(() => onDrag(details.delta)),
        child: Container(
          width: 20,
          height: 20,
          decoration: const BoxDecoration(
            color: Colors.blue,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }

  Offset _getHandleOffset(Alignment alignment) {
    final dx =
        (alignment == Alignment.topLeft || alignment == Alignment.bottomLeft
                ? 0
                : _signatureSize.width)
            .toDouble();
    final dy =
        (alignment == Alignment.topLeft || alignment == Alignment.topRight
                ? 0
                : _signatureSize.height)
            .toDouble();
    return Offset(dx, dy);
  }

  void _resize(Offset delta, {required bool isTop, required bool isLeft}) {
    setState(() {
      final newWidth = _signatureSize.width + (isLeft ? -delta.dx : delta.dx);
      final newHeight = _signatureSize.height + (isTop ? -delta.dy : delta.dy);

      _signatureSize = Size(
        newWidth.clamp(50.0, 400.0),
        newHeight.clamp(50.0, 400.0),
      );

      if (isTop) {
        _signaturePosition =
            Offset(_signaturePosition.dx, _signaturePosition.dy + delta.dy);
      }
      if (isLeft) {
        _signaturePosition =
            Offset(_signaturePosition.dx + delta.dx, _signaturePosition.dy);
      }
    });
  }

  Future<void> _sharePdf(String filePath) async {
    try {
      await Share.shareXFiles([XFile(filePath)],
          text: 'Here is the signed PDF!');
    } catch (e) {
      print('Error sharing file: $e');
    }
  }

  Future<void> _savePdfWithSignature() async {
    try {
      // Load the existing PDF document
      final ByteData pdfData =
          await DefaultAssetBundle.of(context).load('assets/pdf/testing.pdf');
      final PdfDocument document =
          PdfDocument(inputBytes: pdfData.buffer.asUint8List());

      // Add signature to the first page
      final PdfPage page = document.pages[3];
      final PdfGraphics graphics = page.graphics;

      // Load the signature image
      final ByteData imageData =
          await DefaultAssetBundle.of(context).load(_ttdPath);
      final PdfBitmap signatureImage =
          PdfBitmap(imageData.buffer.asUint8List());

      // Calculate position and size
      final double x = _signaturePosition.dx;
      final double y =
          page.size.height - _signaturePosition.dy - _signatureSize.height;
      graphics.drawImage(signatureImage,
          Rect.fromLTWH(x, y, _signatureSize.width, _signatureSize.height));

      // Save the modified PDF to local storage
      final Directory directory = await getApplicationDocumentsDirectory();
      final String path = '${directory.path}/signed_document.pdf';
      final File file = File(path);
      file.writeAsBytesSync(document.saveSync());

      document.dispose();

      print('path = $path');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('PDF berhasil disimpan di $path')),
      );

      // _sharePdf(path);
    } catch (e) {
      print('error $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menyimpan PDF: $e')),
      );
    }
  }
}
