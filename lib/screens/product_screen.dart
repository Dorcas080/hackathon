import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/screens/cart_screen.dart';
import 'package:fan_carousel_image_slider/fan_carousel_image_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:e_commerce_app/model/product.dart';
import 'package:e_commerce_app/widgets/container_button_model.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key, required this.product});

  final Product product;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  // List<String> images = [
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Overview"),
        leading: BackButton(),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 450,
                  width: MediaQuery.of(context).size.width,
                  child: FanCarouselImageSlider.sliderType1(
                    sliderHeight: 430,
                    autoPlay: true,
                    imagesLink: List.generate(4, (int) => widget.product.image),
                    isAssets: false,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 30),
                        SizedBox(
                          width: 250,
                          child: Text(
                            widget.product.title,
                            maxLines: 2,

                            style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w900,
                              fontSize: 25,
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        SizedBox(
                          width: 280,
                          child: Text(
                            widget.product.title,
                            maxLines: 2,
                            style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "\$ ${widget.product.price}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Color(0xFFDB3022),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: RatingBar.builder(
                    initialRating: 3,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 25,
                    itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                    itemBuilder:
                        (context, _) => Icon(Icons.star, color: Colors.amber),
                    onRatingUpdate: (rating) {},
                  ),
                ),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.product.description,
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        color: Color(0x1F989797),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: Icon(Icons.favorite, color: Color(0xFFDB3022)),
                      ),
                    ),

                    InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          backgroundColor: Colors.transparent,
                          context: context,
                          builder:
                              (context) => BottomSheet(product: widget.product),
                        );
                      },

                      child: ContainerButtonModel(
                        containerWidth: MediaQuery.of(context).size.width / 1.5,
                        itext: "Buy Now",
                        bgColor: Color(0xFFDB3022),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BottomSheet extends StatefulWidget {
  final Product product;
  const BottomSheet({super.key, required this.product});

  @override
  State<BottomSheet> createState() => _BottomSheetState();
}

class _BottomSheetState extends State<BottomSheet> {
  int total = 1;
  List<Color> clrs = [
    const Color.fromRGBO(0, 0, 0, 1),
    Colors.yellow,
    Colors.yellow,
    Colors.red,
  ];
  var iStyle = TextStyle(fontSize: 14);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2.5,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Text("Total", style: iStyle),
                    SizedBox(height: 20),
                  ],
                ),
                SizedBox(width: 30),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 18),
                    Row(
                      children: [
                        SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            if (total <= 1) return;
                            setState(() {
                              total--;
                            });
                          },
                          child: Icon(
                            CupertinoIcons.minus,
                            color: Colors.green,
                          ),
                        ),
                        SizedBox(width: 30),
                        Text("$total", style: iStyle),
                        SizedBox(width: 30),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              total++;
                            });
                          },
                          child: Icon(CupertinoIcons.add, color: Colors.green),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total Payment", style: iStyle),
                Text(
                  "\$ ${widget.product.price! * total}",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFDB3022),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () async {
                // var acartID = Uuid().v4();
                await FirebaseFirestore.instance
                    .collection("users")
                    .doc(FirebaseAuth.instance.currentUser?.uid)
                    .collection("carts")
                    .doc(widget.product.id.toString())
                    .set({
                      "id": widget.product.id,
                      "product": widget.product.toMap(),
                      "count": total,
                      "totalAmount": widget.product.price! * total,
                    });
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CartScreen()),
                );
              },
              child: ContainerButtonModel(
                containerWidth: MediaQuery.of(context).size.width,
                itext: "Add To Cart",
                bgColor: Color(0xFFDB3022),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
