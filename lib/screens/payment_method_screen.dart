import 'package:e_commerce_app/screens/order_confirm_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

class PaymentScreen extends StatefulWidget {
  final String fullName;
  final String fullAddress;

  const PaymentScreen({
    super.key,
    required this.fullName,
    required this.fullAddress,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Column(
          children: [
            _buildCreditCardWidget(),
            Expanded(child: _buildCreditCardForm()),
            _buildSubmitButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildCreditCardWidget() {
    return CreditCardWidget(
      cardNumber: cardNumber,
      expiryDate: expiryDate,
      cardHolderName: cardHolderName,
      cvvCode: cvvCode,
      showBackView: isCvvFocused,
      cardBgColor: Colors.blueAccent,
      isSwipeGestureEnabled: true,
      obscureCardNumber: true,
      obscureCardCvv: true,
      onCreditCardWidgetChange: (_) {},
    );
  }

  Widget _buildCreditCardForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: CreditCardForm(
        formKey: formKey,
        obscureCvv: true,
        obscureNumber: true,
        isHolderNameVisible: true,
        isCardNumberVisible: true,
        isExpiryDateVisible: true,
        cardNumber: cardNumber,
        cvvCode: cvvCode,
        cardHolderName: cardHolderName,
        expiryDate: expiryDate,
        onCreditCardModelChange: _onModelChange,
      ),
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueAccent,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        onPressed: isLoading ? null : _onValidate,
        child:
            isLoading
                ? const CircularProgressIndicator(color: Colors.white)
                : const Text('Submit Payment'),
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

  void _onValidate() async {
    if (formKey.currentState?.validate() ?? false) {
      setState(() => isLoading = true);

      await Future.delayed(const Duration(seconds: 1)); // Simulate payment

      setState(() => isLoading = false);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Payment Info Submitted Successfully')),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder:
              (_) => OrderConfirmScreen(
                fullName: widget.fullName,
                fullAddress: widget.fullAddress,
                cardNumber: cardNumber,
              ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please complete the form properly')),
      );
    }
  }
}
