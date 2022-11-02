import 'dart:convert';
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;
import 'package:web_scraping/manage_questions.dart';
import 'package:web_scraping/question.dart';
import 'package:web_scraping/save_questions_data.dart';

void main() => runApp(MaterialApp(
	theme: ThemeData(
	accentColor: Colors.green,
	scaffoldBackgroundColor: Colors.green[100],
	primaryColor: Colors.green,
	),
	home: const MyApp()));

class MyApp extends StatefulWidget {
const MyApp({Key? key}) : super(key: key);
@override
_MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

	
// Strings to store the extracted Article titles
String result1 = 'Result 1';
String result2 = 'Result 2';
String result3 = 'Result 3';
String textInFile = '';
// boolean to show CircularProgressIndication
// while Web Scraping awaits
bool isLoading = false;
Question question=Question();
ManageQuestions mngQuestion= ManageQuestions();

Future<List<String>> extractData() async {
	
	// Getting the response from the targeted url
	// final response =
	// 	await http.Client().get(Uri.parse('https://www.geeksforgeeks.org/'));

  final response =
		await http.Client().get(Uri.parse('https://www.vietnamworks.com/cau-hoi-phong-van/Back-end-ik/'));
	
		// Status Code 200 means response has been received successfully
	if (response.statusCode == 200) {
		
	// Getting the html document from the response
	var document = parser.parse(response.body);
	try {
		
	// Scraping the first article title
  
  // question.setTitle=document
  
	// 		.getElementsByClassName('interview-question-wrapper')[0]
	// 		.children[0]
	// 		.children[0].text;
  // question.setContent=document
	// 		.getElementsByClassName('interview-question-wrapper')[0]
	// 		.children[0]
	// 		.children[1].text;
  // print(question.toString());
 
		var responseString1 = document
			.getElementsByClassName('interview-question-wrapper')[0]
			.children[0]
			.children[0];

		print(responseString1.text.trim());
		
    var responseString2 = document
			.getElementsByClassName('interview-question-wrapper')[0]
			.children[0]
			.children[1];

		print(responseString2.text.trim());


    //var responseString3=document.getElementsByClassName('interview-question-wrapper');
      var ldiv = document.getElementById('interview-question-wrapper');
      print(ldiv!.children.length);
      ldiv.children.forEach((element) {
        Question q=Question();
        q.setTitle=element.children[0].text;
        q.setContent=element.children[1].text;
        mngQuestion.addQuestion(q);
        // print('Title:'+ element.children[0].text);
        // print('Content:'+ element.children[1].text);

       // textInFile+=element.text;
      });
    
	// // Scraping the second article title
	// 	var responseString2 = document
	// 		.getElementsByClassName('interview-question-wrapper')[0]
	// 		.children[1]
	// 		.children[1]
	// 		.children[0];

	// 	print(responseString2.text.trim());
		
	// // Scraping the third article title
	// 	var responseString3 = document
	// 		.getElementsByClassName('interview-question-wrapper')[0]
	// 		.children[2]
	// 		.children[0]
	// 		.children[0];

	// 	print(responseString3.text.trim());
		
		// Converting the extracted titles into
		// string and returning a list of Strings
		return [
		responseString1.text.trim(),
		responseString2.text.trim(),
		// responseString3.text.trim()
		];
	} catch (e) {
		return ['', '', 'ERROR!'];
	}
	} else {
	return ['', '', 'ERROR: ${response.statusCode}.'];
	}
}



@override
Widget build(BuildContext context) {
	return Scaffold(
	appBar: AppBar(title: Text('GeeksForGeeks')),
	body: Padding(
		padding: const EdgeInsets.all(16.0),
		child: Center(
			child: Column(
		mainAxisAlignment: MainAxisAlignment.center,
		children: [
			
			// if isLoading is true show loader
			// else show Column of Texts
			isLoading
				? CircularProgressIndicator()
				: Column(
					children: [
					Text(result1,
						style: TextStyle(
							fontSize: 20, fontWeight: FontWeight.bold)),
					SizedBox(
						height: MediaQuery.of(context).size.height * 0.05,
					),
					Text(result2,
						style: TextStyle(
							fontSize: 20, fontWeight: FontWeight.bold)),
					SizedBox(
						height: MediaQuery.of(context).size.height * 0.05,
					),
					Text(result3,
						style: TextStyle(
							fontSize: 20, fontWeight: FontWeight.bold)),
          
					],
				),
			SizedBox(height: MediaQuery.of(context).size.height * 0.08),
			MaterialButton(
			onPressed: () async {
				
			// Setting isLoading true to show the loader
				setState(() {
				isLoading = true;
				});
				
				// Awaiting for web scraping function
				// to return list of strings
				final response = await extractData();
				
				// Setting the received strings to be
				// displayed and making isLoading false
				// to hide the loader
				setState(() {
				result1 = response[0];
        question.setTitle=response[0];
        // print('Title ${question.getTitle}');
        question.setContent=response[1];

        //SaveData.savedQuestions(question.toString());

        // print('Content ${question.getContent}');
        //mngQuestion.addQuestion(question);
        displayListQuestion(mngQuestion);
         mngQuestion.getList.forEach((e) async{
           textInFile += await question.toString();
         });
        //textInFile += question.toString();

                // prepare
                final bytes = utf8.encode(textInFile);
                final blob = html.Blob([bytes]);
                final url = html.Url.createObjectUrlFromBlob(blob);
                final anchor =
                    html.document.createElement('a') as html.AnchorElement
                      ..href = url
                      ..style.display = 'none'
                      ..download = 'some_name.txt';
                html.document.body!.children.add(anchor);

                // download
                anchor.click();

                // cleanup
                html.document.body!.children.remove(anchor);
                html.Url.revokeObjectUrl(url);
        
        // print(question.toString());
        // question.setTitle=response[0];
        // print(question.getTitle);
        // question.setContent=response[1];
        // print(question.getContent);
        //question.setContent=response[0];
        // print(question.toString());
				// result2 = response[1];
				// result3 = response[2];
				isLoading = false;
				});
			},
			child: Text(
				'Scrap Data',
				style: TextStyle(color: Colors.white),
			),
			color: Colors.green,
			)
		],
		)),
	),
	);
}

Future<void> displayListQuestion(ManageQuestions mng) async{
  for(var item in mng.getList){
    print(item.toString());
    textInFile+= await item.toString();
  }
}
}
