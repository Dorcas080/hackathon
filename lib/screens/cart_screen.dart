import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/screens/payment_method_screen.dart';
import 'package:e_commerce_app/widgets/container_button_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  CartScreen({super.key});

  int convertToTotal(List prices) {
    int sum = 0;
    print("the length ${prices.length}");
    for (var price in prices) {
      sum += price as int;
      print(price.runtimeType);
    }

    return sum;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
        leading: BackButton(),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              Container(
                child: StreamBuilder(
                  stream:
                      FirebaseFirestore.instance
                          .collection('users')
                          .doc(FirebaseAuth.instance.currentUser?.uid)
                          .collection("carts")
                          .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasData) {
                      var data = snapshot.data;
                      List carts = data!.docs;
                      return ListView.builder(
                        itemCount: carts.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          var cart = carts[index];
                          return Container(
                            margin: EdgeInsets.symmetric(vertical: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Checkbox(
                                  splashRadius: 20,
                                  activeColor: Color(0xFFDB3022),
                                  value: true,
                                  onChanged: (val) {},
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    cart["product"]["image"],
                                    height: 80,
                                    width: 80,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 120,

                                      child: Text(
                                        cart["product"]["title"],
                                        maxLines: 2,
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w900,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    SizedBox(
                                      width: 100,
                                      child: Text(
                                        cart['product']['description'],
                                        maxLines: 1,
                                        style: TextStyle(
                                          color: Colors.black26,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      "${cart["totalAmount"] ?? 0}",
                                      style: TextStyle(
                                        color: Color(0xFFDB3022),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      CupertinoIcons.minus,
                                      color: Colors.green,
                                    ),
                                    SizedBox(width: 20),
                                    Text(
                                      "${cart['count'] ?? 0}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Icon(
                                      CupertinoIcons.plus,
                                      color: Color(0xFFDB3022),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    } else {
                      return Center(child: Column());
                    }
                  },
                ),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Select All",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  Checkbox(
                    splashRadius: 20,
                    activeColor: Color(0xFFDB3022),
                    value: false,
                    onChanged: (val) {},
                  ),
                ],
              ),
              Divider(height: 20, thickness: 1, color: Colors.black),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total Payment",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  StreamBuilder(
                    stream:
                        FirebaseFirestore.instance
                            .collection("users")
                            .doc(FirebaseAuth.instance.currentUser?.uid)
                            .collection("carts")
                            .snapshots(),
                    builder: (context, snapshot) {
                      var data = snapshot.data?.docs;
                      return Text(
                        (data ?? []).isNotEmpty
                            ? convertToTotal(
                              data!
                                  .map((e) => e.data()["totalAmount"])
                                  .toList(),
                            ).toString()
                            : "\$   300.50",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFFDB3022),
                        ),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaymentMethodScreen(),
                    ),
                  );
                },
                child: ContainerButtonModel(
                  itext: "Checkout",
                  containerWidth: MediaQuery.of(context).size.width,
                  bgColor: Color(0xFFDB3022),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
