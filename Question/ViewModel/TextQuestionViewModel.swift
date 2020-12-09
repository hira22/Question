//
//  TextQuestionViewModel.swift
//  Question
//
//  Created by hiraoka on 2020/11/19.
//

import Foundation

class TextQuestionViewModel: QuestionViewModelProtocol, ObservableObject, QuestionAnswerable {
    var index: Int
    var title: String?
    var subtitle: String?

    typealias Selection = String
    typealias Answer = String
    
    var selections: Selection? = nil
    var placeholder: Answer?
    @Published var answer: Answer = ""
    
    init(index: Int, question: Question) {
        self.index = index
        self.title = question.title
        self.subtitle = question.subtitle
        if case .text(let option) = question.input,
           let text = option as? Input.Text {
            self.placeholder = text.placeholder
        }
    }
    
    init(index: Int, title: String, placeholder: Answer, answer: Answer) {
        self.index = index
        self.title = title
        self.placeholder = placeholder
        self.answer = answer
    }
}

extension TextQuestionViewModel {
    func asQuestion() -> Question {
        Question(title: title, subtitle: subtitle, input: .text(option: Input.Text(placeholder: placeholder)), answer: .single(answer))
    }
}
