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
        
        let questions: [QuestionViewModelProtocol] = qs.compactMap {
            switch ($0.option, $0.answer) {
            case (.string, .string), (.stringArray, .string), (.stringArray, .stringArray):
                return $0
            default:
                return nil
            }
        }
        .enumerated()
        .map { (index: Int, question: Question) -> QuestionViewModelProtocol in
            switch (question.option, question.answer) {
            case (.string, .string):
                return TextQuestionViewModel(index: index, question: question)
            case (.stringArray, .string):
                return RadioQuestionViewModel(index: index, question: question)
            case (.stringArray, .stringArray):
                return CheckboxQuestionViewModel(index: index, question: question)
            default:
                fatalError()
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
    "title": "理由",
    "option": [
      "Happy",
      "Swift",
      "Coding"
    ],
    "answer": null
  },
  {
    "title": "予定",
    "option": [
      "Happy",
      "Swift",
      "Coding"
    ],
    "answer": null
  },
  {
    "title": "ご意見、ご感想",
    "option": "Happy Swift Coding",
    "answer": ["Happy","Swift", "Coding"]
  },
    {
    "title": "ご意見、ご感想",
    "option": "Happy",
    "answer": null
  }
]
""".data(using: .utf8)!
