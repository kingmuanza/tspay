import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:tspay/composants/typographie.dart';
import 'package:tspay/page.dart';
import 'package:tspay/paiement.effectue.page.dart';
import 'package:tspay/pay.confirmation.dart';
import 'package:tspay/services/qrcode.service.dart';
import 'package:vibration/vibration.dart';

import 'models/paiement.model.dart';

class PayPage extends StatefulWidget {
  const PayPage({Key? key}) : super(key: key);

  @override
  _PayPageState createState() => _PayPageState();
}

class _PayPageState extends State<PayPage> {
  Widget contenu() {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(0, 0, 34, 1),
      ),
      alignment: Alignment.center,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 16),
            width: double.infinity,
            child: Typographie.appTitre("Scanner un QR Code"),
          ),
          Container(
            padding: EdgeInsets.only(
              top: 16,
              bottom: 32,
            ),
            width: double.infinity,
            child: Typographie.appSousTitre(
              "Nunc fringilla, tortor eu venenatis tempor, purus sem suscipit ex, et dictum sem ligula ut velit. ",
            ),
          ),
          bordureHaute(),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.transparent,
                width: 2,
                style: BorderStyle.solid,
              ),
            ),
            width: double.infinity,
            height: 300,
            margin: EdgeInsets.only(top: 0),
            child: Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: QRView(
                key: qrKey,
                onQRViewCreated: _onQRViewCreated,
              ),
            ),
          ),
          bordureBasse(),
          TextButton(
            onPressed: () {
              if (controller != null) {
                if (Platform.isAndroid) {
                  controller!.resumeCamera();
                } else if (Platform.isIOS) {
                  controller!.resumeCamera();
                }
              } else {}
            },
            child: Text("Refaire le scan"),
          )
        ],
      ),
    );
  }

  Widget bordureHaute() {
    return Column(
      children: [
        Row(
          children: [
            Container(
              height: 5,
              width: 20,
              color: Colors.white,
            ),
            Expanded(
              child: Container(
                height: 5,
                width: 20,
                color: Colors.transparent,
              ),
            ),
            Container(
              height: 5,
              width: 20,
              color: Colors.white,
            ),
          ],
        ),
        Row(
          children: [
            Container(
              height: 20,
              width: 5,
              color: Colors.white,
            ),
            Expanded(
              child: Container(
                height: 20,
                width: 5,
                color: Colors.transparent,
              ),
            ),
            Container(
              height: 20,
              width: 5,
              color: Colors.white,
            ),
          ],
        ),
      ],
    );
  }

  Widget bordureBasse() {
    return Column(
      children: [
        Row(
          children: [
            Container(
              height: 20,
              width: 5,
              color: Colors.white,
            ),
            Expanded(
              child: Container(
                height: 20,
                width: 5,
                color: Colors.transparent,
              ),
            ),
            Container(
              height: 20,
              width: 5,
              color: Colors.white,
            ),
          ],
        ),
        Row(
          children: [
            Container(
              height: 5,
              width: 20,
              color: Colors.white,
            ),
            Expanded(
              child: Container(
                height: 5,
                width: 20,
                color: Colors.transparent,
              ),
            ),
            Container(
              height: 5,
              width: 20,
              color: Colors.white,
            ),
          ],
        ),
      ],
    );
  }

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  @override
  void reassemble() {
    print("reassemble reassemble reassemble reassemble");
    super.reassemble();
    if (controller != null) {
      if (Platform.isAndroid) {
        controller!.pauseCamera();
      } else if (Platform.isIOS) {
        controller!.resumeCamera();
      }
    } else {}
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        print("resultat : ");
        print(result!.code);
        if (controller != null && result!.code != null) {
          if (Platform.isAndroid) {
            controller.stopCamera();
          } else if (Platform.isIOS) {
            controller.stopCamera();
          }
          Vibration.hasVibrator().then((hasVibrator) {
            print("hasVibrator : ");
            print(hasVibrator);
            Vibration.vibrate();
          });
          recupererPaiement(result!.code!).then((paiement) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PayConfirmationPage(
                  paiement: paiement,
                ),
              ),
            );
          });
        } else {}
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaPage(child: contenu(), index: 2);
  }

  Future<Paiement> recupererPaiement(String idpaiement) async {
    QRCodeService qRCodeService = QRCodeService();

    Paiement? paiement = await qRCodeService.recuperer(idpaiement);
    if (paiement != null) {
      return paiement;
    } else {
      return Paiement(0);
    }
  }
}
