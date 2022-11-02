import 'package:path_provider/path_provider.dart';
import 'dart:io';
class SaveData{
  static Future<String> get getFilePath async{
    
    final Directory directory = await getApplicationSupportDirectory();
    print(directory.path);
    return directory.path;
  }

  static Future<File?> get getFile async{
    final path= await getFilePath;
    print('$path/questions.txt');
    return File('$path/questions.txt');
  }

  static Future<String> readQuestions() async{
    try{
      final file=await getFile;
      String fileContent= await file!.readAsString();
      return fileContent;
    }
    catch( e){
      print(' Error: ${e.toString()}');
      return 'Error';
    }
  }

  static Future<File> savedQuestions(String questions) async{
    final file= await getFile;
    return file!.writeAsString(questions);
  }
}