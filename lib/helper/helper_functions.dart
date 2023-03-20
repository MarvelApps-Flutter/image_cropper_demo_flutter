// import 'dart:developer';
// import 'dart:io';

// import 'package:image_cropper/image_cropper.dart';
// import 'package:image_picker/image_picker.dart';

// Future<File?> pickImage(ImageSource imageType) async {
//   File? tempImage;
//   try {
//     final photo =
//         await ImagePicker().pickImage(source: imageType, imageQuality: 100);
//     if (photo == null) return null;
//     // final tempImage = File(photo.path);
//     tempImage = File(photo.path);

//     tempImage = await _cropImage(imageFile: tempImage);
//     // setState(() {
//     //   pickedImage = tempImage;
//     // });
//   } catch (error) {
//     log(error.toString());
//   }
//   return tempImage;
// }

// Future<File?> _cropImage({required File imageFile}) async {
//   try {
//     CroppedFile? croppedImg = await ImageCropper().cropImage(
//         sourcePath: imageFile.path,
//         // maxHeight: 140,
//         // maxWidth: 240,
//         aspectRatio: CropAspectRatio(
//           ratioX: 16,
//           ratioY: 9,
//         ),
//         compressQuality: 100);

//     if (croppedImg == null) {
//       return null;
//     } else {
//       return File(croppedImg.path);
//     }
//   } catch (e) {
//     print(e);
//     // return ;
//   }
// }
