import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snapkit/snapkit.dart';
import 'dart:async';

class ImageContainer extends StatefulWidget {
  final String id;

  const ImageContainer({Key? key, required this.id}) : super(key: key);

  @override
  State<ImageContainer> createState() => _ImageContainerState();
}

class _ImageContainerState extends State<ImageContainer> {
  File? image;
  String? fileName;
  String? appPath;
  String? key;
  Snapkit snapkit = Snapkit();

  @override
  void initState() {
    super.initState();

    getDir();
  }

  getDir() async {
    Directory appDir = await getApplicationDocumentsDirectory();

    setState(() {
      appPath = appDir.path;
    });

    print(appPath);
  }

  @override
  Widget build(BuildContext context) {
    Future pickImage() async {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;

      final imageTemp = File(image.path);

      setState(() => this.image = imageTemp);
      final Directory extDir = await getApplicationDocumentsDirectory();
      String dirPath = extDir.path;
      var fileName = widget.id;
      final File localImage = await imageTemp.copy('$dirPath/$fileName.jpg');
    }

    Future sendPhoto() async {
      snapkit.share(
        SnapchatMediaType.PHOTO,
        image: FileImage(
          File('$appPath/${widget.id}.jpg'),
        ),
      );
    }

    return GestureDetector(
        onTap: () {
          pickImage();
        },
        child: (File('$appPath/${widget.id}.jpg').existsSync())
            ? Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: FileImage(
                        File('$appPath/${widget.id}.jpg'),
                      ),
                      fit: BoxFit.cover,
                    ),
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(5)),
                child: Align(
                  alignment: FractionalOffset.bottomLeft,
                  child: MaterialButton(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(5),
                          bottomRight: Radius.circular(5),
                        ),
                      ),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      minWidth: double.infinity,
                      color: Colors.yellow,
                      onPressed: () {
                        sendPhoto();
                      },
                      child: const Text('SNAPPER')),
                ))
            : Container(
                decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(5)),
                child: Align(
                  alignment: FractionalOffset.bottomLeft,
                  child: MaterialButton(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(5),
                          bottomRight: Radius.circular(5),
                        ),
                      ),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      minWidth: double.infinity,
                      color: Colors.yellow,
                      onPressed: () {},
                      child: const Text('SNAPPER')),
                )));
  }
}
