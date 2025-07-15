import 'package:e_commerce_app/screens/shipping_address_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void _onValidate() {
    if (formKey.currentState!.validate()) {
      print('Card Number: $cardNumber');
      print('Expiry Date: $expiryDate');
      print('Card Holder: $cardHolderName');
      print('CVV: $cvvCode');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Payment Info Submitted Successfully')),
      );
    } else {
      print('Invalid info');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Payment')),
      body: SafeArea(
        child: Column(
          children: [
            CreditCardWidget(
              cardNumber: cardNumber,
              expiryDate: expiryDate,
              cardHolderName: cardHolderName,
              cvvCode: cvvCode,
              showBackView: isCvvFocused,
              cardBgColor: Colors.blueAccent,
              isSwipeGestureEnabled: true,
              obscureCardNumber: true,
              obscureCardCvv: true, onCreditCardWidgetChange: (CreditCardBrand ) {},
            ),
            Expanded(
              child: SingleChildScrollView(
                child: CreditCardForm(
                  formKey: formKey,
                  obscureCvv: true,
                  obscureNumber: true,
                  cardNumber: cardNumber,
                  cvvCode: cvvCode,
                  isHolderNameVisible: true,
                  isCardNumberVisible: true,
                  isExpiryDateVisible: true,
                  cardHolderName: cardHolderName,
                  expiryDate: expiryDate,
                 
                  onCreditCardModelChange: _onModelChange,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: _onValidate,
                child: Text('Submit Payment'),

              ),
            ),
            
          ],
        ),
      ),
    );
  }

  void _onModelChange(CreditCardModel model) {
    setState(() {
      cardNumber = model.cardNumber;
      expiryDate = model.expiryDate;
      cardHolderName = model.cardHolderName;
      cvvCode = model.cvvCode;
      isCvvFocused = model.isCvvFocused;
    });
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      hintText: label,
      border: OutlineInputBorder(),
    );
  }
}