import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
class AddItemForm extends StatefulWidget {

  @override
  _AddItemFormState createState() => _AddItemFormState();
}

class _AddItemFormState extends State<AddItemForm> {
  final _addItemFormKey = GlobalKey<FormState>();

  bool _isProcessing = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _subtitleController = TextEditingController();
  final TextEditingController _urlImageController = TextEditingController();
  CollectionReference rooms =
  FirebaseFirestore.instance.collection('rooms');
  get helper => null;
  Future<void> _createOrUpdate([DocumentSnapshot documentSnapshot]) async {
    String action = 'create';
    if (documentSnapshot != null) {
      action = 'update';
      _idController.text = documentSnapshot['id'];
      _priceController.text = documentSnapshot['price'].toString();
      _subtitleController.text = documentSnapshot['subtitle'];
      _descriptionController.text = documentSnapshot['description'].toString();
      _nameController.text = documentSnapshot['name'];
      _descriptionController.text = documentSnapshot['description'].toString();
    }

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _idController,
                  decoration: InputDecoration(labelText: 'Id'),
                ),
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  controller: _priceController,
                  decoration: InputDecoration(labelText: 'Price'),
                ),
                TextField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Description',
                  ),
                ),
                TextField(
                  controller: _subtitleController,
                  decoration: InputDecoration(
                    labelText: 'Subtitle',
                  ),
                ),
                TextField(
                  controller: _urlImageController,
                  decoration: InputDecoration(
                    labelText: 'UrlImage',
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: Text(action == 'create' ? 'Create' : 'Update'),
                  onPressed: () async {
                    final String id = _idController.text;
                    final String name = _nameController.text;
                    final double price = double.tryParse(_priceController.text);
                    final String description = _descriptionController.text;
                    final String subtitle = _subtitleController.text;
                    final String urlImage = _urlImageController.text;
//                    final String id = _idController.text;
                    if (name != null && description != null) {
                      if (action == 'create') {
                        // Persist a new product to Firestore
                        await rooms.add({"id": id, "name": name, "price": price, "description": description, "subtitle":subtitle, "UrlImage": urlImage});
                      }

                      if (action == 'update') {
                        // Update the product
                        await rooms
                            .doc(documentSnapshot.id)
                            .update({"id": id, "name": name, "price": price, "description": description, "subtitle":subtitle, "UrlImage": urlImage});
                      }

                      // Clear the text fields
                      _idController.text = '';
                      _nameController.text = '';
                      _descriptionController.text = '';
                      _priceController.text = '';
                      _subtitleController.text = '';
                      _urlImageController.text = '';

                      // Hide the bottom sheet
                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );
          // TEXT BOX
        });
  }

  // Deleteing a product by id
  Future<void> _deleteProduct(String productId) async {
    await rooms.doc(productId).delete();

    // Show a snackbar
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('You have successfully deleted a product')));
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      // Using StreamBuilder to display all products from Firestore in real-time
      body: StreamBuilder(
        stream: rooms.snapshots(),
        builder: (context, streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                streamSnapshot.data.docs[index];
                return Card(
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(documentSnapshot['name']),
                    subtitle: Text(documentSnapshot['price'].toString()),

                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          // Press this button to edit a single product
                          IconButton(
                              icon: Icon(Icons.edit,size: 25,),
                              color: Colors.indigo,
                              onPressed: () =>
                                  _createOrUpdate(documentSnapshot)),
                          // This icon button is used to delete a single product
                          IconButton(
                              icon: Icon(Icons.delete,size: 25,),
                              color: Colors.indigo,
                              onPressed: () =>
                                  _deleteProduct(documentSnapshot.id)),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      // Add new product
      floatingActionButton: FloatingActionButton(
        onPressed: () => _createOrUpdate(),
        child: Icon(Icons.add),
      ),
    );
  }
}