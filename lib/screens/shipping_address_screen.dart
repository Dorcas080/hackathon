import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/screens/payment_method_screen.dart';
import 'package:e_commerce_app/widgets/container_button_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ShippingAddressScreen extends StatefulWidget {
  const ShippingAddressScreen({super.key});

  @override
  State<ShippingAddressScreen> createState() => _ShippingAddressScreenState();
}

class _ShippingAddressScreenState extends State<ShippingAddressScreen> {
  final nameController = TextEditingController();
  final mobileNumberController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final postalCodeController = TextEditingController();
  final countryController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void _submitAddress() async {
    if (nameController.text.isEmpty ||
        mobileNumberController.text.isEmpty ||
        addressController.text.isEmpty ||
        cityController.text.isEmpty ||
        stateController.text.isEmpty ||
        postalCodeController.text.isEmpty ||
        countryController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all fields")),
      );
      return;
    }

    // Save to Firestore
    final uid = FirebaseAuth.instance.currentUser?.uid;
    final fullName = nameController.text;
    final fullAddress =
        '${addressController.text}, ${cityController.text}, ${stateController.text}, ${postalCodeController.text}, ${countryController.text}';

    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("address")
        .doc(uid)
        .set({
          'name': fullName,
          'phone': mobileNumberController.text,
          'address': addressController.text,
          'city': cityController.text,
          'state': stateController.text,
          'postalcode': postalCodeController.text,
          'country': countryController.text,
        });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) =>
                PaymentScreen(fullName: fullName, fullAddress: fullAddress),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Shipping Address"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const SizedBox(height: 40),
                _buildTextField(nameController, "Full Name"),
                const SizedBox(height: 20),
                _buildTextField(mobileNumberController, "Mobile Number"),
                const SizedBox(height: 20),
                _buildTextField(addressController, "Address"),
                const SizedBox(height: 20),
                _buildTextField(cityController, "City"),
                const SizedBox(height: 20),
                _buildTextField(stateController, "State/Province/Region"),
                const SizedBox(height: 20),
                _buildTextField(postalCodeController, "Zip Code (Postal Code)"),
                const SizedBox(height: 20),
                _buildTextField(countryController, "Country"),
                const SizedBox(height: 30),
                InkWell(
                  onTap: _submitAddress,
                  child: ContainerButtonModel(
                    itext: "Add Address",
                    containerWidth: MediaQuery.of(context).size.width,
                    bgColor: const Color(0xFFDB3022),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String labelText) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: labelText,
      ),
    );
  }
}
