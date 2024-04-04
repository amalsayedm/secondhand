import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_share/whatsapp_share.dart';

import '../data_models/product_model.dart';
import '../network/endpoints.dart';
import 'package:uni_links/uni_links.dart'; // Import the uni_links package



class ProductDetailsScreen extends StatelessWidget {

  late Product product;

  ProductDetailsScreen(Product product, {super.key}) {

    this.product=product;
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(),
      body:SingleChildScrollView(
        child: Container(color: Colors.white,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(image: NetworkImage(PRODUCTS_IMAGES+product.image),width: double.infinity,
                    height: 500,),
        
                ],
              ),
        
              Padding(
                padding: const EdgeInsetsDirectional.only(top: 20, start: 5, end: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    SizedBox(height: 10), // Add space between product name and details
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
        
                        Row(
                          children: [
                            Text(
                              'Price: ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              product.price.toString() + " L.E.",
                              style: TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(height: 5), // Add space between price and size
                        Row(
                          children: [
                            Text(
                              'Size: ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              product.size,
                              // Replace 'product.size' with actual size data
                            ),
                          ],
                        ),
                        SizedBox(height: 5), // Add space between size and location
                        Row(
                          children: [
                            Text(
                              'Location: ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              product.location_name,
                              // Replace 'product.location' with actual location data
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10), // Add space between details and contact button
                    Padding(
                      padding: EdgeInsets.only(left:100,right: 100,top: 20),
                      child: Row(mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              // Handle contact button press
                              getcontact(product.contact, product.name);
                            },
                            child: Text('Contact'),
                          ),
                          Spacer(),
                          IconButton(
                            icon: CircleAvatar(
                              radius: 15,
                              // backgroundColor: product.in_favorites ? Colors.deepOrange : Colors.grey,
                              child: Icon(
                                Icons.favorite_outline,
                                size: 14,
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () {
                              //cubit.updateFavourite(id:product.id);
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              // SizedBox(height: 5,),
        
            ],),
        ),
      ) ,
    );


}
  Future<void> getcontact(String phone_number,String message) async {
    await WhatsappShare.share(
      text: 'Hello, Iam interested in this $message on Second Hand mobile application',
      linkUrl: PRODUCTS_IMAGES+product.image,
      phone: '2'+phone_number,
    );
  }
 }
