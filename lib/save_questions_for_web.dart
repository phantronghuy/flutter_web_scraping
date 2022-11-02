import 'dart:html' as webFile;
import 'package:flutter/foundation.dart' show kIsWeb;
class SavedQuestionsWeb{
   
   Future<void> downLoadFile() async{
    if (kIsWeb) {
   var blob = webFile.Blob(["data"], 'text/plain', 'native');

   var anchorElement = webFile.AnchorElement(
      href: webFile.Url.createObjectUrlFromBlob(blob).toString(),
   )..setAttribute("download", "data.txt")..click();
} 
   }
}