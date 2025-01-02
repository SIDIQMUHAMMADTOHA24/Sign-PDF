import 'dart:io';
import 'package:camera/camera.dart';
import 'package:enkripa_sign/presentation/pages/widget/hole_overlay_painter.dart';
import 'package:enkripa_sign/presentation/pages/widget/navigation_widget.dart';
import 'package:enkripa_sign/theme/theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class FaceVerificationPage extends StatefulWidget {
  const FaceVerificationPage({super.key});

  @override
  State<FaceVerificationPage> createState() => _FaceVerificationPageState();
}

class _FaceVerificationPageState extends State<FaceVerificationPage> {
  late CameraController _controller;
  Future<void>? _initializeControllerFuture;
  final FaceDetector faceDetector = FaceDetector(
    options: FaceDetectorOptions(
      enableClassification: true,
      enableContours: true,
      enableTracking: true,
      performanceMode: FaceDetectorMode.accurate,
      enableLandmarks: true,
    ),
  );
  String _verificationResult = "Menunggu deteksi...";
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        setState(() {
          _verificationResult = "Tidak ada kamera yang tersedia.";
        });
        return;
      }

      final frontCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
        orElse: () => cameras.first,
      );

      _controller = CameraController(
        frontCamera,
        ResolutionPreset.high,
        enableAudio: false,
        imageFormatGroup: Platform.isAndroid
            ? ImageFormatGroup.nv21
            : ImageFormatGroup.bgra8888,
      );

      _initializeControllerFuture = _controller.initialize();
      await _initializeControllerFuture;

    // // Tetapkan level zoom langsung
    // const double initialZoomLevel = 1.0; // Atur zoom level awal di sini
    // double maxZoomLevel = await _controller.getMaxZoomLevel();

    // if (initialZoomLevel <= maxZoomLevel) {
    //   await _controller.setZoomLevel(initialZoomLevel);
    //   debugPrint("Zoom level set to $initialZoomLevel");
    // } else {
    //   debugPrint("Zoom level $initialZoomLevel exceeds maximum zoom level $maxZoomLevel");
    // }

      _controller.startImageStream((CameraImage image) {
        if (!_isProcessing) {
          _isProcessing = true;
          _detectFaces(image).then((_) {
            _isProcessing = false;
          });
        }
      });

    } catch (e) {
      setState(() {
        _verificationResult = "Kesalahan saat menginisialisasi kamera: $e";
      });
    }
  }

  Future<void> _detectFaces(CameraImage image) async {
    try {
      final inputImage = _getInputImage(image);
      if (inputImage == null) {
        setState(() {
          _verificationResult = "Gambar tidak valid untuk deteksi.";
        });
        return;
      }

      final faces = await faceDetector.processImage(inputImage);

      setState(() {
        if (faces.isNotEmpty) {
          final face = faces.first;

          // Deteksi orientasi kepala
          final facingDirection = face.headEulerAngleY!;
          String orientation = '';
          if (facingDirection < -15) {
            orientation = 'Menghadap kiri';
          } else if (facingDirection > 15) {
            orientation = 'Menghadap kanan';
          } else {
            orientation = 'Menghadap lurus';
          }

          // Deteksi berkedip
          final leftEyeOpenProb = face.leftEyeOpenProbability ?? 1.0;
          final rightEyeOpenProb = face.rightEyeOpenProbability ?? 1.0;

          final isBlinking = leftEyeOpenProb < 0.5 || rightEyeOpenProb < 0.5
              ? 'Berkedip'
              : 'Tidak berkedip';

          // Hasil deteksi
          _verificationResult =
              "Wajah terdeteksi:\nOrientasi: $orientation\nStatus Mata: $isBlinking";
        } else {
          _verificationResult = "Tidak ada wajah terdeteksi.";
        }
      });
    } catch (e) {
      setState(() {
        _verificationResult = "Kesalahan saat mendeteksi wajah: $e";
      });
    }
  }

  InputImage? _getInputImage(CameraImage image) {
    try {
      final format = Platform.isAndroid
          ? InputImageFormat.nv21
          : InputImageFormat.bgra8888;

      final metadata = InputImageMetadata(
        size: Size(image.width.toDouble(), image.height.toDouble()),
        rotation: InputImageRotation.rotation0deg,
        format: format,
        bytesPerRow: image.planes[0].bytesPerRow,
      );

      return InputImage.fromBytes(
        bytes: image.planes[0].bytes,
        metadata: metadata,
      );
    } catch (e) {
      debugPrint("Kesalahan saat membuat InputImage: $e");
      return null;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    faceDetector.close();
    super.dispose();
  }

  @override
  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(title: const Text('Verifikasi Wajah')),
    //   body: FutureBuilder<void>(
    //     future: _initializeControllerFuture,
    //     builder: (context, snapshot) {
    //       if (snapshot.connectionState == ConnectionState.done &&
    //           _controller.value.isInitialized) {
    //         return Column(
    //           children: [
    //             Expanded(
    //               child: Stack(
    //                 children: [
    //                   // Camera preview
    //                   // CameraPreview(_controller),
    //                   Container(color: Colors.white,),
    //                   CustomPaint(
    //                     painter: HoleOverlayWidget(
    //                       center: Offset(
    //                         MediaQuery.of(context).size.width / 2,
    //                         MediaQuery.of(context).size.height / 3,
    //                       ),
    //                       height: 310,
    //                       width: 248,
    //                     ),
    //                      child: Container(),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //             Padding(
    //               padding: const EdgeInsets.all(16.0),
    //               child: Text(
    //                 _verificationResult,
    //                 style: const TextStyle(fontSize: 20),
    //                 textAlign: TextAlign.center,
    //               ),
    //             ),
    //           ],
    //         );
    //       } else if (snapshot.hasError) {
    //         return Center(child: Text("Kesalahan: ${snapshot.error}"));
    //       } else {
    //         return const Center(child: CircularProgressIndicator());
    //       }
    //     },
    //   ),
    // );


    return KeyboardDismisser(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Theme.of(context).topBackgroundColor,
                    Theme.of(context).bottomBackgroundColor,
                    Theme.of(context).bottomBackgroundColor,
                    Theme.of(context).bottomBackgroundColor,
                    Theme.of(context).bottomBackgroundColor,
                  ],
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: MediaQuery.paddingOf(context).top - 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                            onTap: () {
                              Nav.pop(context);
                            },
                            child: SvgPicture.asset(
                                'assets/icon/arrow-left-icon.svg')),
                        Image.asset(
                          'assets/image/enkripa-logo.webp',
                          color: Colors.white,
                          width: 96.9,
                          height: 32,
                        ),
                        SvgPicture.asset('assets/icon/headset-icon.svg'),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Verifikasi Wajah',
                          style: GoogleFonts.inter(
                            fontSize: 20,
                            color: Theme.of(context).titleMediumColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Text(
                              'Silahkan verifikasi wajah Anda terlebih dahulu.',
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                color: Theme.of(context).headlineSmallColor,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 36),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Stack(
                            children: [
                              SizedOverflowBox(
                                size: const Size(double.infinity, 300), // aspect is 1:1
                                alignment: Alignment.center,
                                child: FutureBuilder(
                                    future: _initializeControllerFuture,
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                              ConnectionState.done &&
                                          _controller.value.isInitialized) {
                                        // return ClipRRect(
                                        //   child: Stack(
                                        //     alignment: Alignment.center,
                                        //     children: [
                                        //       CameraPreview(_controller),
                                        //       CustomPaint(
                                        //         painter: HoleOverlayWidget(
                                        //           center: Offset(
                                        //             MediaQuery.of(context).size.width / 2.22,
                                        //             MediaQuery.of(context).size.height / 5,
                                        //           ),
                                        //           height: 210,
                                        //           width: 170,
                                        //         ),
                                        //         child: Container(),
                                        //       ),
                                        //     ],
                                        //   ),
                                        // );
                                        return CameraPreview(_controller);
                                      } else {
                                        return const Center(child: CircularProgressIndicator());
                                      }
                                    }),
                              ),
                                     CustomPaint(
                                            painter: HoleOverlayWidget(
                                              center: Offset(
                                                MediaQuery.of(context).size.width / 2.22,
                                                MediaQuery.of(context).size.height / 5,
                                              ),
                                              height: 210,
                                              width: 170,
                                            ),
                                          ),
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top: 24),
                          child: Text(
                            'Verifikasi wajah harus :',
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context).headlineSmallColor,
                            ),
                          ),
                        ),

                        //MENGHADAP LURUS
                        _descriptionWidget(context,
                            isValid: true, description: 'Menghadap lurus'),

                        //MENOLEH KANAN DAN KIRI
                        _descriptionWidget(context,
                            isValid: true,
                            description: 'Menoleh ke kanan dan kiri'),

                        //MATA BERKEDIP
                        _descriptionWidget(context,
                            isValid: true, description: 'Mata Berkedip'),

                        //BUKA MULUT
                        _descriptionWidget(context,
                            isValid: true, description: 'Buka mulut'),
                      ],
                    ),
                    // child: CameraPreview(_controller),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  //DESCRIPTION WIDGET
  Row _descriptionWidget(
    BuildContext context, {
    required String description,
    required bool isValid,
  }) {
    return Row(
      children: [
        SvgPicture.asset(
          isValid
              ? 'assets/icon/tick-circle-icon.svg'
              : 'assets/icon/close-circle-icon.svg',
        ),
        const SizedBox(width: 4),
        Text(
          description,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Theme.of(context).headlineSmallColor,
          ),
        ),
      ],
    );
  }
}
