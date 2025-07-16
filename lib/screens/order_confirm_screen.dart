import 'package:e_commerce_app/screens/order_success_screen.dart';
import 'package:flutter/material.dart';

class OrderConfirmScreen extends StatelessWidget {
  final String fullName;
  final String fullAddress;
  final String cardNumber;

  const OrderConfirmScreen({
    super.key,
    required this.fullName,
    required this.fullAddress,
    required this.cardNumber,
  });
  void _goToSuccessScreen(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const SuccessScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    const double subTotal = 300.50;
    const double shippingFee = 15.00;
    final double total = subTotal + shippingFee;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirm Order'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle('Shipping Address'),
            _infoCard(
              context,
              title: fullName,
              subtitle: fullAddress,
              onChange: () => Navigator.pop(context),
            ),
            const SizedBox(height: 20),

            _sectionTitle('Payment Method'),
            _paymentCard(context, cardNumber),

            const SizedBox(height: 20),
            _sectionTitle('Delivery Method'),
            _deliveryOptions(),

            const SizedBox(height: 30),
            _priceSummary(
              subTotal: subTotal,
              shippingFee: shippingFee,
              total: total,
            ),

            const SizedBox(height: 20),
            _confirmButton(context),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    );
  }

  Widget _infoCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required VoidCallback onChange,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 5)],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(subtitle),
              ],
            ),
          ),
          TextButton(
            onPressed: onChange,
            child: const Text("Change", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  Widget _paymentCard(BuildContext context, String cardNumber) {
    String last4 =
        cardNumber.length >= 4
            ? cardNumber.substring(cardNumber.length - 4)
            : '****';

    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 5)],
      ),
      child: Row(
        children: [
          const Icon(Icons.credit_card, color: Colors.deepOrange, size: 36),
          const SizedBox(width: 12),
          Text("**** **** **** $last4", style: const TextStyle(fontSize: 16)),
          const Spacer(),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Change", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  Widget _deliveryOptions() {
    return Row(
      children: [
        _deliveryOptionTile('FedEx', '2–7 Days', Icons.local_shipping),
        const SizedBox(width: 10),
        _deliveryOptionTile('Home Delivery', '2–7 Days', Icons.home),
      ],
    );
  }

  Widget _deliveryOptionTile(String title, String subtitle, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blueAccent, width: 1.5),
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.blueAccent),
            const SizedBox(height: 6),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(subtitle, style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _priceSummary({
    required double subTotal,
    required double shippingFee,
    required double total,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _priceRow('Sub-Total', '\$${subTotal.toStringAsFixed(2)}'),
        _priceRow('Shipping Fee', '\$${shippingFee.toStringAsFixed(2)}'),
        const Divider(thickness: 1),
        _priceRow(
          'Total Payment',
          '\$${total.toStringAsFixed(2)}',
          isTotal: true,
        ),
      ],
    );
  }

  Widget _priceRow(String label, String amount, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? Colors.red : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _confirmButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        onPressed: () {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text("Order confirmed!")));
        },
        child: const Text("Confirm Order", style: TextStyle(fontSize: 16)),
      ),
    );
  }
}
