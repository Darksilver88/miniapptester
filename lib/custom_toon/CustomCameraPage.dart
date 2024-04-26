import 'dart:convert';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mini_app_tester/flutter_flow/flutter_flow_theme.dart';

class CustomCameraPage extends StatefulWidget {
  const CustomCameraPage({super.key});

  @override
  State<CustomCameraPage> createState() => _CustomCameraPageState();
}

class _CustomCameraPageState extends State<CustomCameraPage> {
  late List<CameraDescription> _cameras;
  late CameraController controller;
  bool cameraReady = false;

  XFile? imageFile;

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _cameras = await availableCameras();
      print("_cameras_cameras");
      print(_cameras);
      controller = CameraController(_cameras[0], ResolutionPreset.max);
      controller.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {
          cameraReady = true;
        });
      }).catchError((Object e) {
        if (e is CameraException) {
          switch (e.code) {
            case 'CameraAccessDenied':
              // Handle access errors here.
              break;
            default:
              // Handle other errors here.
              break;
          }
        }
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<XFile?> takePicture() async {
    final CameraController? cameraController = controller;
    if (cameraController == null || !cameraController.value.isInitialized) {
      print('Error: select a camera first.');
      return null;
    }

    if (cameraController.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }

    try {
      final XFile file = await cameraController.takePicture();
      return file;
    } on CameraException catch (e) {
      print(e);
      return null;
    }
  }

  void onTakePictureButtonPressed() {
    takePicture().then((XFile? file) async {
      if (mounted) {
        setState(() {
          imageFile = file;
        });
        if (file != null) {
          print('Picture saved to ${file.path}');
          Uint8List bytes = await file.readAsBytes();
          List<int> byteList = bytes.toList();
          var photoBase64 = base64Encode(byteList);
          Navigator.pop(context, photoBase64);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!cameraReady) {
      return Container();
    }
    return MaterialApp(
      home: Stack(
        children: [
          CameraPreview(controller),
          Align(
            alignment: AlignmentDirectional(0, 1),
            child: Material(
              color: Colors.transparent,
              elevation: 3,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                ),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 8),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Opacity(
                        opacity: 1,
                        child: InkWell(
                          onTap: () async {
                            FlashMode currentFlashMode = controller.value.flashMode;
                            FlashMode nextFlashMode = currentFlashMode == FlashMode.off ? FlashMode.torch : FlashMode.off;
                            await controller.setFlashMode(nextFlashMode);
                          },
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context).secondary,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.flash_on_rounded,
                              color: FlutterFlowTheme.of(context).primaryBackground,
                              size: 36,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: onTakePictureButtonPressed,
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).secondary,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.camera_alt,
                            color: FlutterFlowTheme.of(context).primaryBackground,
                            size: 36,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          CameraDescription currentCameraDescription = controller.description;
                          int index = _cameras.indexWhere((camera) => camera.lensDirection != currentCameraDescription.lensDirection);
                          if (index != -1) {
                            CameraDescription newCameraDescription = _cameras[index];
                            await controller.dispose();
                            controller = CameraController(newCameraDescription, ResolutionPreset.high);
                            await controller.initialize();
                            setState(() {});
                          }
                        },
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).secondary,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.flip_camera_ios_outlined,
                            color: FlutterFlowTheme.of(context).primaryBackground,
                            size: 36,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
