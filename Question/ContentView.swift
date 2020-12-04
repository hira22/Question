//
//  ContentView.swift
//  Question
//
//  Created by hiraoka on 2020/11/16.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        let qs: [Question] = try! JSONDecoder().decode([Question].self, from: json)
        
        let questions: [QuestionViewModelProtocol] = qs.enumerated()
        .map { (index: Int, question: Question) -> QuestionViewModelProtocol in
            let index = index + 1
            switch (question.option?.selection, question.option?.placeholder) {
            case (.none, _):
                return TextQuestionViewModel(index: index, question: question)
            case (.stringArray, .single):
                return RadioQuestionViewModel(index: index, question: question)
            case (.stringArray, .multiple), (.stringArray, .none):
                return CheckboxQuestionViewModel(index: index, question: question)
            }
        }
        
        QuestionView(questions: questions)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

let json: Data = """
[
  {
    "title": "Question 1",
    "subtitle": "Question 1 subtitle",
    "option": {
        "selection": [
            "Happy",
            "Swift",
            "Coding"
        ],
        "placeholder": [
            "Happy"
        ]
    }
  },
  {
    "title": "Question 2",
    "option": {
        "selection": [
            "Happy",
            "Swift",
            "Coding"
        ],
        "placeholder": "Swift"
    }
  },
  {
    "title": "Question 3",
    "option": {
        "selection": null,
        "placeholder": "Swift"
    }
  }
]
""".data(using: .utf8)!
