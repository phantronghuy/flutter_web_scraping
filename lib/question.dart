
class Question{
  String? title;
  String? content;

  //Question(this.title,this.content);


  set setTitle(String title){
    this.title=title;
  }
  get getTitle{
    return this.title ?? 'null';
  }

  set setContent(String content){
    this.content=content;
  }

  String get getContent{
    return this.content??'null';
  }

  @override
  String toString() {
    return 'Title:${this.title} , ${this.content}';
  }
}