import 'package:web_scraping/question.dart';

class ManageQuestions{
  static final List<Question> questions=[];
  ManageQuestions();

  get getList{
    return questions;
  }
  int sizeList(){
    return questions.length;
  }

  void addQuestion(Question q){
    questions.add(q);
  }
}