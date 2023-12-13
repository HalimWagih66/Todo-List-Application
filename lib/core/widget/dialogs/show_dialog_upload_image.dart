import 'package:flutter/material.dart';

Future<void> showDialogUploadImage({required BuildContext context,required Function onPressedCamera,required Function onPressedGallery}) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return  AlertDialog(
          title: const Text("Upload Image",textAlign: TextAlign.center,),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(onPressed: ()async=> await onPressedCamera()
              , icon: const Icon(Icons.camera_alt,size: 50),),
              IconButton(onPressed: ()async =>await onPressedGallery(),
                icon: const Icon(Icons.image_sharp,size: 50,),),
            ],
          )
      );
    },
  );
}