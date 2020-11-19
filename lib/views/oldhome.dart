import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:quiz_firstapp/widgets/widgets.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Widget makeImagesGrid() {
    return GridView.builder(
        itemCount: 10,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          return ImageGridItem(index);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        brightness: Brightness.light,
      ),
      body: Container(
        child: makeImagesGrid(),
      ),
    );
  }
}

class ImageGridItem extends StatefulWidget {
  int _index;

  ImageGridItem(int index) {
    this._index = index;
  }

  @override
  _ImageGridItemState createState() => _ImageGridItemState();
}

class _ImageGridItemState extends State<ImageGridItem> {
  Uint8List imageFile;

  StorageReference photosReference =
      FirebaseStorage.instance.ref().child("photos");

  getImage() {
    int MAX_SIZE = 7 * 1024 * 1024;
    photosReference
        .child("image ${widget._index}.jpg")
        .getData(MAX_SIZE)
        .then((data) {
      this.setState(() {
        imageFile = data;
      });
    }).catchError((error) {});
  }

  Widget decideGridTileWidget() {
    if (imageFile == null) {
      return Center(child: Text("No Data"));
    } else {
      return Image.memory(imageFile, fit: BoxFit.cover);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getImage();
  }

  @override
  Widget build(BuildContext context) {
    return GridTile(child: decideGridTileWidget());
  }
}
