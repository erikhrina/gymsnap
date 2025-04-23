import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:gymsnap/api/prediction_api.dart';
import 'package:gymsnap/models/equipment.dart';
import 'package:gymsnap/utils/theme.dart';
import 'package:gymsnap/widgets/filters_sheet.dart';
import 'package:gymsnap/widgets/icon_button.dart';
import 'package:gymsnap/widgets/loading_indicator.dart';

class PredictionPage extends StatefulWidget {
  const PredictionPage(this.image, {super.key});

  final Uint8List image;

  @override
  State<PredictionPage> createState() => _PredictionPageState();
}

class _PredictionPageState extends State<PredictionPage> {
  final _predictionApiService = GetIt.instance<PredictionApiService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 30,
        backgroundColor: Colors.transparent,
        leading: InkWell(
          onTap: () {
            selectedEquipment = null;
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back,
          ),
        ),
      ),
      body: FutureBuilder(
        future: _getPrediction(widget.image),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final Equipment? equipment = snapshot.data;
            return equipment != null
                ? SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 8.0,
                            left: 16.0,
                            right: 16.0,
                          ),
                          child: SizedBox(
                            width: double.infinity,
                            child: Image.memory(
                              widget.image,
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            equipment.name,
                            style: AppTheme.of(context).titleLarge,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButtonWrapper(
                              onPressed: () {
                                selectedEquipment = null;
                                Navigator.of(context).pop();
                              },
                              icon: Icons.close,
                              backgroundColor: const Color(0xFFBA0A0A),
                              width: MediaQuery.of(context).size.width / 2 - 20,
                            ),
                            IconButtonWrapper(
                              onPressed: () => Navigator.of(context).pop(),
                              icon: Icons.check,
                              backgroundColor: const Color(0xFF0ABA19),
                              width: MediaQuery.of(context).size.width / 2 - 20,
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 4.0,
                            horizontal: 10.0,
                          ),
                          child: SizedBox(
                            width: double.infinity,
                            child: TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              style: ButtonStyle(
                                minimumSize:
                                    WidgetStateProperty.resolveWith<Size>(
                                  (states) => Size(
                                    double.infinity,
                                    35,
                                  ),
                                ),
                                shape: WidgetStateProperty.resolveWith<
                                    OutlinedBorder>(
                                  (states) {
                                    return RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      side: BorderSide(
                                        color: Colors.transparent,
                                        width: 0,
                                      ),
                                    );
                                  },
                                ),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                  AppTheme.of(context).primary,
                                ),
                              ),
                              child: Text(
                                'Continue',
                                style:
                                    AppTheme.of(context).labelMedium.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                : SizedBox.shrink();
          } else if (snapshot.hasError) {
            return SizedBox.shrink();
          } else {
            return Center(child: LoadingIndicatorWrapper());
          }
        },
      ),
    );
  }

  Future<Equipment?> _getPrediction(Uint8List image) async {
    final equipment = await _predictionApiService.getPrediction(image);
    if (equipment == null) Navigator.of(context).pop();
    return selectedEquipment = equipment;
  }
}
