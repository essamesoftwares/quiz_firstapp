import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quiz_firstapp/models/question_model.dart';
import 'package:quiz_firstapp/quiz/result.dart';
import 'package:quiz_firstapp/services/database.dart';
import 'package:quiz_firstapp/widgets/quiz_play_widgets.dart';
import 'package:quiz_firstapp/widgets/widgets.dart';

class PlayQuiz extends StatefulWidget {
  final String quizId;
  PlayQuiz(this.quizId);
  @override
  _PlayQuizState createState() => _PlayQuizState();
}

int total = 0;
int _correct = 0;
int _incorrect = 0;
int _notAttempted = 0;

class _PlayQuizState extends State<PlayQuiz> {
  DatabaseService databaseService = new DatabaseService();
  QuerySnapshot questionsSnapshot;

  QuestionModel getQuestionModelFromDatasnapshot(
      DocumentSnapshot questionSnapshot) {
    QuestionModel questionModel = new QuestionModel();
    questionModel.question = questionSnapshot.data["question"];
    questionModel.questionUrl = questionSnapshot.data["questionUrl"];
    List<String> options = [
      questionSnapshot.data["option1"],
      questionSnapshot.data["option2"],
      questionSnapshot.data["option3"],
      questionSnapshot.data["option4"],
    ];
    List<String> optionsUrl = [
      questionSnapshot.data["option1Url"],
      questionSnapshot.data["option2Url"],
      questionSnapshot.data["option3Url"],
      questionSnapshot.data["option4Url"]
    ];

    options.shuffle();
    optionsUrl.shuffle();

    questionModel.option1 = options[0];
    questionModel.option2 = options[1];
    questionModel.option3 = options[2];
    questionModel.option4 = options[3];
    questionModel.option1Url = optionsUrl[0];
    questionModel.option2Url = optionsUrl[1];
    questionModel.option3Url = optionsUrl[2];
    questionModel.option4Url = optionsUrl[3];
    questionModel.correctOption = questionSnapshot.data["option1"];
    questionModel.answered = false;

    return questionModel;
  }

  @override
  void initState() {
    print("${widget.quizId}");
    databaseService.getQuizData(widget.quizId).then((value) {
      questionsSnapshot = value;
      _notAttempted = 0;
      _correct = 0;
      _incorrect = 0;
      total = questionsSnapshot.documents.length;
      print("$total this is total");
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black54),
        brightness: Brightness.light,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              questionsSnapshot == null
                  ? Container(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: questionsSnapshot.documents.length,
                      itemBuilder: (context, index) {
                        return QuizPlayTile(
                          questionModel: getQuestionModelFromDatasnapshot(
                              questionsSnapshot.documents[index]),
                          index: index,
                        );
                      })
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => Results(
                        correct: _correct,
                        incorrect: _incorrect,
                        total: total,
                      )));
        },
      ),
    );
  }
}

class QuizPlayTile extends StatefulWidget {
  final QuestionModel questionModel;
  final int index;
  QuizPlayTile({this.questionModel, this.index});

  @override
  _QuizPlayTileState createState() => _QuizPlayTileState();
}

class _QuizPlayTileState extends State<QuizPlayTile> {
  String optionSelected = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Q${widget.index + 1} ${widget.questionModel.question}",
            style: TextStyle(fontSize: 17, color: Colors.black87),
          ),
          Image.network(
            "${widget.questionModel.questionUrl}",
            width: MediaQuery.of(context).size.width - 48,
            fit: BoxFit.cover,
          ),
          SizedBox(
            height: 12,
          ),
          GestureDetector(
            onTap: () {
              if (!widget.questionModel.answered) {
                ///correct
                if (widget.questionModel.option1 ==
                    widget.questionModel.correctOption) {
                  setState(() {
                    optionSelected = widget.questionModel.option1;
                    widget.questionModel.answered = true;
                    _correct = _correct + 1;
                    _notAttempted = _notAttempted + 1;
                  });
                } else {
                  setState(() {
                    optionSelected = widget.questionModel.option1;
                    widget.questionModel.answered = true;
                    _incorrect = _incorrect + 1;
                    _notAttempted = _notAttempted - 1;
                  });
                }
              }
            },
            child: OptionTile(
              correctAnswer: widget.questionModel.correctOption,
              description: "${widget.questionModel.option1}",
              option: "A",
              optionSelected: optionSelected,
            ),
          ),
          Image.network(
            "${widget.questionModel.option1Url}",
            width: MediaQuery.of(context).size.width - 300,
            fit: BoxFit.cover,
          ),
          SizedBox(
            height: 4,
          ),
          GestureDetector(
            onTap: () {
              if (!widget.questionModel.answered) {
                ///correct
                if (widget.questionModel.option2 ==
                    widget.questionModel.correctOption) {
                  setState(() {
                    optionSelected = widget.questionModel.option2;
                    widget.questionModel.answered = true;
                    _correct = _correct + 1;
                    _notAttempted = _notAttempted + 1;
                  });
                } else {
                  setState(() {
                    optionSelected = widget.questionModel.option2;
                    widget.questionModel.answered = true;
                    _incorrect = _incorrect + 1;
                    _notAttempted = _notAttempted - 1;
                  });
                }
              }
            },
            child: OptionTile(
              correctAnswer: widget.questionModel.correctOption,
              description: "${widget.questionModel.option2}",
              option: "B",
              optionSelected: optionSelected,
            ),
          ),
          Image.network(
            "${widget.questionModel.option2Url}",
            width: MediaQuery.of(context).size.width - 300,
            fit: BoxFit.cover,
          ),
          SizedBox(
            height: 4,
          ),
          GestureDetector(
            onTap: () {
              if (!widget.questionModel.answered) {
                ///correct
                if (widget.questionModel.option3 ==
                    widget.questionModel.correctOption) {
                  setState(() {
                    optionSelected = widget.questionModel.option3;
                    widget.questionModel.answered = true;
                    _correct = _correct + 1;
                    _notAttempted = _notAttempted + 1;
                  });
                } else {
                  setState(() {
                    optionSelected = widget.questionModel.option3;
                    widget.questionModel.answered = true;
                    _incorrect = _incorrect + 1;
                    _notAttempted = _notAttempted - 1;
                  });
                }
              }
            },
            child: OptionTile(
              correctAnswer: widget.questionModel.correctOption,
              description: "${widget.questionModel.option3}",
              option: "C",
              optionSelected: optionSelected,
            ),
          ),
          Image.network(
            "${widget.questionModel.option3Url}",
            width: MediaQuery.of(context).size.width - 300,
            fit: BoxFit.cover,
          ),
          SizedBox(
            height: 4,
          ),
          GestureDetector(
            onTap: () {
              if (!widget.questionModel.answered) {
                ///correct
                if (widget.questionModel.option4 ==
                    widget.questionModel.correctOption) {
                  setState(() {
                    optionSelected = widget.questionModel.option4;
                    widget.questionModel.answered = true;
                    _correct = _correct + 1;
                    _notAttempted = _notAttempted + 1;
                  });
                } else {
                  setState(() {
                    optionSelected = widget.questionModel.option4;
                    widget.questionModel.answered = true;
                    _incorrect = _incorrect + 1;
                    _notAttempted = _notAttempted - 1;
                  });
                }
              }
            },
            child: OptionTile(
              correctAnswer: widget.questionModel.correctOption,
              description: "${widget.questionModel.option4}",
              option: "D",
              optionSelected: optionSelected,
            ),
          ),
          Image.network(
            "${widget.questionModel.option4Url}",
            width: MediaQuery.of(context).size.width - 300,
            fit: BoxFit.cover,
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
