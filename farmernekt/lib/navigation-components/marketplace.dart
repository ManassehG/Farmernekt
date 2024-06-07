import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

class MarketplacePage extends StatefulWidget {
  @override
  _MarketplacePageState createState() => _MarketplacePageState();
}

class _MarketplacePageState extends State<MarketplacePage> {
  List<Product> mySales = [];
  List<Product> allListings = [
    Product(
      productName: 'Organic Tomatoes',
      description: 'Fresh organic tomatoes from local farmers.',
      price: 10.0,
      imagePath: 'assets/images/vegetables.jpg',
    ),
    Product(
      productName: 'Free-range Eggs',
      description: 'Farm-fresh free-range eggs.',
      price: 5.0,
      imagePath: 'assets/images/vegetables.jpg',
    ),
  ];

  TextEditingController searchController = TextEditingController();
  List<Product> searchResults = [];

  @override
  void initState() {
    super.initState();
    searchResults = allListings;
  }

  void addProduct(Product product) {
    setState(() {
      mySales.add(product);
      allListings.add(product);
    });
  }

  void searchProducts(String query) {
    final results = allListings.where((product) {
      final productName = product.productName.toLowerCase();
      final searchQuery = query.toLowerCase();
      return productName.contains(searchQuery);
    }).toList();

    setState(() {
      searchResults = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Marketplace'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'My Sales'),
              Tab(text: 'All Listings'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            MySalesPage(mySales: mySales, addProduct: addProduct),
            AllListingsPage(
              listings: searchResults,
              searchController: searchController,
              onSearch: searchProducts,
            ),
          ],
        ),
      ),
    );
  }
}

class MySalesPage extends StatelessWidget {
  final List<Product> mySales;
  final Function(Product) addProduct;

  MySalesPage({required this.mySales, required this.addProduct});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Listings',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Column(
              children: mySales.map((product) {
                return ProductListingTile(
                  productName: product.productName,
                  description: product.description,
                  price: product.price,
                  imagePath: product.imagePath,
                );
              }).toList(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddProductPage(addProduct: addProduct)),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class AllListingsPage extends StatelessWidget {
  final List<Product> listings;
  final TextEditingController searchController;
  final Function(String) onSearch;

  AllListingsPage({
    required this.listings,
    required this.searchController,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Search',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: onSearch,
            ),
            SizedBox(height: 16.0),
            Text(
              'Browse Products',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Column(
              children: listings.map((product) {
                return ProductTile(
                  productName: product.productName,
                  description: product.description,
                  price: product.price,
                  imageUrl: product.imagePath,
                  onTap: () {
                    // Implement action when product is tapped
                  },
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class AddProductPage extends StatefulWidget {
  final Function(Product) addProduct;

  AddProductPage({required this.addProduct});

  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();
  final _productNameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  File? _imageFile;

  Future<void> _pickImage() async {
    final status = await Permission.photos.request();
    if (status.isGranted) {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      setState(() {
        if (pickedFile != null) {
          _imageFile = File(pickedFile.path);
        }
      });
    } else {
      // Handle permission denied case
      print("Permission denied");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _productNameController,
                  decoration: InputDecoration(labelText: 'Product Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a product name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(labelText: 'Description'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _priceController,
                  decoration: InputDecoration(labelText: 'Price'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a price';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.0),
                _imageFile == null
                    ? Text('No image selected.')
                    : Image.file(_imageFile!, height: 200),
                SizedBox(height: 10.0),
                ElevatedButton(
                  onPressed: _pickImage,
                  child: Text('Select Image'),
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate() &&
                        _imageFile != null) {
                      final product = Product(
                        productName: _productNameController.text,
                        description: _descriptionController.text,
                        price: double.parse(_priceController.text),
                        imagePath: _imageFile!.path,
                      );
                      widget.addProduct(product);
                      Navigator.pop(context);
                    }
                  },
                  child: Text('Add Product'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProductListingTile extends StatelessWidget {
  final String productName;
  final String description;
  final double price;
  final String imagePath;

  const ProductListingTile({
    required this.productName,
    required this.description,
    required this.price,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.0),
              bottomLeft: Radius.circular(12.0),
            ),
            child: Image.file(
              File(imagePath),
              width: 120,
              height: 120,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productName,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    description,
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    '\$$price',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProductTile extends StatelessWidget {
  final String productName;
  final String description;
  final double price;
  final String imageUrl;
  final VoidCallback? onTap;

  const ProductTile({
    required this.productName,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.0),
                bottomLeft: Radius.circular(12.0),
              ),
              child: Image.asset(
                imageUrl,
                width: 120,
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productName,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      description,
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      '\$$price',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Product {
  final String productName;
  final String description;
  final double price;
  final String imagePath;

  Product({
    required this.productName,
    required this.description,
    required this.price,
    required this.imagePath,
  });
}
