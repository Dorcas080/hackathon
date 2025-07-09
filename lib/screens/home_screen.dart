// ignore_for_file: unused_element

import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:e_commerce_app/api/product_api.dart';
import 'package:e_commerce_app/model/product.dart';
import 'package:e_commerce_app/screens/product_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> tabs = [
    "tv",
    "audio",
    "laptop",
    "mobile",
    "gaming",
    "appliances",
  ];
  String category = "tv";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.all(5),
                      height: 50,
                      width: MediaQuery.of(context).size.width / 1.5,
                      decoration: BoxDecoration(
                        color: Colors.black12.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(10),
                        // boxShadow: [
                        //   BoxShadow(
                        //     color: Colors.black12.withOpacity(0.05),
                        //     blurRadius: 2,
                        //     spreadRadius: 1,
                        //     ),

                        // ],
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.search,
                            color: Color(0xFFDB3022),
                          ),
                          border: InputBorder.none,
                          label: Text("Find your product", style: TextStyle()),
                        ),
                      ),
                    ),
                    Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width / 6,
                      decoration: BoxDecoration(
                        color: Colors.black12.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12.withOpacity(0.05),
                            blurRadius: 2,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Icon(
                          Icons.notifications,
                          color: Color(0xFFDB3022),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Color(0xFFFFF0DD),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Image.asset("assets/images/freed.png"),
                ),
                SizedBox(height: 20),
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: tabs.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            category = tabs[index];
                          });
                        },
                        child: FittedBox(
                          child: Container(
                            height: 40,
                            margin: EdgeInsets.only(left: 10, right: 10),
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              color:
                                  category == tabs[index]
                                      ? Color(0xffdb3022)
                                      : Colors.black12.withOpacity(0.05),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: FittedBox(
                                child: Text(
                                  tabs[index].toString().toUpperCase(),
                                  style: TextStyle(
                                    color: Colors.black38,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  height: 180,
                  child: FutureBuilder(
                    future: ProductApi().getProductCategory(category),
                    builder: (context, asyncSnapshot) {
                      if (asyncSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return ListView.builder(
                          itemCount: 2,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return ProductCard(product: null);
                          },
                        );
                      } else if (asyncSnapshot.hasData) {
                        var products = asyncSnapshot.data;
                        return ListView.builder(
                          itemCount: products?.length,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            var product = products?[index];
                            return ProductCard(product: product);
                          },
                        );
                      } else {
                        return Center(child: Container());
                      }
                    },
                  ),
                ),
                SizedBox(height: 30),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Newest Products",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),

                SizedBox(height: 30),
                FutureBuilder(
                  future: ProductApi().getProduct(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return GridView.builder(
                        itemCount: 4,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.6,
                          // crossAxisSpacing: 40,
                        ),
                        itemBuilder: (context, index) {
                          return ProductWidget(product: null);
                        },
                      );
                    } else if (snapshot.hasData) {
                      var products = snapshot.data;
                      print("this is the length ${products!.length}");
                      return GridView.builder(
                        itemCount: products.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.6,
                          // crossAxisSpacing: 40,
                        ),
                        itemBuilder: (context, index) {
                          final product = products[index];

                          return ProductWidget(product: product);
                        },
                      );
                    } else {
                      return Center(child: Container());
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProductCard extends StatefulWidget {
  const ProductCard({super.key, this.product});

  final Product? product;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> _toggleFavorite(bool isLoved) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null || widget.product == null) return;
    final docRef = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('favorites')
        .doc(widget.product!.id?.toString());
    if (isLoved) {
      await docRef.delete();
    } else {
      await docRef.set(Map<String, dynamic>.from(widget.product!.toMap()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,

      margin: EdgeInsets.only(right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 180,
            width: 180,
            child: Stack(
              children: [
                InkWell(
                  onTap: () {
                    if (widget.product == null) return;

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) =>
                                ProductScreen(product: widget.product!),
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl:
                          widget.product?.image ?? "", // imageList[index],
                      fit: BoxFit.cover,
                      height: 180,
                      width: 180,
                    ),
                  ),
                ),
                Positioned(
                  right: 10,
                  top: 10,
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: StreamBuilder(
                        stream:
                            FirebaseFirestore.instance
                                .collection('users')
                                .doc(FirebaseAuth.instance.currentUser?.uid)
                                .collection('favorites')
                                .doc(widget.product?.id?.toString())
                                .snapshots(),
                        builder: (context, snapshot) {
                          log("${snapshot.data?.data().toString()}");

                          return GestureDetector(
                            onTap: () {
                              _toggleFavorite((snapshot.data?.exists ?? false));
                            },
                            child: Icon(
                              (snapshot.data?.exists ?? false)
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: Color(0xFFDB3022),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 130,
                  child: Text(
                    widget.product?.title ?? "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,

                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: 130,

                  child: Text(
                    widget.product?.description ?? "",
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(height: 10),

                Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 22),
                    Text(
                      '('
                      "89"
                      ')',
                    ),
                    SizedBox(width: 10),
                    Text(
                      "\$ ${widget.product?.price ?? ""}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFDB3022),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProductWidget extends StatefulWidget {
  const ProductWidget({super.key, this.product});

  final Product? product;

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {

  @override
  void initState() {
    super.initState();
  }

  Future<void> _toggleFavorite(bool isLoved) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null || widget.product == null) return;
    final docRef = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('favorites')
        .doc(widget.product!.id?.toString());
    if (isLoved) {
      await docRef.delete();
    } else {
      await docRef.set(
        widget.product!.toMap().map((k, v) => MapEntry(k ?? '', v)),
      );
    }

  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 220,

            child: Stack(
              children: [
                InkWell(
                  onTap: () {
                    if (widget.product == null) return;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) =>
                                ProductScreen(product: widget.product!),
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child:
                        widget.product == null
                            ? Card(child: SizedBox(height: 220, width: 180))
                            : CachedNetworkImage(
                              imageUrl: widget.product?.image ?? "",
                              width: 180,
                              fit: BoxFit.cover,
                              height: 220,
                            ),
                  ),
                ),
                Positioned(
                  right: 10,
                  top: 10,
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: StreamBuilder(
                        stream:
                            FirebaseFirestore.instance
                                .collection('users')
                                .doc(FirebaseAuth.instance.currentUser?.uid)
                                .collection('favorites')
                                .doc(widget.product?.id?.toString())
                                .snapshots(),
                        builder: (context, snapshot) {
                          log("${snapshot.data?.data().toString()}");

                          return GestureDetector(
                            onTap: () {
                              _toggleFavorite((snapshot.data?.exists ?? false));
                            },
                            child: Icon(
                              (snapshot.data?.exists ?? false)
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: Color(0xFFDB3022),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Text(
            widget.product?.title ?? "",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),

          Row(
            children: [
              Icon(Icons.star, color: Colors.amber, size: 22),
              Text(
                '('
                "90"
                ')',
              ),
              SizedBox(width: 10),
              Text(
                "\$ ${widget.product?.price.toString() ?? ""}",

                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFDB3022),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
