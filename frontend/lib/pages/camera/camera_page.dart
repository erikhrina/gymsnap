import 'dart:io';
import 'dart:typed_data';

import 'package:camerawesome/pigeon.dart';
import 'package:flutter/material.dart';
import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:gymsnap/pages/prediction/prediction_page.dart';
import 'package:gymsnap/services/images_service.dart';
import 'package:gymsnap/widgets/loading_indicator.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  final _imagesService = ImagesService();
  void _pop(context) => Navigator.of(context).pop();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CameraAwesomeBuilder.awesome(
          saveConfig: SaveConfig.photo(
            mirrorFrontCamera: false,
            exifPreferences: ExifPreferences(saveGPSLocation: false),
          ),
          sensorConfig: SensorConfig.single(),
          topActionsBuilder: (state) => AwesomeTopActions(
            state: state,
            children: [
              InkWell(
                onTap: () => _pop(context),
                child: AwesomeCircleWidget.icon(
                  icon: Icons.arrow_back,
                ),
              ),
            ],
          ),
          middleContentBuilder: (state) => SizedBox.shrink(),
          bottomActionsBuilder: (state) => AwesomeBottomActions(
            state: state,
            left: AwesomeFlashButton(state: state),
            captureButton: AwesomeCaptureButton(state: state),
            right: InkWell(
              onTap: () async {
                // Pick and convert image to JPG
                Uint8List? image = await _imagesService.pickAndConvertImage();
                // Classify the image and update filters
                await _handleImage(image);
              },
              child: AwesomeCircleWidget.icon(
                icon: Icons.image_outlined,
              ),
            ),
          ),
          onMediaCaptureEvent: (event) async {
            if (event.status == MediaCaptureStatus.success &&
                event.isPicture == true) {
              event.captureRequest.when(
                single: (single) async {
                  showDialog(
                    context: context,
                    builder: (context) => Center(
                      child: SizedBox(
                        height: 32,
                        width: 32,
                        child: LoadingIndicatorWrapper(),
                      ),
                    ),
                  );
                  debugPrint('Picture saved: ${single.file?.path}');
                  if (single.file != null) {
                    // Load the file
                    Uint8List imageBytes = File(
                      single.file!.path,
                    ).readAsBytesSync();
                    // Remove the file from the phone
                    File(
                      single.file!.path,
                    ).delete();
                    // Convert the file to JPG
                    Uint8List jpgImage = await _imagesService.convertToJPG(
                      imageBytes,
                    );
                    if (context.mounted) Navigator.of(context).pop();
                    // Classify the image and update filters
                    await _handleImage(jpgImage);
                  }
                },
              );
            }
          },
          progressIndicator: LoadingIndicatorWrapper(),
        ),
      ),
    );
  }

  Future<void> _handleImage(Uint8List? jpgImage) async {
    if (jpgImage != null) {
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PredictionPage(jpgImage),
        ),
      );
    }
    _pop(context);
  }
}
